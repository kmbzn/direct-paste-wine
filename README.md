# direct-paste-wine 🍷🐧

**리눅스 와인(Wine) 환경에서 카카오톡에 스크린샷을 바로 붙여넣을 수 있는 솔루션**
**A universal solution for pasting images into Wine applications on Linux.**

### 개요
리눅스(특히 Ubuntu Wayland) 환경에서 와인을 통해 실행되는 카카오톡, 포토샵 등의 앱에 이미지가 붙여넣어지지 않는 고질적인 문제를 해결합니다. 

이 프로젝트의 핵심은 **CopyQ** 엔진을 사용하여 이미지를 클립보드에 주입할 때, 단순한 `.PNG` 형식이 아닌 14가지 이상의 MIME 타입(BMP 포함)으로 동시 주입하여 wine과 Linux 간의 클립보드 호환성 장벽을 완전히 허무는 데 있습니다.

> **핵심 명령어:**
> `copyq copy image/png - < "이미지파일.png"`
> *이 한 줄의 명령어가 클립보드에 14개 이상의 호환 형식을 생성하여 주입합니다.*

### 🛠 설치 및 사용 방법
1. **필수 도구 설치:**
   ```bash
   sudo apt update && sudo apt install copyq gnome-screenshot -y

2. **스크립트 생성:** `direct_paste.sh` 파일을 만들고 아래 코드를 복사하여 실행 권한(`chmod +x`)을 부여합니다.
3. **단축키 등록:** 시스템 설정의 키보드 단축키 메뉴에서 본 스크립트를 `PrintScreen` 또는 원하는 키에 할당하세요.

### Overview

This project comprehensively resolves the frustrating issue of being unable to paste images/screenshots into **Wine-based applications** (like KakaoTalk, Photoshop, MS Office) in Linux environments (especially Ubuntu Wayland).

The breakthrough lies in using the **CopyQ** engine to inject images into the system clipboard with **14+ different MIME types** simultaneously. This ensures that the Wine translation layer provides the legacy formats (like **BMP/DIB**) that Windows applications expect.

> **The Core Logic:**
> `copyq copy image/png - < "your-image.png"`
> *Executing this single line triggers CopyQ to generate and inject 14+ compatible formats into the clipboard.*

### 🛠 Installation & Usage

1. **Install Prerequisites:**
```bash
sudo apt update && sudo apt install copyq gnome-screenshot -y
```
2. **Setup Script:** Create `direct_paste.sh` and give it execution permissions (`chmod +x`).
3. **Assign Shortcut:** Link this script to a custom keyboard shortcut in your system settings.

## 💻 Script (Common)

```bash
#!/bin/bash

# 1. CopyQ 서버 확인 및 실행 (Ensure CopyQ is running)
if ! pgrep -x "copyq" > /dev/null; then
    copyq &
    sleep 0.5
fi

# 2. 경로 설정 및 스크린샷 캡처 (Set path and Capture)
SAVE_DIR="$HOME/Pictures/Screenshots"
FILENAME="capture_$(date +%Y%m%d_%H%M%S).png"
FULL_PATH="$SAVE_DIR/$FILENAME"
mkdir -p "$SAVE_DIR"

gnome-screenshot -a -f "$FULL_PATH"

# 3. 14가지 형식 클립보드 주입 (Inject 14+ MIME types)
if [ -f "$FULL_PATH" ]; then
    copyq copy image/png - < "$FULL_PATH"
fi

```

## 🛠 Environment

* **OS:** Ubuntu 22.04 LTS (Wayland)
* **Tested Hardware:** ThinkPad X13 Gen 1
* **Verified Apps:** KakaoTalk (Wine), Photoshop (Wine), Line, etc.

## 📄 License

This project is licensed under the **MIT License**.

---

**Created by [kmbzn]** - If this tool saved your time, please give it a ⭐!

### 마지막 체크리스트:
1. **파일 이름:** `README.md`로 저장하여 프로젝트 루트 폴더에 넣으세요.
2. **사용자 이름:** 마지막 줄의 `[kmbzn]` 부분을 유저님의 실제 닉네임으로 확인해 주세요.
3. **업로드:** ```bash
   git add README.md
   git commit -m "Add bilingual README (Korean & English)"
   git push origin main
