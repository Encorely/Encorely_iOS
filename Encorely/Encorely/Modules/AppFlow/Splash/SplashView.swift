import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            // MARK: - 수직 그라데이션 (5단 컬러 구간)
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color("mainColorB"), location: 0.0),
                    .init(color: Color("mainColorA"), location: 0.15),
                    .init(color: Color("grayColorA"), location: 0.4),
                    .init(color: Color("grayColorA"), location: 0.6),
                    .init(color: Color("mainColorA"), location: 0.85),
                    .init(color: Color("mainColorB"), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // MARK: - 이미지 구성
            ZStack {
                // ⭐️ 별 5개
                Image("splash4") // 왼쪽 위
                    .resizable()
                    .frame(width: 150, height: 142)
                    .position(x: 70, y: 202)

                Image("splash5") // 오른쪽 위
                    .resizable()
                    .frame(width: 48, height: 47)
                    .position(x: 310, y: 215)

                Image("splash7") // 왼쪽 아래
                    .resizable()
                    .frame(width: 28, height: 28)
                    .position(x: 80, y: 433)

                Image("splash8") // 오른쪽 아래
                    .resizable()
                    .frame(width: 209, height: 197)
                    .position(x: 310, y: 520)

                Image("splash6") // 오른쪽 가운데
                    .resizable()
                    .frame(width: 28, height: 28)
                    .position(x: 353, y: 300)

                // 🔄 링 2개
                Image("splash2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 340)
                    .position(x: UIScreen.main.bounds.width / 2, y: 330)

                Image("splash3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 341,height: 126)
                    .position(x: UIScreen.main.bounds.width / 2, y: 330)

                // 🪐 로고
                Image("splash1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 279,height: 63)
                    .position(x: UIScreen.main.bounds.width / 2, y: 330)
            }
        }
    }
}

#Preview {
    SplashView()
}
