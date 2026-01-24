FROM archlinux:latest

# Update
RUN pacman -Syy --noconfirm
RUN pacman-key --init
RUN pacman -S --noconfirm archlinux-keyring
RUN pacman -Syu --overwrite "*" --noconfirm

# Install dependencies
RUN pacman -S --noconfirm --overwrite "*" cmake luajit ncurses readline libunistring libidn2 libnghttp2 libnghttp3 libpsl zlib openssl libssh2 xz zstd libcap util-linux-libs libassuan npth libxcrypt libseccomp libffi libbpf ninja mpdecimal python python-tqdm meson cppdap hicolor-icon-theme jsoncpp libuv rhash m4 diffutils db5.3 perl autoconf automake jansson binutils bison debugedit fakeroot flex libmpc libisl gcc groff libtool gc guile make patch pkgconf sudo texinfo which base-devel xf86-video-vesa xorg-bdftopcf libpipeline less man-db xorg-docs xorg-font-util xorg-fonts-alias-100dpi xorg-fonts-100dpi xorg-fonts-alias-75dpi xorg-fonts-75dpi xorg-fonts-encodings xorgproto libice xorg-iceauth libpng graphite harfbuzz freetype2 libfontenc xorg-mkfontscale xcb-proto libxdmcp libxau libxcb libx11 libxext libpciaccess libdrm libxfixes libxshmfence libxxf86vm libedit llvm-libs lm_sensors default-cursors wayland libomxil-bellagio mesa libglvnd libepoxy libxfont2 pixman xkeyboard-config libxkbfile xorg-xkbcomp libxrender libxrandr xorg-setxkbmap xorg-server-common libunwind mtdev libevdev libgudev libwacom libinput xf86-input-libinput libxcvt xorg-server xorg-util-macros xorg-server-devel xcb-util xcb-util-image xcb-util-renderutil xcb-util-wm xcb-util-keysyms xorg-server-xephyr xorg-server-xnest libsm libxt libxmu xorg-xauth xorg-server-xvfb xorg-sessreg xorg-smproxy fontconfig libxft xorg-x11perf xorg-xbacklight xorg-xcmsdb libxcursor xorg-xcursorgen libxi libxtst libxcomposite libxinerama xorg-xdpyinfo xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost xorg-xrandr xorg-xinput xorg-xkbevd libxpm libxaw xorg-xkbutils xorg-xkill xorg-xlsatoms xorg-xlsclients xorg-xmodmap xorg-xpr xorg-xprop xorg-xrdb xorg-xrefresh xorg-xset xorg-xsetroot libxv xorg-xvinfo libei xorg-xwayland xorg-xwd xorg-xwininfo xorg-xwud vulkan-icd-loader vulkan-tools vulkan-headers libxdamage libxres wayland wayland-protocols libxkbcommon hidapi sdl2 seatd spirv-tools glslang benchmark lzo cairo fribidi libdatrie libthai pango libdecor perl-error perl-timedate perl-mailtools git

# Compile
RUN git clone https://github.com/davirxavier/gamescope.git
RUN git checkout issue-692-bicubic
RUN git submodule update --init

RUN sed -i 's/cmake_minimum_required(VERSION .*)/cmake_minimum_required(VERSION 3.5)/' subprojects/openvr/CMakeLists.txt

RUN meson setup build
RUN ninja -C build
