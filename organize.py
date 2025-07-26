import os
import shutil

# 현재 디렉토리 기준
base_dir = "."

# 폴더 구조 정의
folder_map = {
    "App": ["AppDelegate.swift", "Info.plist"],
    "App/Resources": ["Assets.xcassets", "LaunchScreen.storyboard", "Base.lproj"],
    "Models": ["Post.swift", "Comment.swift", "Candy.swift", "Location.swift", "PlantInfo.swift", "PlantInfo2.swift", "PlantnNameTableViewCell.swift"],
    "Views/Board": ["Board.storyboard", "BoardPostTableViewCell.swift", "BoardTableViewCell.swift"],
    "Views/Diary": ["Diary.storyboard"],
    "Views/Manage": ["Manage.storyboard"],
    "Views/Common": ["CollectionViewCell.swift", "PhotoItemCell.swift"],
    "ViewControllers/Board": [f for f in os.listdir() if f.startswith("Board") and f.endswith(".swift")],
    "ViewControllers/Diary": [f for f in os.listdir() if f.startswith("Diary") and f.endswith(".swift")],
    "ViewControllers/Manage": [f for f in os.listdir() if f.startswith("Manage") and f.endswith(".swift")],
    "ViewControllers/Auth": ["IdPassword.swift"],
    "ViewControllers/Shared": ["SecondViewController.swift", "TapViewController.swift", "sssViewController.swift"],
    "Utils": ["SearchFooter.swift"]
}

# 이동 로직
for folder, files in folder_map.items():
    os.makedirs(os.path.join(base_dir, folder), exist_ok=True)
    for file in files:
        if os.path.exists(file):
            shutil.move(file, os.path.join(base_dir, folder, file))
            print(f"Moved {file} to {folder}")
        else:
            print(f"[Skip] {file} not found")

print("✅ 파일 정리 완료!")
