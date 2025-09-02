//
//  AuthPlugin.swift
//  Encorely
//
//  Created by 이예지 on 8/23/25.
//

import Foundation
import Moya

struct AuthPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var req = request
        if let t = TokenStore.shared.accessToken, !t.isEmpty {
            req.setValue("Bearer \(t)", forHTTPHeaderField: "Authorization")
        }
        return req
    }
}
