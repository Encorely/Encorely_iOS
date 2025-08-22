//
//  Font.swift
//  Encorely
//
//  Created by 이예지 on 7/15/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretendard {
        case semibold
        case bold
        case regular
        case medium
        
        var value: String {
            switch self {
            case .semibold:
                return "Pretendard-SemiBold"
            case .bold:
                return "Pretendard-Bold"
            case .regular:
                return "Pretendard-Regular"
            case .medium:
                return "Pretendard-Medium"
            }
        }
    }
    
    static func pretendard(type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    // MARK: - Bold
    static var mainTextBold24: Font {
        return .pretendard(type: .bold, size: 24)
    }
    
    static var mainTextBold22: Font {
        return .pretendard(type: .bold, size: 22)
    }
    
    static var mainTextBold20: Font {
        return .pretendard(type: .bold, size: 20)
    }
    
    static var mainTextBold16: Font {
        return .pretendard(type: .bold, size: 16)
    }
    
    // MARK: - SemiBold
    static var mainTextSemiBold38: Font {
        return .pretendard(type: .semibold, size: 38)
    }
    
    static var mainTextSemiBold32: Font {
        return .pretendard(type: .semibold, size: 32)
    }
    
    static var mainTextSemiBold24: Font {
        return .pretendard(type: .semibold, size: 24)
    }
    
    static var mainTextSemiBold22: Font {
        return .pretendard(type: .semibold, size: 22)
    }
    
    static var mainTextSemiBold20: Font {
        return .pretendard(type: .semibold, size: 20)
    }
    
    static var mainTextSemiBold18: Font {
        return .pretendard(type: .semibold, size: 18)
    }
    
    static var mainTextSemiBold16: Font {
        return .pretendard(type: .semibold, size: 16)
    }
    
    static var mainTextSemiBold14: Font {
        return .pretendard(type: .semibold, size: 14)
    }
    
    static var mainTextSemiBold13: Font {
        return .pretendard(type: .semibold, size: 13)
    }
    
    static var mainTextSemiBold12: Font {
        return .pretendard(type: .semibold, size: 12)
    }
    
    // MARK: - Regular
    
    static var mainTextRegular18: Font {
        return .pretendard(type: .regular, size: 18)
    }
    
    static var mainTextRegular16: Font {
        return .pretendard(type: .regular, size: 16)
    }
    
    static var mainTextRegular13: Font {
        return .pretendard(type: .regular, size: 13)
    }
    
    static var mainTextRegular12: Font {
        return .pretendard(type: .regular, size: 12)
    }
    
    static var mainTextRegular09: Font {
        return .pretendard(type: .regular, size: 9)
    }
    
    // MARK: - Medium
    static var mainTextMedium20: Font {
        return .pretendard(type: .medium, size: 20)
    }
    
    static var mainTextMedium18: Font {
        return .pretendard(type: .medium, size: 18)
    }
    
    static var mainTextMedium17: Font {
        return .pretendard(type: .medium, size: 17)
    }
    
    static var mainTextMedium16: Font {
        return .pretendard(type: .medium, size: 16)
    }
    
    static var mainTextMedium15: Font {
        return .pretendard(type: .medium, size: 15)
    }
    
    static var mainTextMedium14: Font {
        return .pretendard(type: .medium, size: 14)
    }
    
    static var mainTextMedium13: Font {
        return .pretendard(type: .medium, size: 13)
    }
    
    static var mainTextMedium12: Font {
        return .pretendard(type: .medium, size: 12)
    }
    
    static var mainTextMedium11: Font {
        return .pretendard(type: .medium, size: 11)
    }
    
    static var mainTextMedium10: Font {
        return .pretendard(type: .medium, size: 10)
    }
    
    static var mainTextMedium8: Font {
        return .pretendard(type: .medium, size: 8)
    }
}
