import os
import shutil

base_dir = "."

# 자동 분류 기준 함수
def classify_file(filename):
    if filename in ["AppDelegate.swift", "Info.plist"]:
        return "App"
    elif filename in ["Assets.xcassets", "LaunchScreen.storyboard", "Base.lproj"]:
        return "App/Resources"
    elif filename.endswith(".storyboard"):
        if "Board" in filename:
            return "Views/Board"
        elif "Diary" in filename:
            return "Views/Diary"
        elif "Manage" in filename:
            return "Views/Manage"
        else:
            return "Views"
    elif filename.endswith(".swift"):
        if filename.startswith("Board"):
            return "ViewControllers/Board"
        elif filename.startswith("Diary"):
            return "ViewControllers/Diary"
        elif filename.startswith("Manage"):
            return "ViewControllers/Manage"
        elif filename.startswith("Tap") or filename.startswith("Second") or filename.startswith("sss"):
            return "ViewControllers/Shared"
        elif filename.startswith("IdPassword"):
            return "ViewControllers/Auth"
        elif filename in ["CollectionViewCell.swift", "PhotoItemCell.swift"]:
            return "Views/Common"
        elif filename in ["Post.swift", "Comment.swift", "Candy.swift", "Location.swift", "PlantInfo.swift", "PlantInfo2.swift", "PlantnNameTableViewCell.swift"]:
            return "Models"
        elif filename.startswith("SearchFooter"):
            return "Utils"
        else:
            return "Unsorted"
    else:
        return None

# 디렉토리 내 파일만 스캔
for file in os.listdir(base_dir):
    if os.path.isfile(file):
        target_folder = classify_file(file)
        if target_folder:
            dest = os.path.join(base_dir, target_folder)
            os.makedirs(dest, exist_ok=True)
            shutil.move(file, os.path.join(dest, file))
            print(f"📦 Moved {file} → {target_folder}")

# 빈 폴더는 .gitkeep 추가
for root, dirs, files in os.walk(base_dir):
    for d in dirs:
        full_path = os.path.join(root, d)
        if not os.listdir(full_path):
            open(os.path.join(full_path, ".gitkeep"), "w").close()
            print(f"📁 Created .gitkeep in empty folder: {full_path}")

print("✅ 자동 분류 및 정리 완료!")
