#!/usr/bin/env bash
set -euo pipefail
PREFIX="/usr/local/bin"
CONFIG_DIR="/root/.config/clash"
mkdir -p "$PREFIX" "$CONFIG_DIR/profiles" "$CONFIG_DIR/providers" "$CONFIG_DIR/dashboard"
install -m 755 bin/switch-clash "$PREFIX/switch-clash"
install -m 755 bin/add-airport "$PREFIX/add-airport"
install -m 755 bin/remove-airport "$PREFIX/remove-airport"
install -m 755 bin/rename-airport "$PREFIX/rename-airport"
install -m 755 bin/update-airport-url "$PREFIX/update-airport-url"
install -m 755 bin/show-airport-url "$PREFIX/show-airport-url"
install -m 755 bin/update-airport "$PREFIX/update-airport"
echo "安装完成"
echo "可用命令: switch-clash add-airport remove-airport rename-airport update-airport-url show-airport-url update-airport"
