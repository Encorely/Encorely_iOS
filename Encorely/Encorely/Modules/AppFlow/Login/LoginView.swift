import SwiftUI
import SafariServices
import AuthenticationServices

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    var onLoginSuccess: () -> Void

    private let kakaoURL = URL(string: "http://13.209.39.26:8080/oauth2/authorization/kakao")!
    private let callbackScheme = "encorely"

    @State private var showKakaoWeb = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var webAuthSession: ASWebAuthenticationSession?

    private let useEphemeralWebAuth = true

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
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Image("loginLogo")
                    .resizable().scaledToFit().frame(width: 360)
                    .padding(.top, 60)

                Text("Keep Every Moment of the Concert")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 8)

                Spacer()

                Button {
                    if useEphemeralWebAuth {
                        startKakaoEphemeralWebAuth()
                    } else {
                        showKakaoWeb = true
                    }
                } label: {
                    HStack {
                        Image("kakaoLogo").resizable().frame(width: 24, height: 24)
                        Text("카카오 계정으로 계속").font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("mainColorB"), Color("mainColorC")]),
                            startPoint: .leading, endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
                }

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
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("mainColorB"), Color("mainColorC")]),
                            startPoint: .leading, endPoint: .trailing
                        )
                    )
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
        .navigationBarBackButtonHidden(true)   // ← Back 숨김

        .sheet(isPresented: $showKakaoWeb) {
            SafariView(url: kakaoURL)
        }
        .onOpenURL { url in
            guard url.scheme?.lowercased() == callbackScheme else { return }
            showKakaoWeb = false
            handleCallbackURL(url)
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
            Button("확인", role: .cancel) { }
        } message: { Text(errorMessage) }
    }

    private var isLoading: Bool {
        if case .loading = viewModel.state { return true }
        return false
    }

    private func startKakaoEphemeralWebAuth() {
        let session = ASWebAuthenticationSession(
            url: kakaoURL,
            callbackURLScheme: callbackScheme
        ) { callbackURL, error in
            if let url = callbackURL {
                handleCallbackURL(url)
                return
            }
            if let err = error as NSError? {
                print("ASWebAuth failed: \(err.domain) (\(err.code)) - \(err.localizedDescription)")
            }
            DispatchQueue.main.async {
                showKakaoWeb = true
            }
        }
        session.presentationContextProvider = AuthPresentationAnchorProvider()
        session.prefersEphemeralWebBrowserSession = true
        webAuthSession = session
        _ = session.start()
    }

    private func handleCallbackURL(_ url: URL) {
        guard let comps = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            errorMessage = "콜백 URL 파싱 실패: \(url.absoluteString)"
            showError = true
            return
        }
        let q = comps.queryItems ?? []
        let access  = q.first { ["access","accesstoken"].contains($0.name.lowercased()) }?.value
        let refresh = q.first { ["refresh","refreshtoken"].contains($0.name.lowercased()) }?.value
        let code    = q.first { $0.name.lowercased() == "code" }?.value

        if access != nil || code != nil {
            onLoginSuccess()
        } else {
            errorMessage = "로그인 콜백 파싱 실패: \(url.absoluteString)"
            showError = true
        }
    }
}

#Preview {
    LoginView(onLoginSuccess: { print("✅ Login Success (Preview)") })
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: Context) -> SFSafariViewController { SFSafariViewController(url: url) }
    func updateUIViewController(_ controller: SFSafariViewController, context: Context) { }
}

final class AuthPresentationAnchorProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}
