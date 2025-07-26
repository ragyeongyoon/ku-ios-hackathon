# 🌱 PlantShare

An iOS application developed during the **KU iOS Hackathon 2019**, designed to help users intuitively care for their plants and share tips with others.  
Built using **Swift** and **UIKit**, the app supports plant registration, growth tracking, care reminders, and a lightweight community feature.

> *“누구나 실패 없이 Fun하게 식물을 즐기자!”*  
> 식물 초보자도 쉽게 키울 수 있도록, 기록·관리·공유 기능을 3일간 집중 개발했습니다.

---

## ✨ Features

### 1. Plant Management
- 식물 등록, 사진 업로드  
- 달력 기반 성장 기록, 메모 기능  
- 물주기/일조량 등 사용자 맞춤 관리 리마인드  

### 2. Member System
- Firebase 이메일 회원가입 / 로그인  
- 사용자별 식물 관리 내역 저장 및 분리  

### 3. Community
- 게시판에 식물 키우기 팁 공유  
- 다른 사용자 피드 열람 및 간단한 소통  

---

## 🛠 Tech Stack

| Category       | Technology                      |
|----------------|----------------------------------|
| Language       | Swift                            |
| UI Framework   | UIKit, Storyboard                |
| Architecture   | MVC                              |
| Database       | Firebase Realtime Database       |
| Auth           | Firebase Authentication          |
| Project Tool   | Xcode                            |
| Assets         | Assets.xcassets, LaunchScreen.storyboard |

---

## 📂 Folder Structure

```plaintext
PlantShare/
├── App/                          # AppDelegate, Info.plist 등 앱 기본 설정
│   └── Resources/               # Assets, LaunchScreen, Base.lproj
├── Models/                      # 데이터 모델 정의 (Post, Comment, PlantInfo 등)
├── Views/                       # UI 구성 요소
│   ├── Board/                   # 게시판 관련 뷰
│   ├── Diary/                   # 성장기록 뷰
│   ├── Manage/                  # 관리 탭 뷰
│   └── Common/                  # 공통 UI 요소 (컬렉션 뷰 셀 등)
├── ViewControllers/             # 기능별 뷰컨트롤러
│   ├── Board/                   # 게시판 VC
│   ├── Diary/                   # 성장기록 VC
│   ├── Manage/                  # 식물 관리 VC
│   ├── Auth/                    # 로그인/회원가입 VC
│   └── Shared/                  # 탭/공통 기능 VC
├── Utils/                       # 보조 클래스 (ex. SearchFooter)
├── PlantingShare.xcodeproj      # Xcode 프로젝트 파일
├── Podfile / Podfile.lock       # CocoaPods 의존성 설정
├── .gitignore                   # Git 제외 파일 설정
└── README.md
```

## 🚀 Getting Started

```bash
# 1. Clone the repository
git clone https://github.com/ragyeongyoon/ku-ios-hackathon.git

# 2. Navigate into the project directory
cd ku-ios-hackathon

# 3. Install dependencies (if using CocoaPods)
pod install

# 4. Open the project with Xcode
open PlantingShare.xcworkspace
```

