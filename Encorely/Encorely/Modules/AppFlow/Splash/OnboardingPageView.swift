import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let text: String
    let buttonText: String
    let action: () -> Void
    @Binding var currentPage: Int
    let pageIndex: Int

    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            Text(text)
                .font(.system(size: 22, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Image(imageName)
                .resizable()
                .frame(width: 215, height: 466)

            HStack(spacing: 6) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color("mainColorA") : Color("mainColorC"))
                        .frame(width: 5, height: 5)
                }
            }
            .padding(.top, 1)

            Spacer()

            Button(action: action) {
                Text(buttonText)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("mainColorB"))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)

        }
    }
}
