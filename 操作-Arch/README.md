# ArchLinux

## 声音问题
paru -S sof-firmware

## archlinuxcn
```
使用方法：在 /etc/pacman.conf 文件末尾添加以下两行：

[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch

# 安装 haveged
pacman -Syu haveged
systemctl start haveged
systemctl enable haveged

# 初始化 keyring
rm -fr /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux

# 之后通过以下命令安装 archlinuxcn-keyring 包导入 GPG key。
pacman -Sy archlinuxcn-keyring
# 新系统中安装 archlinuxcn-keyring 包前的额外步骤
# 2023 年 12 月后，在新系统下安装 archlinuxcn-keyring 时可能会出现错误：
# error: archlinuxcn-keyring: Signature from "Jiachen YANG (Arch Linux Packager Signing Key) " is marginal trust
# 需要在本地信任 farseerfc 的 GPG key：
pacman-key --lsign-key "farseerfc@archlinux.org"

# 执行完毕后再次安装archlinuxcn-keyring
pacman -S archlinuxcn-keyring

#然后执行下一条命令
pacman-key --populate archlinuxcn
```

## environment
```
#
# This file is parsed by pam_env module
# etc/environment
# Syntax: simple "KEY=VAL" pairs on separate lines
#

GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=fcitx
```

## fcitx
```shell
sudo pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-material-color fcitx5-configtool
sudo pacman -S fcitx5-pinyin-zhwiki fcitx5-pinyin-moegirl
```


## flatpak
```
sudo pacman -S flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # 官方源

flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub # 上海交大源
```

## font
pacman -Syu ttf-jetbrains-mono-nerd noto-fonts-cjk noto-fonts-emoji

## locale.gen
/etc/locale.conf
```

LC_ALL=zh_CN.UTF-8
```

/etc/locale.gen
```
zh_CN.UTF-8 UTF-8  
en_US.UTF-8 UTF-8
```

```shell
locale-gen
```

## oh-my-posh
```shell
mkdir ~/bin

curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin

export PATH="${PATH}:~/bin"
export POSHTHEME="~/.cache/oh-my-posh/themes"

eval "$(oh-my-posh --init --shell bash --config ${POSHTHEME}/my.omp.json)"
```

my.omp.json

```json
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "blocks": [
    {
      "alignment": "left",
      "segments": [
        {
          "type": "python",
          "style": "plain",
          "foreground": "#b4eb8d",
          "properties": {
            "display_virtual_env": true,
            "display_default": true,
            "display_version": false,
            "home_enabled": true,
            "prefix": "\uE235 ",
            "postfix": " ",
            "display_mode": "always"
          }
        },
        {
          "background": "#33c4e5",
          "foreground": "#f8f8f2",
          "leading_diamond": "\ue0b6",
          "style": "diamond",
          "template": "{{ .Icon }} {{ .HostName }} ",
          "type": "os"
        },
        {
          "background": "#bd93f9",
          "foreground": "#f8f8f2",
          "powerline_symbol": "\ue0b0",
          "properties": {
            "style": "folder"
          },
          "style": "powerline",
          "template": " {{ .Path }} ",
          "type": "path"
        },
        {
          "background": "#ffb86c",
          "foreground": "#f8f8f2",
          "powerline_symbol": "\ue0b0",
          "properties": {
            "branch_icon": "",
            "fetch_stash_count": true,
            "fetch_status": false,
            "fetch_upstream_icon": true
          },
          "style": "powerline",
          "template": " \ue725 ({{ .UpstreamIcon }}{{ .HEAD }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }}) ",
          "type": "git"
        },
        {
          "background": "#00c983",
          "foreground": "#f8f8f2",
          "powerline_symbol": "\ue0b0",
          "style": "powerline",
          "template": " \ue718 {{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }} ",
          "type": "node"
        },
        {
          "background": "#ff79c6",
          "foreground": "#f8f8f2",
          "powerline_symbol": "\ue0b0",
          "properties": {
            "time_format": "15:04"
          },
          "style": "powerline",
          "template": " \u2665 {{ .CurrentDate | date .Format }} ",
          "type": "time"
        },
        {
          "background": "#83769c",
          "foreground": "#f8f8f8",
          "powerline_symbol": "\ue0b0",
          "properties": {
            "always_enabled": true
          },
          "style": "powerline",
          "template": " \ueba2 {{ .FormattedMs }} ",
          "type": "executiontime"
        }
      ],
      "type": "prompt"
    },
    {
      "alignment": "left",
      "segments": [
        {
          "background": "#f1fa8c",
          "foreground": "#282a36",
          "invert_powerline": true,
          "leading_diamond": "\ue0b2",
          "style": "diamond",
          "template": " \ue7ad {{.Profile}}{{if .Region}}@{{.Region}}{{end}}",
          "trailing_diamond": "\ue0b4",
          "type": "aws"
        }
      ],
      "type": "rprompt"
    },
    {
      "alignment": "left",
      "newline": true,
      "segments": [
        {
          "foreground": "#cd5e42",
          "style": "plain",
          "template": "\ue3bf ",
          "type": "root"
        },
        {
          "foreground": "#9ef8fa",
          "style": "plain",
          "template": " <#45F1C2><b>\u26a1</b></><b>{{ .UserName }}</b> <#26C6DA>\u276f</><#45F1C2>\u276f</>",
          "type": "text"
        }
      ],
      "type": "prompt"
    }
  ],
  "final_space": true,
  "version": 2
}
```
## open-vm-tools
```
Open-VM-Tools
实用工具
open-vm-tools 软件包里包括如下工具：

vmtoolsd - 负责汇报虚拟机状态的服务。
vmware-checkvm - 用于检测虚拟机中是否在运行着某程序的工具。
vmware-toolbox-cmd - 用于收集宿主系统信息的工具。
vmware-user - Tool to enable clipboard sharing (copy/paste) between host and guest.
vmware-vmblock-fuse - 文件系统。基于 FUSE (Filesystem in Userspace) 实现了宿主 / 客机之间拖拽文件。
vmware-xferlogs - 向虚拟机的日志文件输出日志与调试信息。
vmhgfs-fuse - 挂载 HGFS 共享目录的工具。
内核模块
vmhgfs - 旧有的 HGFS 驱动。这是传统的宿主机-客机间共享目录的方案。
vmxnet - 旧有的 VMXNET 网卡驱动。
```

### 安装
```shell
sudo pacman -S open-vm-tools

#启动服务 
systemctl start vmtoolsd.service
systemctl start vmware-vmblock-fuse.service

#设置开机启动
systemctl enable vmtoolsd.service
systemctl enable vmware-vmblock-fuse.service

#查询服务状态
systemctl status vmtoolsd.service
systemctl status vmware-vmblock-fuse.service

#与宿主机同步时间
vmware-toolbox-cmd timesync enable

#窗口分辨率自动适配
#1.开启3D加速

#2.安装xf86-video-vmware
pacman -S xf86-video-vmware

#3.安装gtkmm和gtk2
pacman -S gtkmm gtk2

#4.添加相关模块
vim /etc/mkinitcpio.conf
#修改文件
MODULES=(vsock vmw_vsock_vmci_transport vmw_balloon vmw_vmci vmwgfx)
#然后执行
mkinitcpio -p linux

#5.重新启动vmtoolsd.service
systemctl restart vmtoolsd.service
```

### 拖拽复制粘贴
```
#为了确保拖拽与复制粘贴功能正常工作，需要安装 open-vm-tools 和 gtkmm3 这两个包。
pacman -S gtkmm3 
#安装完成，重新启动系统后就可复制了。
```

## End
Thanks!🙏
