//
//  fontcheck.swift
//  Encorely
//
//  Created by 이예지 on 8/21/25.
//

import UIKit

func dumpFonts() {
    for family in UIFont.familyNames.sorted() {
        print("Family: \(family)")
        for name in UIFont.fontNames(forFamilyName: family).sorted() {
            print("  - \(name)")
        }
    }
}
