import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    var onFinish: () -> Void

    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingPageView(
                imageName: "splash_1",
                text: "공연 가기 전 정보들을 편리하게 찾고!",
                buttonText: "다음",
                action: { currentPage += 1 },
                currentPage: $currentPage,
                pageIndex: 0
            )
            .tag(0)

            OnboardingPageView(
                imageName: "splash_2",
                text: "공연이 끝난 후엔 후기 작성까지!",
                buttonText: "다음",
                action: { currentPage += 1 },
                currentPage: $currentPage,
                pageIndex: 1
            )
            .tag(1)

            OnboardingPageView(
                imageName: "splash_3",
                text: "내가 작성한 후기들을 친구들과 나눠요",
                buttonText: "시작하기",
                action: onFinish,
                currentPage: $currentPage,
                pageIndex: 2
            )
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview("Onboarding - 기본") {
    OnboardingView(onFinish: { /* 프리뷰에선 아무 것도 안 함 */ })
}
