# arch dotfiles

- [arch dotfiles](#arch-dotfiles)
  - [1 系统配置](#1-系统配置)
    - [1.1 配置源](#11-配置源)
    - [1.2 配置中文](#12-配置中文)
    - [1.3 配置终端](#13-配置终端)
    - [1.4 配置音频蓝牙](#14-配置音频蓝牙)
    - [1.5 配置显卡](#15-配置显卡)
  - [2 安装软件](#2-安装软件)
  - [3 优化配置](#3-优化配置)
    - [3.1 双系统时间同步](#31-双系统时间同步)
    - [3.2 触摸板轻触单击](#32-触摸板轻触单击)
    - [3.3 gtk主题美化](#33-gtk主题美化)
      - [3.3.1 鼠标主题](#331-鼠标主题)
      - [3.3.2 全局主题](#332-全局主题)
      - [3.3.3 图标主题](#333-图标主题)
## 1 系统配置

### 1.1 配置源

- 配置`pacman`
    - `mirrorlist`

        `/etc/pacman.d/mirrorlist`
        ```shell
        Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
        ```
    - `archlinuxcn`

        `/etc/pacman.conf`
        ```shell
        [archlinuxcn]
        SigLevel = Optional TrustAll
        Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch

        ```
    - 更新
        ```shell
        sudo pacman -S archlinuxcn-keyring #安装导入GPG key
        sudo pacman -Syyu
        ```

- 配置`pip`

    `~/.pip/pip.conf`
    ```shell
    [global]
    index-url = https://pypi.tuna.tsinghua.edu.cn/simple
    [install]
    trusted-host = https://pypi.tuna.tsinghua.edu.cn
    ```

### 1.2 配置中文
1. 安装字体
    ```shell
    sudo pacman -S ttf-fira-code ttf-roboto noto-fonts ttf-dejavu wqy-bitmapfont wqy-microhei wqy-microhei-lite wqy-zenhei noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts noto-fonts-emoji
    yay -S nerd-fonts-source-code-pro
    ```

2. 配置`fontconfig`
    ```shell
    mkdir ~/.config/fontconfig
    vim ~/.config/fontconfig/fonts.conf
    ```
    [fonts.conf](./.config/fontconfig/fonts.conf) 


3. 安装表情符号
    ```shell
    yay -S x11-emoji-picker
    ```

4. 安装`fcitx`
    1. 安装
        ```shell
        sudo pacman -S fcitx fcitx-im fcitx-configtool
        ```

    2. 配置
    
        `~/.xprofile`
        ```shell
        export GTK_IM_MODULE=fcitx 
        export QT_IM_MODULE=fcitx 
        export XMODIFIERS="@im=fcitx"
        ```
    3. 开机启动

        `~/.config/i3/config`
        ```shell
        exec --no-startup-id fcitx
        ```

5. 安装拼音输入法
    ```shell
    yay -S fcitx-sogoupinyin fcitx-cloudpinyin
    ```

6. 设置全局中文

    `~/.xprofile`
    ```shell
    export LANG=zh_CN.UTF-8
    export LANGUAGE=zh_CN:en_US
    ```

### 1.3 配置终端
1. 安装`alacritty`
    ```shell
    yay -S alacritty
    ```

2. 安装`oh-my-zsh`
    1. 安装
    ```shell
    sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)"
    ```

    2. 插件
        ```shell
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
        git clone https://github.com/zsh-users/zsh-history-substring-search.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
        ```
        `autojump&fzf`
        ```shell
        yay -S autojump fzf
        ```
        `~/.zshrc`
        ```shell
        plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search autojump fzf)
        ```

### 1.4 配置音频蓝牙
- 安装`alsamixer`
    ```shell
    sudo pacman -S alsa-utils
    ```

- 安装蓝牙
    ```shelll
    yay -S pulseaudio-alsa pulseaudio-bluetooth bluez bluez-libs bluez-utils
    ```

- 蓝牙配置
    - `/etc/bluetooth/main.conf`
        ```shell
        AutoEnable=true
        DiscoverableTimeout = 0
        ```

    - `/etc/pulse/system.pa`
        ```shell
        load-module module-bluetooth-policy
        load-module module-bluetooth-discover
        ```


### 1.5 配置显卡
- 安装`intel`核显
    ```shell
    sudo pacman -S xf86-video-intel
    ```

- 安装`nvidia`
    ```shell
    sudo pacman -S nvidia nvidia-utils nvidia-settings
    ```

- 安装`optimus manager`
    ```shell
    yay -S optimus-manager optimus-manager-qt
    ```
    ```shell
    sudo systemctl enable optimus-manager.service
    sudo systemctl start optimus-manager.service
    ```

- 安装`nouveau`
    ```shell
    sudo pacman -S xf86-video-nouveau
    ```

- `intel`画面撕裂
    `/etc/X11/xorg.conf.d/20-intel.conf`
    ```shell
    Section "Device"
      Identifier  "Intel Graphics"
      Driver      "intel"
      Option      "DRI" "3"             # DRI3 is now default
      #Option      "AccelMethod"  "sna" # default
      #Option      "AccelMethod"  "uxa" # fallback
      # Fixes screen tearing:
      Option      "TearFree"     "true"
    EndSection
    ```

## 2 安装软件
```shell
yay -S volumeicon picom xfce4-power-manager clipit feh blueman polkit-gnome polybar mpd google-chrome pcmanfm rofi
```


## 3 优化配置
### 3.1 双系统时间同步
**为什么Linux比Windows快8小时**

linux使用的是UTC,windows使用的是CST
1. 修改linux系统使用主板时间
    ```shell
    sudo timedatectl set-local-rtc 1
    ```
2. 启动时间同步
    ```shell
    sudo timedatectl set-ntp true
    ```
输入`timedatectl`查看

### 3.2 触摸板轻触单击
`sudo vim /etc/X11/xorg.conf.d/30-touchpad.conf`
```shell
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
EndSection
```

### 3.3 gtk主题美化
安装`LXAppearance`
```shell
yay -S lxappearance
```

#### 3.3.1 鼠标主题
```shell
yay -S xcursor-breeze
```
路径：`/usr/share/icons`

[cursor theme](https://wiki.archlinux.org/title/Cursor_themes)

#### 3.3.2 全局主题
路径: `/usr/share/themes` `~/.local/share/themes` `~/.themes`

[gtk3/gtk4](https://www.gnome-look.org/browse?cat=135&ord=latest)

#### 3.3.3 图标主题
路径:`~/.local/share/icons`

[icons theme](https://www.gnome-look.org/browse?cat=132&ord=latest)


