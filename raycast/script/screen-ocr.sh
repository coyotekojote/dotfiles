#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Screen OCR
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📷
# @raycast.packageName ScreenOCR
# @raycast.description 画面の選択領域からテキストを抽出してコピー

~/ghq/github.com/coyotekojote/screen-ocr/.build/release/screen-ocr --interactive --copy --languages "ja-JP,en-US"
