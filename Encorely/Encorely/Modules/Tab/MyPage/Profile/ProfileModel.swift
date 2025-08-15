//
//  ProfileModel.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

struct Profile: Equatable {
    var imageData: Data?   // 이미지 자체는 Data로만 보관
    var nickname: String
    var introduction: String
    var link: String
}
