//
//  EncorelyTabView.swift
//  Encorely
//
//  Created by 이예지 on 7/8/25.
//

import SwiftUI

// UITabBarController 스타일 확장 (그림자)
extension UITabBarController {
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 그림자
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        tabBar.layer.shadowRadius = 6
        tabBar.layer.shadowOpacity = 0.15
    }
}

struct EncorelyTabView: View {
    
    @State var tabcase: TabCase = .venue
    @EnvironmentObject var container: DIContainer
    @State private var showSheet: SheetType? = nil
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destination, root: {
            TabView(selection: $tabcase) {
                ForEach(TabCase.allCases, id: \.rawValue) { tab in
                    tabView(tab: tab)
                        .tag(tab)
                        .tabItem {
                            tabLabel(tab)
                        }
                }
            }
            .tint(Color.mainColorD)
            .onAppear {
                setupTabBarAppearance()
            }
            .navigationDestination(for: NavigationDestination.self, destination: { destination in
                NavigationRoutingView(
                    destination: destination,
                    showSheet: $showSheet,
                    onComplete: {}
                )
                .environmentObject(container)
            })
        })
    }

    /// 탭 라벨 UI
    private func tabLabel(_ tab: TabCase) -> some View {
        VStack(spacing: 8) { // ← 아이콘 위 간격 늘림
            tab.icon
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(Color.grayColorG)
                .frame(width: 30, height: 30)
            
            Text(tab.rawValue)
                .font(.mainTextMedium12)
                .foregroundStyle(Color.grayColorG)
        }
    }
    
    /// 각 탭에 해당하는 뷰
    @ViewBuilder
    private func tabView(tab: TabCase) -> some View {
        switch tab {
        case .venue:
            MainHomeView()
                .environmentObject(container)
        case .regist:
            MainReviewRegistView()
                .environmentObject(container)
        case .mypage:
            MyPageView()
                .environmentObject(container)
        }
    }
    
    /// 탭바 스타일
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}


#Preview {
    EncorelyTabView(tabcase: .venue)
        .environmentObject(DIContainer())
}
