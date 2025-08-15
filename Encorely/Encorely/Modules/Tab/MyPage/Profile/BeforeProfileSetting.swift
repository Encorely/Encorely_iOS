import SwiftUI

struct BeforeProfileSetting: View {
    @Environment(\.dismiss) var dismiss

    @State private var nickname: String = ""
    @State private var introduction: String = ""
    @State private var personalLink: String = ""
    @State private var isNicknameValid: Bool? = nil

    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image("chevronLeft")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                Spacer()
                Text("프로필 설정")
                    .font(.headline)
                Spacer()
                Color.clear.frame(width: 24, height: 24)
            }
            .padding(.horizontal)
            .padding(.top, 12)

            ZStack(alignment: .bottomTrailing) {
                // 회색 배경 원 + 사람 아이콘
                ZStack {
                    Circle()
                        .fill(Color("grayScaleD")) // Assets에서 지정한 회색 컬러
                        .frame(width: 100, height: 100)

                    Image("Nothing") // 사람 아이콘 (피그마에서 다운로드한 이미지)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }

                // 플러스 버튼 (오른쪽 아래)
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color("mainColorB")) // 보라색 (Assets)
                    .background(Color.white)
                    .clipShape(Circle())
            }
            .padding(.top, 8)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 0) {
                    Text("닉네임")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text("*")
                        .foregroundColor(.red)
                        .font(.subheadline)
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
                        Button(action: {
                            isNicknameValid = nickname == "Hamin"
                        }) {
                            Text("중복 확인")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color("mainColorA"))
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
                    .font(.subheadline)
                    .fontWeight(.medium)
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
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal)

                TextField("ex. 인스타그램, 트위터, 스레드", text: $personalLink)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color("grayScaleC"), lineWidth: 1)
                    )
                    .padding(.horizontal)
            }

            Spacer()

            Button(action: {
                dismiss()
            }) {
                Text("프로필 설정 완료")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color("mainColorA"))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
    }
}

#Preview {
    BeforeProfileSetting()
}
