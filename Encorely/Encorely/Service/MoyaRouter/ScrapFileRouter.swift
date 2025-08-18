//
//  ScrapFileRouter.swift
//  Encorely
//
//  Created by 이민서 on 8/18/25.
//

import Foundation
import Moya

enum ScrapFileAPI {
    ///스크랩 리뷰 폴더 이동
    case moveReviewToFolder(scrapReviewId: Int, targetScrapFileId: Int)
    
    ///스크랩북 전체 폴더 불러오기
    case getAllFolders
    
    ///스크랩 폴더 추가
    case addFolder
    
    ///스크랩 폴더에 리뷰 등록/스크랩 취소
    case registAndCancelReview(fileId: Int, reviewId: Int, category: String, scrapped: Bool)
    
    ///폴더 내 리뷰 불러오기
    case getReviewInFolder(fileId: Int, hallId: Int, categories: [String], sort: String)
    
    ///폴더 삭제
    case deleteFolder(fileId: Int)
    
    ///스크랩 폴더 이름 변경
    case renameFolder(fileId: Int, name: String)
}

extension ScrapFileAPI: BaseTarget {
    var path: String {
        switch self {
        case .moveReviewToFolder(_, _):
            return "/api/files/move"
            
        case .getAllFolders:
            return "/api/files"
            
        case .addFolder:
            return "/api/files"
            
        case let .registAndCancelReview(fileId, _, _, _):
            return "/api/files/\(fileId)/review"
            
        case let .getReviewInFolder(fileId, _, _, _):
            return "/api/files/\(fileId)"
            
        case let .deleteFolder(fileId):
            return "/api/files/\(fileId)"
            
        case let .renameFolder(fileId, _):
            return "/api/files/\(fileId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .moveReviewToFolder:
            return .put
        case .getAllFolders, .getReviewInFolder:
            return .get
        case .addFolder, .registAndCancelReview:
            return .post
        case .deleteFolder:
            return .delete
        case .renameFolder:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .getAllFolders, .addFolder, .deleteFolder:
            return .requestPlain
            
        case let .moveReviewToFolder(scrapReviewId, targetScrapFileId):
            return .requestParameters(
                parameters: ["scrapReviewId":scrapReviewId, "targetScrapFileId":targetScrapFileId],
                encoding: URLEncoding.default
            )
            
        case let .registAndCancelReview(_, reviewId, category, scrapped):
            let body : [String: Any] = ["reviewId":reviewId, "category":category, "scrapped":scrapped]
            return .requestParameters(
                parameters: body,
                encoding: JSONEncoding.default
                )
            
        case let .getReviewInFolder(_, hallId, categories, sort):
            return .requestParameters(
                parameters: ["hallId":hallId, "categories":categories, "sort":sort],
                encoding: URLEncoding.queryString
            )
            
        case .renameFolder(_, _):
            let body : [String: Any] = ["name":"name"]
            return .requestParameters(
                parameters: body,
                encoding: JSONEncoding.default
            )
        }
    }
}
