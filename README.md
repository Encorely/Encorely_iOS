# 🚀 Encorely

<img width="247" height="82" alt="EncorelyMainLogo" src="https://github.com/user-attachments/assets/c763dc23-8f46-46fb-aebe-9c5a8001c0aa" />

> “공연의 여운을 기록하는 공간”
Encore(앙코르) + ly = 앙코르처럼 기록하다

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)]()
[![Xcode](https://img.shields.io/badge/Xcode-16.0-blue.svg)]()
[![License](https://img.shields.io/badge/license-MIT-green.svg)]()

---

<br>

## 👥 멤버
| 앤드류/고은혁 | 흑곰/이민서 | 소피/이예지 |
|:------:|:------:|:------:|
| <img src="이미지URL1" width="150" height="150"/> | <img src="이미지URL2" width="150" height="150"/> | ![IMG_6186](https://github.com/user-attachments/assets/a87fccc2-c777-4e52-a272-558b3f1d93ee)
 |
| **FE** | **FE** | **FE** |
| [GitHub] | [GitHub] | [GitHub] |

<br>


## 📱 Encorely 소개

> 공연을 여운을 기록하고 팁을 공유하며 모두의 공연 생활을 응원하는 앱입니다.

<br>

## 📆 프로젝트 기간
- 전체 기간: `2025.07.03 - 2025.08.22`
- 개발 기간: `2025.07.07 - 2025.08.22`

<br>

## 🤔 요구사항
For building and running the application you need:

iOS 18.2 <br>
Xcode 16.2 <br>
Swift 6.0

<br>

## ⚒️ 개발 환경
* Front : SwiftUI
* 버전 및 이슈 관리 : Github, Github Issues
* 협업 툴 : Discord, Notion

<br>

## 🔎 기술 스택
### Envrionment
<div align="left">
<img src="https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white" />
<img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" />
<img src="https://img.shields.io/badge/SPM-FA7343?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/Fastlane-n?style=for-the-badge&logo=fastlane&logoColor=black" />
</div>

### Development
<div align="left">
<img src="https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white" />
<img src="https://img.shields.io/badge/Firebase-DD2C00?style=for-the-badge&logo=Firebase&logoColor=white" />
<img src="https://img.shields.io/badge/SwiftUI-42A5F5?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/Alamofire-FF5722?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/Moya-8A4182?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/Kingfisher-0F92F3?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/Combine-FF2D55?style=for-the-badge&logo=apple&logoColor=white" />
</div>

### Communication
<div align="left">
<img src="https://img.shields.io/badge/Miro-FFFC00.svg?style=for-the-badge&logo=Miro&logoColor=050038" />
<img src="https://img.shields.io/badge/Notion-white.svg?style=for-the-badge&logo=Notion&logoColor=000000" />
<img src="https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=Discord&logoColor=white" />
<img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white" />
</div>

<br>

## 📱 화면 구성
<table>
  <tr>
    <td>
      사진 넣어주세요
    </td>
    <td>
      사진 넣어주세요
    </td>
   
  </tr>
</table>

## 🔖 브랜치 컨벤션
* `main` - 제품 출시 브랜치
* `develop` - 출시를 위해 개발하는 브랜치
* `feat/xx` - 기능 단위로 독립적인 개발 환경을 위해 작성
* `refac/xx` - 개발된 기능을 리팩토링 하기 위해 작성
* `hotfix/xx` - 출시 버전에서 발생한 버그를 수정하는 브랜치
* `chore/xx` - 빌드 작업, 패키지 매니저 설정 등
* `design/xx` - 디자인 변경
* `bugfix/xx` - 버그 수정



<br>

## 🌀 코딩 컨벤션
* 파라미터 이름을 기준으로 줄바꿈 한다.
```swift
let actionSheet = UIActionSheet(
  title: "정말 계정을 삭제하실 건가요?",
  delegate: self,
  cancelButtonTitle: "취소",
  destructiveButtonTitle: "삭제해주세요"
)
```

<br>

* if let 구문이 길 경우에 줄바꿈 한다
```swift
if let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
   let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
  user.gender == .female {
  // ...
}
```

* 나중에 추가로 작업해야 할 부분에 대해서는 `// TODO: - xxx 주석을 남기도록 한다.`
* 코드의 섹션을 분리할 때는 `// MARK: - xxx 주석을 남기도록 한다.`
* 함수에 대해 전부 주석을 남기도록 하여 무슨 액션을 하는지 알 수 있도록 한다.
* Stack, ScrollView, … 속성 쓸 때에는 대괄호를 쓰기 전에 한칸 띄운다.
```swift
VStack(spacing: 5) {
	...
	}
```
* 함수 이름의 첫 글자는 소문자, 다음 단어의 시작은 대문자로 시작한다.
* 하위뷰 생성 시에 1엔터, 1주석 후 줄바꿈한다.
* 변수가 괄호 안에 세 개 이상일 때 변수마다 줄바꿈을 한다.
* ifelse 작성법
```swift
if {
...
}
else
```
* 콤마(,), 콜론(:)의 앞은 붙여쓰고 뒤는 한 칸 띄워쓴다.
* button의 변수는 Btn으로 사용한다.


<br>

## 📁 PR 컨벤션
* PR 시, 템플릿이 등장한다. 해당 템플릿에서 작성해야할 부분은 아래와 같다
    1. `PR 유형 작성`, 어떤 변경 사항이 있었는지 [] 괄호 사이에 x를 입력하여 체크할 수 있도록 한다.
    2. `작업 내용 작성`, 작업 내용에 대해 자세하게 작성을 한다.
    3. `추후 진행할 작업`, PR 이후 작업할 내용에 대해 작성한다
    4. `리뷰 포인트`, 본인 PR에서 꼭 확인해야 할 부분을 작성한다.
    6. `PR 태그 종류`, PR 제목의 태그는 아래 형식을 따른다.

#### 🌟 태그 종류 (커밋 컨벤션과 동일)
| 태그        | 설명                                                   |
|-------------|--------------------------------------------------------|
| [Feat]      | 새로운 기능 추가                                       |
| [Fix]       | 버그 수정                                              |
| [Refactor]  | 코드 리팩토링 (기능 변경 없이 구조 개선)              |
| [Style]     | 코드 포맷팅, 들여쓰기 수정 등                         |
| [Docs]      | 문서 관련 수정                                         |
| [Test]      | 테스트 코드 추가 또는 수정                            |
| [Chore]     | 빌드/설정 관련 작업                                    |
| [Design]    | UI 디자인 수정                                         |
| [Hotfix]    | 운영 중 긴급 수정                                      |
| [CI/CD]     | 배포 및 워크플로우 관련 작업                          |

### ✅ PR 예시 모음
> 🎉 [Chore] 프로젝트 초기 세팅 <br>
> ✨ [Feat] 프로필 화면 UI 구현 <br>
> 🐛 [Fix] iOS 17에서 버튼 클릭 오류 수정 <br>
> 💄 [Design] 로그인 화면 레이아웃 조정 <br>
> 📝 [Docs] README에 프로젝트 소개 추가 <br>

<br>

## 📑 커밋 컨벤션

### 💬 깃모지 가이드

| 아이콘 | 코드 | 설명 | 원문 |
| :---: | :---: | :---: | :---: |
| 🐛 | bug | 버그 수정 | Fix a bug |
| ✨ | sparkles | 새 기능 | Introduce new features |
| 💄 | lipstick | UI/스타일 파일 추가/수정 | Add or update the UI and style files |
| ♻️ | recycle | 코드 리팩토링 | Refactor code |
| ➕ | heavy_plus_sign | 의존성 추가 | Add a dependency |
| 🔀 | twisted_rightwards_arrows | 브랜치 합병 | Merge branches |
| 💡 | bulb | 주석 추가/수정 | Add or update comments in source code |
| 🔥 | fire | 코드/파일 삭제 | Remove code or files |
| 🚑 | ambulance | 긴급 수정 | Critical hotfix |
| 🎉 | tada | 프로젝트 시작 | Begin a project |
| 🔒 | lock | 보안 이슈 수정 | Fix security issues |
| 🔖 | bookmark | 릴리즈/버전 태그 | Release / Version tags |
| 📝 | memo | 문서 추가/수정 | Add or update documentation |
| 🔧| wrench | 구성 파일 추가/삭제 | Add or update configuration files.|
| ⚡️ | zap | 성능 개선 | Improve performance |
| 🎨 | art | 코드 구조 개선 | Improve structure / format of the code |
| 📦 | package | 컴파일된 파일 추가/수정 | Add or update compiled files |
| 👽 | alien | 외부 API 변경 반영 | Update code due to external API changes |
| 🚚 | truck | 리소스 이동, 이름 변경 | Move or rename resources |
| 🙈 | see_no_evil | .gitignore 추가/수정 | Add or update a .gitignore file |

### 🏷️ 커밋 태그 가이드

 | 태그        | 설명                                                   |
|-------------|--------------------------------------------------------|
| [Feat]      | 새로운 기능 추가                                       |
| [Fix]       | 버그 수정                                              |
| [Refactor]  | 코드 리팩토링 (기능 변경 없이 구조 개선)              |
| [Style]     | 코드 포맷팅, 세미콜론 누락, 들여쓰기 수정 등          |
| [Docs]      | README, 문서 수정                                     |
| [Test]      | 테스트 코드 추가 및 수정                              |
| [Chore]     | 패키지 매니저 설정, 빌드 설정 등 기타 작업           |
| [Design]    | UI, CSS, 레이아웃 등 디자인 관련 수정                |
| [Hotfix]    | 운영 중 긴급 수정이 필요한 버그 대응                 |
| [CI/CD]     | 배포 관련 설정, 워크플로우 구성 등                    |

### ✅ 커밋 예시 모음
> 🎉 [Chore] 프로젝트 초기 세팅 <br>
> ✨ [Feat] 프로필 화면 UI 구현 <br>
> 🐛 [Fix] iOS 17에서 버튼 클릭 오류 수정 <br>
> 💄 [Design] 로그인 화면 레이아웃 조정 <br>
> 📝 [Docs] README에 프로젝트 소개 추가 <br>

<br>

## 🗂️ 폴더 컨벤션
```
.
├── Encorely
│   ├── App
│   │   └── EncorelyApp.swift
│   ├── Common
│   │   ├── Enum
│   │   │   ├── Error
│   │   │   ├── Login
│   │   │   ├── MyPage
│   │   │   ├── Registration
│   │   │   ├── Segment
│   │   │   └── Tab
│   │   ├── Protocol
│   │   └── UIComponents
│   │       ├── Custom
│   │       ├── MyPage
│   │       ├── Registration
│   │       ├── Segment
│   │       └── Venue
│   ├── ContentView.swift
│   ├── Core
│   │   ├── Actor
│   │   ├── DIContainer
│   │   ├── Navigation
│   │   └── Service
│   │       ├── MoyaRouter
│   │       ├── MoyaService
│   │       └── Social
│   ├── Models
│   │   ├── Domain
│   │   │   ├── Common
│   │   │   ├── MyPage
│   │   │   ├── Registration
│   │   │   └── Venue
│   │   └── DTO
│   │       └── Auth
│   ├── Modules
│   │   ├── AppFlow
│   │   │   ├── Login
│   │   │   └── Splash
│   │   └── Tab
│   │       ├── EncorelyTabView.swift
│   │       ├── MyPage
│   │       │   ├── ViewModels
│   │       │   └── Views
│   │       ├── Registration
│   │       │   ├── ViewModels
│   │       │   └── Views
│   │       └── Venue
│   │           ├── ViewModels
│   │           └── Views
│   ├── Resources
│   │   ├── Assets
│   │   │   ├── Assets.xcassets
│   │   │   │   ├── AccentColor.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── AppIcon.appiconset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── Contents.json
│   │   │   └── Color.xcassets
│   │   └── Fonts
│   └── Utils
│       ├── Extensions
│       └── Modifiers
└── Encorely.xcodeproj
    ├── project.pbxproj
    ├── project.xcworkspace
    │   ├── contents.xcworkspacedata
    │   ├── xcshareddata
    │   │   └── swiftpm
    │   │       └── configuration
    │   └── xcuserdata
    │       └── leeyeji.xcuserdatad
    │           └── UserInterfaceState.xcuserstate
    └── xcuserdata
        └── leeyeji.xcuserdatad
            └── xcschemes
                └── xcschememanagement.plist

```
