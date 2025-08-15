//
//  AlarmRepository.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

protocol AlarmRepository {
    func fetchUnreadAlarms() async throws -> [AlarmItem]
    func fetchRecentAlarms() async throws -> [AlarmItem]
}
