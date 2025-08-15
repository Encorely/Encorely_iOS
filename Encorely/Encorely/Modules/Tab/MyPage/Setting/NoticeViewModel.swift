//
//  NoticeViewModel.swift
//  UMCPractice
//
//  Created by Kehyuk on 8/13/25.
//

import Foundation

struct Notice: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let content: [String]
}

final class NoticeViewModel: ObservableObject {
    @Published var notices: [Notice] = [
        Notice(
            title: "[공지] 스포일러 주의",
            date: "25.07.21(월)",
            content: [
                "안녕하세요, 팬 여러분.",
                "콘서트의 감동을 함께 나누고 싶은 마음으로 후기를 작성해주셔서 감사합니다. 모두가 즐겁고 건강한 커뮤니티 문화를 만들어가기 위해 아래 가이드를 꼭 확인해 주세요.",
                "",
                "1. 스포일러 주의\n다른 팬들의 관람 재미를 위해 무대 구성, 세트리스트, 깜짝 이벤트 등 중요한 내용에는 스포일러 표시를 꼭 해주세요!\n예: [스포주의] / [무대 스포 있음]",
                "",
                "2. 존중하는 언어 사용\n욕설, 비방, 타인 비하, 특정 멤버나 팬덤에 대한 악의적 표현은 금지됩니다. 따뜻한 마음으로 후기를 공유해주세요.",
                "",
                "3. 공식 허용 범위 내 사진·영상 업로드\n공식적으로 촬영 허용된 구역/콘텐츠만 올려주세요. 공연 중 무단 촬영물, 유출 자료는 엄격히 금지됩니다.",
                "",
                "4. 구체적이고 진솔한 후기 권장\n간단한 한 줄평도 좋지만, 현장 분위기, 감동 포인트, 인상 깊었던 순간 등을 구체적으로 적어주시면 더 많은 팬들과 공감할 수 있어요.",
                "",
                "모두의 즐거운 콘서트 후기를 위해 팬 여러분의 협조를 부탁드려요!\n감사합니다."
            ]
        ),
        Notice(title: "[공지] 서비스 점검 안내", date: "25.07.17(목)", content: []),
        Notice(title: "[공지] 공지는 이렇게 적으면 됩니다요", date: "25.07.17(목)", content: [])
    ]

    @Published var expandedID: UUID? = nil

    func toggle(_ id: UUID) {
        expandedID = (expandedID == id) ? nil : id
    }
}
