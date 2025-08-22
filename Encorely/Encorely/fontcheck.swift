//
//  fontcheck.swift
//  Encorely
//
//  Created by 이예지 on 8/21/25.
//

// FontRegistrar.swift
import UIKit
import CoreText

enum FontRegistrar {
  static let files = [
    ("Pretendard-Regular","otf"),
    ("Pretendard-Medium","otf"),
    ("Pretendard-SemiBold","otf"),
    ("Pretendard-Bold","otf")
  ]
  static func registerAll() {
    for (name, ext) in files {
      guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
        print("❌ NOT IN BUNDLE: \(name).\(ext)")
        continue
      }
      var err: Unmanaged<CFError>?
      if !CTFontManagerRegisterFontsForURL(url as CFURL, .process, &err) {
        print("⚠️ Register failed or already: \(name) \(String(describing: err))")
      } else {
        print("✅ Registered: \(name)")
      }
    }
  }
  static func dumpPretendard() {
    for n in UIFont.fontNames(forFamilyName: "Pretendard").sorted() { print("  - \(n)") }
  }
}
