//
//  S3Service.swift
//  Encorely
//
//  Created by 이예지 on 8/13/25.
//

import Foundation
import Moya
import SwiftUI

// MARK: S3Service
@Observable
class S3Service {
    
    private let provider: MoyaProvider<S3Router>
    
    // 상태 관리
    var isLoading: Bool = false
    var uploadProgress: Double = 0.0
    var errorMessage: String?
    
    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        self.provider = MoyaProvider<S3Router>(plugins: [logger])
    }
    
    /// GET Method
    func getPresignedURL(fileName: String, contentType: String) async throws -> PresignedUrlResponse {
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getPresignedURL(fileName: fileName, contentType: contentType)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(PresignedUrlResponse.self, from: response.data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// POST Method
    func uploadComplete(key: String) async throws -> UploadCompleteResponse {
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.uploadComplete(key: key)) {
                result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(UploadCompleteResponse.self, from: response.data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    // MARK: - 통합 이미지 업로드 메서드
    func uploadImage(_ imageData: Data, fileName: String) async throws -> String {
        isLoading = true
        uploadProgress = 0.0
        defer {
            isLoading = false
            uploadProgress = 0.0
        }
        
        do {
            // 1. Presigned URL 요청
            uploadProgress = 0.3
            let presignedResponse = try await getPresignedURL(
                fileName: fileName,
                contentType: "image/jpeg"
            )
            
            guard presignedResponse.isSuccess else {
                throw S3Error.presignedURLFailed(presignedResponse.message)
            }
            
            // 2. S3에 실제 이미지 업로드
            uploadProgress = 0.7
            try await uploadToS3(
                imageData: imageData,
                presignedURL: presignedResponse.result.url
            )
            
            // 3. 업로드 완료 알림
            uploadProgress = 0.9
            let completeResponse = try await uploadComplete(key: presignedResponse.result.key)
            
            guard completeResponse.isSuccess else {
                throw S3Error.uploadCompleteFailed(completeResponse.message)
            }
            
            uploadProgress = 1.0
            
            // 최종 이미지 URL 반환
            return completeResponse.result.imageUrl
            
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
    
    // MARK: - 여러 이미지 업로드
        /// UIImage 배열을 받아서 업로드
        func uploadImages(_ images: [UIImage], imageType: String) async throws -> [String] {
            var uploadedURLs: [String] = []
            
            for (index, image) in images.enumerated() {
                guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                    throw S3Error.invalidImageData
                }
                
                let fileName = "\(imageType)_\(Date().timeIntervalSince1970)_\(index).jpg"
                let imageURL = try await uploadImage(imageData, fileName: fileName)
                uploadedURLs.append(imageURL)
            }
            
            return uploadedURLs
        }
        
        // MARK: - S3 직접 업로드 (Private)
        /// Presigned URL을 사용하여 S3에 직접 업로드
        private func uploadToS3(imageData: Data, presignedURL: String) async throws {
            guard let url = URL(string: presignedURL) else {
                throw S3Error.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
            
            let (_, response) = try await URLSession.shared.upload(for: request, from: imageData)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                throw S3Error.uploadFailed
            }
        }
    }

    // MARK: - S3 Error
    enum S3Error: LocalizedError {
        case invalidURL
        case uploadFailed
        case presignedURLFailed(String)
        case uploadCompleteFailed(String)
        case invalidImageData
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "잘못된 URL입니다"
            case .uploadFailed:
                return "이미지 업로드에 실패했습니다"
            case .presignedURLFailed(let message):
                return "업로드 URL 요청 실패: \(message)"
            case .uploadCompleteFailed(let message):
                return "업로드 완료 알림 실패: \(message)"
            case .invalidImageData:
                return "올바르지 않은 이미지 데이터입니다"
            }
        }
    }


// MARK: Error & Utility
extension S3Service {
    /// 에러 메시지 초기화
    func clearError() {
        errorMessage = nil
    }
    
    /// 업로드 진행률 초기화
    func resetProgress() {
        uploadProgress = 0.0
    }
}
