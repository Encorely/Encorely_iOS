import Foundation

// MARK: - Request DTO (예: 이메일/비번 로그인. 소셜이면 필요 X)
struct LoginRequestDTO: Codable {
    let email: String
    let password: String
}

// MARK: - Response DTO
// 서버가 snake_case라면 CodingKeys로 매핑하세요.
struct LoginResponseDTO: Codable {
    let accessToken: String
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken  = "access_token"   // swagger가 access_token이면 이렇게 둠
        case refreshToken = "refresh_token"  // 동일
    }
}

// MARK: - 앱 도메인 모델 (전역에서 쓰는 토큰 타입)
struct AuthTokens: Codable, Equatable, Sendable {
    let access: String
    let refresh: String?
}

// MARK: - Mapping
extension LoginResponseDTO {
    func toDomain() -> AuthTokens {
        AuthTokens(access: accessToken, refresh: refreshToken)
    }
}
