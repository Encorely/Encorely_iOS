import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    /// 로그인 성공 시 상위 라우터에게 알림
    var onLoginSuccess: () -> Void

    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color("mainColorB"), location: 0.0),
                    .init(color: Color("mainColorA"), location: 0.15),
                    .init(color: Color("grayColorA"), location: 0.5),
                    .init(color: Color("mainColorA"), location: 0.85),
                    .init(color: Color("mainColorB"), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Image("loginLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 360)
                    .padding(.top, 60)

                Text("Keep Every Moment of the Concert")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 8)

                Spacer()

                Button {
                    Task { await viewModel.loginWithKakao() }
                } label: {
                    HStack {
                        Image("kakaoLogo").resizable().frame(width: 24, height: 24)
                        Text("카카오 계정으로 계속").font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color("mainColorB"), Color("mainColorC")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(12)
                }
                .disabled(isLoading)

                Button {
                    Task { await viewModel.loginWithApple() }
                } label: {
                    HStack {
                        Image("appleLogo").resizable().frame(width: 24, height: 24)
                        Text("애플 계정으로 계속").font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color("mainColorB"), Color("mainColorC")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(12)
                }
                .disabled(isLoading)

                if isLoading {
                    ProgressView().tint(.white).padding(.top, 12)
                }

                Spacer().frame(height: 32)
            }
            .padding(.horizontal, 24)
        }
        .onChange(of: viewModel.state) { _, new in
            switch new {
            case .success:
                onLoginSuccess()
            case .failure(let message):
                errorMessage = message
                showError = true
            default:
                break
            }
        }
        .alert("로그인 실패", isPresented: $showError) {
            Button("확인", role: .cancel) {}
        } message: { Text(errorMessage) }
    }

    private var isLoading: Bool {
        if case .loading = viewModel.state { return true }
        return false
    }
}

#Preview {
    LoginView(onLoginSuccess: { print("✅ Login Success (Preview)") })
}
