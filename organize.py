import os
import shutil

base_dir = os.path.abspath(".")

def classify_file(filename):
    name = filename.lower()
    if filename.endswith(".swift"):
        if "board" in name:
            return "ViewControllers/Board"
        elif "diary" in name:
            return "ViewControllers/Diary"
        elif "manage" in name:
            return "ViewControllers/Manage"
        elif "idpassword" in name or "auth" in name:
            return "ViewControllers/Auth"
        elif any(x in name for x in ["second", "tap", "sss"]):
            return "ViewControllers/Shared"
        elif filename in ["CollectionViewCell.swift", "PhotoItemCell.swift"]:
            return "Views/Common"
        elif filename in ["Post.swift", "Comment.swift", "Candy.swift", "Location.swift", "PlantInfo.swift", "PlantInfo2.swift", "PlantnNameTableViewCell.swift"]:
            return "Models"
        elif "searchfooter" in name:
            return "Utils"
        else:
            return "Unsorted"
    elif filename.endswith(".storyboard"):
        if "board" in name:
            return "Views/Board"
        elif "diary" in name:
            return "Views/Diary"
        elif "manage" in name:
            return "Views/Manage"
        else:
            return "Views"
    elif filename in ["AppDelegate.swift", "Info.plist"]:
        return "App"
    elif filename in ["Assets.xcassets", "LaunchScreen.storyboard", "Base.lproj"]:
        return "App/Resources"
    return None

# 전체 순회
for root, _, files in os.walk(base_dir):
    for file in files:
        if file.startswith("."): continue  # 숨김파일 무시
        full_path = os.path.join(root, file)
        if os.path.isfile(full_path):
            target_rel = classify_file(file)
            if target_rel:
                target_abs = os.path.join(base_dir, target_rel)
                os.makedirs(target_abs, exist_ok=True)
                target_file_path = os.path.join(target_abs, file)

                # 같은 파일이면 무시, 다르면 이동
                if os.path.abspath(full_path) != os.path.abspath(target_file_path):
                    shutil.move(full_path, target_file_path)
                    print(f"📦 {file} → {target_rel}")

# 빈 폴더 처리
for root, dirs, _ in os.walk(base_dir):
    for d in dirs:
        path = os.path.join(root, d)
        if not os.listdir(path):
            open(os.path.join(path, ".gitkeep"), "w").close()

print("✅ ViewControllers 포함 전체 파일 분류 완료!")