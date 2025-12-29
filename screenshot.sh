#!/bin/bash

# 1. Check if CopyQ is running; if not, start the server
# This ensures the clipboard injection works even if the app was closed.
if ! pgrep -x "copyq" > /dev/null; then
    copyq &
    sleep 0.5  # Brief pause to allow the server to initialize
fi

# 2. Set the directory for saving screenshots
# The folder will be created automatically if it doesn't exist.
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# 3. Define the filename with a timestamp
# Example: 20251229_164000.png
FILENAME="$(date +%Y%m%d_%H%M%S).png"
FULL_PATH="$SAVE_DIR/$FILENAME"

# 4. Capture a selected area using gnome-screenshot
# The script waits for the user to finish the area selection.
gnome-screenshot -a -f "$FULL_PATH"

# 5. Inject the image into the clipboard with 14+ MIME types
# This is the core logic that enables pasting into Wine applications (like KakaoTalk).
if [ -f "$FULL_PATH" ]; then
    copyq copy image/png - < "$FULL_PATH"
    
    # Optional: Send a desktop notification upon success
    # notify-send "Direct Paste" "Image injected into clipboard with multi-format support."
fi