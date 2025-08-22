import SwiftUI
import UIKit

struct BeforeProfileSetting: View {
    @EnvironmentObject private var authRouter: AuthRouter
    @Environment(\.dismiss) private var dismiss

    @State private var nickname: String = ""
    @State private var introduction: String = ""
    @State private var personalLink: String = ""
    @State private var isNicknameValid: Bool? = nil

    @State private var showingPicker = false
    @State private var pickedImage: UIImage? = nil

    @State private var showTabs = false

    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Color.clear.frame(width: 24, height: 24)
                Button(action: {
                    dismiss()
                }) {
                    Image("chevronLeft")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.grayColorA)
                }
                Spacer()
                Text("프로필 설정").font(.headline)
                Spacer()
                Color.clear.frame(width: 24, height: 24)
            }
            .padding(.horizontal)
            .padding(.top, 12)

            ZStack(alignment: .bottomTrailing) {
                ZStack {
                    Circle()
                        .fill(Color("grayColorH"))
                        .frame(width: 100, height: 100)

                    Group {
                        if let img = pickedImage {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image("Nothing")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                        }
                    }
                }

                Button { showingPicker = true } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color("mainColorB"))
                        .background(Color.white)
                        .clipShape(Circle())
                }
            }
            .padding(.top, 8)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 0) {
                    Text("닉네임").font(.subheadline).fontWeight(.medium)
                    Text("*").foregroundColor(.red).font(.subheadline)
                }
                .padding(.horizontal)

                ZStack {
                    TextField("닉네임을 입력해주세요", text: $nickname)
                        .padding(.horizontal, 16)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(Color("grayScaleA"), lineWidth: 1)
                        )

                    HStack {
                        Spacer()
                        Button {
                            isNicknameValid = !nickname.trimmingCharacters(in: .whitespaces).isEmpty
                        } label: {
                            Text("중복 확인")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color("mainColorB"))
                                .clipShape(Capsule())
                        }
                        .padding(.trailing, 12)
                    }
                }
                .padding(.horizontal)

                if let valid = isNicknameValid {
                    Text(valid ? "사용 가능한 닉네임이에요" : "사용 불가능한 닉네임이에요")
                        .font(.caption)
                        .foregroundColor(valid ? .blue : .red)
                        .padding(.leading, 24)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("한 줄 소개")
                    .font(.subheadline).fontWeight(.medium)
                    .padding(.horizontal)

                TextField("나를 소개해주세요(최대 50자)", text: $introduction)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color("grayScaleA"), lineWidth: 1)
                    )
                    .padding(.horizontal)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("개인 프로필 링크 추가")
                    .font(.subheadline).fontWeight(.medium)
                    .padding(.horizontal)

                TextField("ex. 인스타그램, 트위터, 스레드", text: $personalLink)
                    .keyboardType(.URL)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color("grayScaleC"), lineWidth: 1)
                    )
                    .padding(.horizontal)
            }

            Spacer()

            Button(action: onComplete) {
                Text("프로필 설정 완료")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color("mainColorB"))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if let saved = ProfileStore.shared.load() {
                nickname = saved.nickname
                introduction = saved.introduction
                personalLink = saved.link
                if let data = saved.imageData, let img = UIImage(data: data) {
                    pickedImage = img
                }
            }
        }
        .sheet(isPresented: $showingPicker) {
            PhotoPicker { image in
                if let image { pickedImage = image }
            }
        }
        .fullScreenCover(isPresented: $showTabs) {
            EncorelyTabView()
        }
    }

    @MainActor
    private func onComplete() {
        let trimmed = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let data = pickedImage?.jpegData(compressionQuality: 0.9)
        let profile = UserProfile(
            nickname: trimmed,
            introduction: introduction,
            link: personalLink,
            imageData: data
        )
        ProfileStore.shared.save(profile)
        showTabs = true
    }
}

#Preview {
    BeforeProfileSetting().environmentObject(AuthRouter())
}
