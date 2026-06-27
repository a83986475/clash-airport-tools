# Clash Airport Tools

管理多个 Clash 机场订阅的命令行工具集，支持一键切换、刷新订阅、重命名等操作。

## 安装

```bash
git clone https://github.com/a83986475/clash-airport-tools.git
cd clash-airport-tools
sudo bash install.sh
```

安装后可用命令：

| 命令 | 说明 |
|---|---|
| `switch-clash` | 切换机场配置并自动重启 Clash |
| `add-airport` | 新增机场订阅 |
| `remove-airport` | 删除机场订阅 |
| `rename-airport` | 重命名机场 |
| `update-airport-url` | 更换订阅链接 |
| `show-airport-url` | 查看订阅链接 |
| `update-airport` | 刷新订阅节点 |

## 初始配置

安装后建议先创建 `secret.txt`，所有命令会自动读取，不再硬编码密码：

```bash
echo -n "你的secret密码" | sudo tee /root/.config/clash/secret.txt
sudo chmod 600 /root/.config/clash/secret.txt
```

## 卸载

```bash
sudo bash uninstall.sh
```

## 常用操作

```bash
# 查看所有机场
switch-clash list

# 切换到指定机场（自动重启 Clash）
switch-clash edge

# 新增机场（交互式输入名称和订阅链接）
add-airport

# 删除机场
remove-airport edge

# 重命名机场
rename-airport edge edge2

# 更换订阅链接
update-airport-url edge

# 查看订阅链接
show-airport-url edge

# 刷新指定机场的订阅节点
update-airport edge

# 刷新所有机场的订阅节点
update-airport all
```

## 注意事项

### Clash 启动方式

`switch-clash` 自动检测启动方式：
- 如果有 `clash.service` 或 `mihomo.service`，使用 `systemctl restart`
- 否则使用 `nohup` 模式，Clash 二进制路径为 `/root/clash/clash`，日志输出到 `/root/clash/clash.log`

### 订阅下载走代理

所有 `add-airport`、`update-airport-url`、`rename-airport` 生成的 profile 都包含：

```yaml
proxy-providers:
  机场名:
    proxy: 节点选择   # 订阅下载通过代理，避免直连失败
```

如果是旧版本生成的 profile 缺少此字段，可批量补全：

```bash
sudo python3 << 'EOF'
import os, re
profile_dir = "/root/.config/clash/profiles"
for fname in os.listdir(profile_dir):
    if not fname.endswith(".yaml"): continue
    path = os.path.join(profile_dir, fname)
    with open(path) as f: content = f.read()
    if "proxy: 节点选择" not in content:
        content = re.sub(
            r'(    url: "https?://[^\n]+"\n)(\s+path:)',
            r'\1    proxy: 节点选择\n\2', content
        )
        with open(path, "w") as f: f.write(content)
        print(f"已修改: {fname}")
EOF
```

### API 地址

所有新生成的 profile 使用 `external-controller: 127.0.0.1:9090`（仅本机访问）。如需从外部访问面板，改为 `0.0.0.0:9090` 并注意防火墙安全。
