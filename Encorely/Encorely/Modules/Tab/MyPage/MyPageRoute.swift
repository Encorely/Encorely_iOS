//
//  MyPageRoute.swift
//  Encorely
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

enum MyPageRoute: Hashable {
    case setting
    case scrapbook
    case alarm
    case followerList
    case followingList
    case profileSetting

    // 스크랩 하위
    case basicFolder
    case myFolder1

    // 설정 하위
    case notice
    case blockedList
}
