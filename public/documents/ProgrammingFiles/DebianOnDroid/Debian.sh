#!/data/data/com.termux/files/usr/bin/bash
# Debian with Desktop Environment via Termux + proot-distro
# Compatible with Android (no root required)
# More stable than Ubuntu for Termux environments

set -e

# Color codes for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display menu
show_menu() {
    clear
    echo ""
    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}║                                                              ║${NC}"
    echo -e "${BLUE}║          Debian Desktop Environment Installer                ║${NC}"
    echo -e "${BLUE}║              For Termux on Android Devices                   ║${NC}"
    echo -e "${BLUE}║                                                              ║${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo ""
    echo -e "  ${YELLOW}Choose your desktop environment:${NC}"
    echo ""
    echo ""
    echo -e "  ${GREEN}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "  ${GREEN}│${NC}  ${BLUE}1)${NC} ${GREEN}GNOME Desktop${NC}                                    ${GREEN}│${NC}"
    echo -e "  ${GREEN}│${NC}     Modern and feature-rich interface                ${GREEN}│${NC}"
    echo -e "  ${GREEN}│${NC}     ${YELLOW}⚠ Heavy: Requires 2GB+ RAM${NC}                        ${GREEN}│${NC}"
    echo -e "  ${GREEN}│${NC}     Best for: High-end devices                       ${GREEN}│${NC}"
    echo -e "  ${GREEN}└─────────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "  ${GREEN}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "  ${GREEN}│${NC}  ${BLUE}2)${NC} ${GREEN}KDE Plasma Desktop${NC}                               ${GREEN}│${NC}"
    echo -e "  ${GREEN}│${NC}     Beautiful and highly customizable                ${GREEN}│${NC}"
    echo -e "  ${GREEN}│${NC}     ${YELLOW}⚠ Heavy: Requires 2GB+ RAM${NC}                        ${GREEN}│${NC}"
    echo -e "  ${GREEN}│${NC}     Best for: Power users who love customization     ${GREEN}│${NC}"
    echo -e "  ${GREEN}└─────────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "  ${GREEN}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "  ${GREEN}│${NC}  ${BLUE}3)${NC} ${GREEN}XFCE Desktop${NC}                                     ${GREEN}│${NC}"
    echo -e "  ${GREEN}│${NC}     Lightweight and fast performance                 ${GREEN}│${NC}"
    echo -e "  ${GREEN}│${NC}     ${GREEN}✓ Recommended: Works on most devices${NC}              ${GREEN}│${NC}"
    echo -e "  ${GREEN}│${NC}     Best for: Daily use, smooth experience           ${GREEN}│${NC}"
    echo -e "  ${GREEN}└─────────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo ""
    echo -e "  ${RED}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "  ${RED}│${NC}  ${BLUE}0)${NC} ${RED}Exit Installer${NC}                                    ${RED}│${NC}"
    echo -e "  ${RED}└─────────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo ""
}

# Get user choice
get_choice() {
    local choice
    read -p "Enter your choice [1-3]: " choice
    echo "$choice"
}

# Main menu
show_menu
CHOICE=$(get_choice)

case $CHOICE in
    1)
        DESKTOP="gnome"
        echo ""
        echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}"
        echo -e "${YELLOW}⚠  WARNING: GNOME Desktop Selected${NC}"
        echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}"
        echo ""
        echo -e "  ${RED}System Requirements:${NC}"
        echo -e "    • Minimum 2GB RAM"
        echo -e "    • 2GB+ free storage"
        echo -e "    • High-end Android device recommended"
        echo ""
        echo -e "  ${YELLOW}Installation Size: ~1.5GB${NC}"
        echo -e "  ${YELLOW}Installation Time: 15-30 minutes${NC}"
        echo ""
        read -p "  Press ENTER to continue or Ctrl+C to cancel..."
        ;;
    2)
        DESKTOP="kde"
        echo ""
        echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}"
        echo -e "${YELLOW}⚠  WARNING: KDE Plasma Desktop Selected${NC}"
        echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}"
        echo ""
        echo -e "  ${RED}System Requirements:${NC}"
        echo -e "    • Minimum 2GB RAM"
        echo -e "    • 2GB+ free storage"
        echo -e "    • High-end Android device recommended"
        echo ""
        echo -e "  ${YELLOW}Installation Size: ~1.5GB${NC}"
        echo -e "  ${YELLOW}Installation Time: 15-30 minutes${NC}"
        echo ""
        read -p "  Press ENTER to continue or Ctrl+C to cancel..."
        ;;
    3)
        DESKTOP="xfce"
        echo ""
        echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
        echo -e "${GREEN}✓  XFCE Desktop Selected (Recommended)${NC}"
        echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
        echo ""
        echo -e "  ${GREEN}System Requirements:${NC}"
        echo -e "    • Minimum 1GB RAM"
        echo -e "    • 1GB free storage"
        echo -e "    • Works on most Android devices"
        echo ""
        echo -e "  ${GREEN}Installation Size: ~800MB${NC}"
        echo -e "  ${GREEN}Installation Time: 5-10 minutes${NC}"
        echo ""
        read -p "  Press ENTER to continue..."
        ;;
    0)
        echo ""
        echo -e "${RED}Exiting installer...${NC}"
        echo ""
        exit 0
        ;;
    *)
        echo ""
        echo -e "${RED}═══════════════════════════════════════════════════════${NC}"
        echo -e "${RED}  ERROR: Invalid choice selected${NC}"
        echo -e "${RED}═══════════════════════════════════════════════════════${NC}"
        echo ""
        exit 1
        ;;
esac

echo ""
echo ""
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}║                  Starting Installation                       ║${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║             [1/6] Updating Termux Packages                   ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
pkg update -y && pkg upgrade -y
pkg install -y proot-distro wget
echo ""
echo -e "${GREEN}✓ Termux packages updated successfully${NC}"
echo ""

echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║           [2/6] Cleaning Previous Installations              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Automatic cleanup of old installations
if [ -d "$PREFIX/var/lib/proot-distro/installed-rootfs/debian" ]; then
    echo -e "${YELLOW}  [*] Found existing Debian installation${NC}"
    echo -e "${YELLOW}  [*] Removing for fresh installation...${NC}"
    proot-distro remove debian 2>/dev/null || true
    rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/debian" 2>/dev/null || true
    echo -e "${GREEN}  ✓ Old installation removed${NC}"
elif [ -d "$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu" ]; then
    echo -e "${YELLOW}  [*] Found existing Ubuntu installation${NC}"
    echo -e "${YELLOW}  [*] Removing for fresh Debian installation...${NC}"
    proot-distro remove ubuntu 2>/dev/null || true
    rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu" 2>/dev/null || true
    echo -e "${GREEN}  ✓ Old installation removed${NC}"
else
    echo -e "${GREEN}  ✓ No previous installations found${NC}"
fi

# Clean up any corrupted cache
rm -rf "$PREFIX/var/lib/proot-distro/dlcache"/*.partial 2>/dev/null || true

echo ""

echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              [3/6] Installing Debian Base                    ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}  ⓘ  Debian is more stable than Ubuntu for Termux${NC}"
echo -e "${YELLOW}  ⓘ  This should complete without errors${NC}"
echo ""

# Install Debian (much more stable than Ubuntu in Termux)
proot-distro install debian

# Verify installation
if [ -d "$PREFIX/var/lib/proot-distro/installed-rootfs/debian/bin" ]; then
    echo ""
    echo -e "${GREEN}✓ Debian base system installed successfully${NC}"
    echo ""
else
    echo ""
    echo -e "${RED}✗ Debian installation failed${NC}"
    echo -e "${RED}  Please check your internet connection and try again.${NC}"
    echo ""
    exit 1
fi

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║         [4/6] Configuring System & Locales                   ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Configure Debian
proot-distro login debian -- bash -c "
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

echo '  [Step 1/4] Configuring package manager...'
dpkg --configure -a 2>/dev/null || true
echo '  ✓ Configuration complete'
echo ''

echo '  [Step 2/4] Updating repository lists...'
apt-get update -qq 2>&1 | grep -v 'Warning' || apt-get update
echo '  ✓ Repository lists updated'
echo ''

echo '  [Step 3/4] Upgrading system packages...'
apt-get upgrade -y -qq 2>&1 | grep -v 'Warning' || apt-get upgrade -y
echo '  ✓ System packages upgraded'
echo ''

echo '  [Step 4/4] Installing locale packages...'
apt-get install -y locales 2>&1 | grep -v 'debconf' || true
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
locale-gen en_US.UTF-8 > /dev/null 2>&1 || locale-gen
update-locale LANG=en_US.UTF-8 2>/dev/null || true
echo '  ✓ Locales configured'
echo ''
"

echo ""
echo -e "${GREEN}✓ System configuration complete!${NC}"
echo ""

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║      [5/6] Installing Desktop Environment & Packages         ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

proot-distro login debian -- bash <<EOF

set -e

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

DESKTOP_ENV="$DESKTOP"

echo "[*] Installing essential packages..."
apt-get install -y -qq \
    dbus-x11 \
    nano \
    wget \
    curl \
    sudo \
    net-tools \
    ca-certificates 2>&1 | grep -v 'debconf' || true

echo "[*] Installing VNC server..."
apt-get install -y -qq tigervnc-standalone-server tigervnc-common 2>&1 | grep -v 'debconf' || true

# Install selected desktop environment
if [ "\$DESKTOP_ENV" = "gnome" ]; then
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║         Installing GNOME Desktop (This may take time)       ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    apt-get install -y --no-install-recommends \
        task-gnome-desktop \
        gnome-terminal \
        nautilus \
        gnome-tweaks \
        firefox-esr 2>&1 | grep -E "^\(Reading|^Unpacking|^Setting" || true
    
elif [ "\$DESKTOP_ENV" = "kde" ]; then
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║         Installing KDE Plasma (This may take time)          ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    apt-get install -y --no-install-recommends \
        task-kde-desktop \
        konsole \
        dolphin \
        kate \
        firefox-esr 2>&1 | grep -E "^\(Reading|^Unpacking|^Setting" || true
    
elif [ "\$DESKTOP_ENV" = "xfce" ]; then
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║            Installing XFCE Desktop (Fast install)           ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    apt-get install -y \
        task-xfce-desktop \
        xfce4-terminal \
        firefox-esr 2>&1 | grep -E "^\(Reading|^Unpacking|^Setting" || true
fi

echo ""
echo "[✓] Desktop environment installed successfully!"
echo ""

echo "[*] Setting up VNC configuration..."
mkdir -p ~/.vnc

echo "[*] Creating VNC startup script for \$DESKTOP_ENV..."
if [ "\$DESKTOP_ENV" = "gnome" ]; then
    cat > ~/.vnc/xstartup <<'EOL'
#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=GNOME
export XDG_SESSION_DESKTOP=gnome
export DESKTOP_SESSION=gnome

if [ -z "\$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval \$(dbus-launch --sh-syntax --exit-with-session)
fi

gnome-session &
EOL

elif [ "\$DESKTOP_ENV" = "kde" ]; then
    cat > ~/.vnc/xstartup <<'EOL'
#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=KDE
export XDG_SESSION_DESKTOP=KDE
export DESKTOP_SESSION=plasma

if [ -z "\$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval \$(dbus-launch --sh-syntax --exit-with-session)
fi

startplasma-x11 &
EOL

elif [ "\$DESKTOP_ENV" = "xfce" ]; then
    cat > ~/.vnc/xstartup <<'EOL'
#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=XFCE
export DESKTOP_SESSION=xfce

if [ -z "\$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval \$(dbus-launch --sh-syntax --exit-with-session)
fi

startxfce4 &
EOL
fi

chmod +x ~/.vnc/xstartup

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              [6/6] Creating Helper Scripts                   ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

cat > ~/start-vnc.sh <<'EOL'
#!/bin/bash
# Kill any existing VNC servers
vncserver -kill :1 2>/dev/null || true
vncserver -kill :2 2>/dev/null || true

# Start VNC server
vncserver -localhost no -geometry 1920x1080 -depth 24 :1

echo ""
echo "════════════════════════════════════════════════════════"
echo "  VNC Server Started Successfully!"
echo "════════════════════════════════════════════════════════"
echo ""
echo "Connect using a VNC client:"
echo "  • Address: localhost:5901"
echo "  • Or use your device IP: YOUR_IP:5901"
echo ""
echo "To stop VNC server:"
echo "  vncserver -kill :1"
echo "  or run: ~/stop-vnc.sh"
echo ""
EOL

cat > ~/stop-vnc.sh <<'EOL'
#!/bin/bash
vncserver -kill :1 2>/dev/null
vncserver -kill :2 2>/dev/null
echo ""
echo "✓ VNC server stopped"
echo ""
EOL

cat > ~/restart-vnc.sh <<'EOL'
#!/bin/bash
echo "Restarting VNC server..."
vncserver -kill :1 2>/dev/null || true
sleep 2
vncserver -localhost no -geometry 1920x1080 -depth 24 :1
echo ""
echo "✓ VNC server restarted"
echo ""
EOL

chmod +x ~/start-vnc.sh ~/stop-vnc.sh ~/restart-vnc.sh

echo ""
echo "════════════════════════════════════════════════════════"
echo "  Setup Complete Inside Debian!"
echo "════════════════════════════════════════════════════════"
echo ""
echo "Desktop Environment: \$DESKTOP_ENV"
echo ""
echo "Helper scripts created:"
echo "  • ~/start-vnc.sh    - Start VNC server"
echo "  • ~/stop-vnc.sh     - Stop VNC server"
echo "  • ~/restart-vnc.sh  - Restart VNC server"
echo ""
EOF

echo ""
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║              🎉  INSTALLATION COMPLETE!  🎉                   ║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo ""
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo -e "  ${GREEN}Desktop Environment Installed:${NC} $(echo $DESKTOP | tr '[:lower:]' '[:upper:]')"
echo -e "  ${GREEN}Distribution:${NC} Debian (Stable & Optimized for Termux)"
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo ""
echo ""
echo -e "${YELLOW}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│                    HOW TO START USING                        │${NC}"
echo -e "${YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
echo ""
echo -e "  ${GREEN}Step 1:${NC} Login to Debian"
echo -e "          ${BLUE}proot-distro login debian${NC}"
echo ""
echo -e "  ${GREEN}Step 2:${NC} Start VNC Server (first time will ask for password)"
echo -e "          ${BLUE}vncserver${NC}"
echo -e "          ${YELLOW}or use:${NC} ${BLUE}~/start-vnc.sh${NC}"
echo ""
echo -e "  ${GREEN}Step 3:${NC} Connect with VNC Viewer"
echo -e "          ${BLUE}Address: localhost:5901${NC}"
echo -e "          ${YELLOW}or your device IP: YOUR_IP:5901${NC}"
echo ""
echo ""
echo -e "${YELLOW}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│               RECOMMENDED VNC CLIENTS                        │${NC}"
echo -e "${YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
echo ""
echo -e "  ${GREEN}For Android:${NC}"
echo -e "    • ${BLUE}RealVNC Viewer${NC}     (Google Play Store)"
echo -e "    • ${BLUE}bVNC${NC}               (Google Play Store)"
echo -e "    • ${BLUE}AVNC${NC}               (F-Droid)"
echo ""
echo -e "  ${GREEN}Or use Termux's built-in VNC viewer:${NC}"
echo -e "    ${BLUE}pkg install tigervnc${NC}"
echo -e "    ${BLUE}vncviewer localhost:5901${NC}"
echo ""
echo ""
echo -e "${YELLOW}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│                   QUICK START GUIDE                          │${NC}"
echo -e "${YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
echo ""
echo -e "  ${GREEN}Start VNC Server:${NC}"
echo -e "    ${BLUE}proot-distro login debian${NC}"
echo -e "    ${BLUE}~/start-vnc.sh${NC}"
echo ""
echo -e "  ${GREEN}Stop VNC Server:${NC}"
echo -e "    ${BLUE}~/stop-vnc.sh${NC}"
echo ""
echo -e "  ${GREEN}Restart VNC Server:${NC}"
echo -e "    ${BLUE}~/restart-vnc.sh${NC}"
echo ""
echo ""
echo -e "${GREEN}════════════════════════════════════════════════════════════════${NC}"
echo -e "  ${YELLOW}Enjoy your Debian desktop environment!${NC}"
echo -e "${GREEN}════════════════════════════════════════════════════════════════${NC}"
echo ""
echo ""
