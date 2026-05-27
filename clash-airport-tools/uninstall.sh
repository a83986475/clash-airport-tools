#!/usr/bin/env bash
set -euo pipefail
rm -f /usr/local/bin/switch-clash \
      /usr/local/bin/add-airport \
      /usr/local/bin/remove-airport \
      /usr/local/bin/rename-airport \
      /usr/local/bin/update-airport-url \
      /usr/local/bin/show-airport-url
echo "已卸载命令，配置目录保留: /root/.config/clash"
