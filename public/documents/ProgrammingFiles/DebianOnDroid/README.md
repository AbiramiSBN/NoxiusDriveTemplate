# DebianOnDroid

Run a full **Debian desktop** or command-line environment directly on your Android device using **Termux** — no root required.

---

## 🚀 Overview
**DebianOnDroid** uses **proot-distro** inside Termux to install and launch Debian (Stable branch).  
It includes a desktop environment selector (GNOME, KDE, or XFCE) and sets up a **VNC server** for full graphical access — turning your phone into a portable Linux workstation.

---

## 🧩 Features

- 🪶 **No root access needed**  
- 🧱 **Debian (Stable & Lightweight)**  
- 🖥️ Choose your desktop:
  - **GNOME** – Modern, feature-rich interface  
  - **KDE Plasma** – Beautiful and customizable  
  - **XFCE** – Lightweight and fast (recommended)  
- 🔒 Includes secure **VNC access**  
- 🧰 Auto-generates helper scripts (`start-vnc.sh`, `stop-vnc.sh`, `restart-vnc.sh`)  
- 🌍 Locale and configuration pre-set (UTF-8)  

---

## 📦 Installation

### 1. Update Termux and install dependencies
```bash
pkg update -y && pkg upgrade -y
pkg install proot-distro wget -y
````

### 2. Install Debian

```bash
proot-distro install debian
```

### 3. Run the setup script

This script will guide you through selecting and installing your desktop environment:

```bash
bash install_debian_desktop.sh
```

You can choose between:

* `1` → GNOME
* `2` → KDE Plasma
* `3` → XFCE (recommended)

---

## 🖥️ Starting the Desktop

Once installation completes:

```bash
proot-distro login debian
~/start-vnc.sh
```

Then connect from any **VNC Viewer** app to:

```
localhost:5901
```

💡 The first time you run `vncserver`, you’ll be asked to create a password.

---

## 🔧 Helper Scripts

After installation, these scripts will be available inside Debian:

| Script             | Purpose                 |
| ------------------ | ----------------------- |
| `~/start-vnc.sh`   | Starts the VNC server   |
| `~/stop-vnc.sh`    | Stops the VNC server    |
| `~/restart-vnc.sh` | Restarts the VNC server |

---

## 🧹 Troubleshooting

If your desktop fails to start or GNOME reports systemd/login1 errors:

```bash
find /usr -type f -iname "*login1*" -exec rm -f {} \;
```

If you need to remove an existing distro:

```bash
proot-distro remove debian
```

---

## 🔗 Recommended VNC Clients

**For Android:**

* [RealVNC Viewer](https://play.google.com/store/apps/details?id=com.realvnc.viewer.android)
* [bVNC](https://play.google.com/store/apps/details?id=com.iiordanov.freebVNC)
* [AVNC (F-Droid)](https://f-droid.org/en/packages/com.gaurav.avnc/)

**For Termux (CLI):**

```bash
pkg install tigervnc
vncviewer localhost:5901
```

---

## 🧠 Quick Start Recap

```bash
# Login to Debian
proot-distro login debian

# Start the VNC desktop
~/start-vnc.sh

# Connect using VNC viewer at localhost:5901
```

---

## 🧾 Notes

* Debian is more stable and lightweight than Ubuntu inside Termux environments.
* GNOME and KDE require at least **2GB RAM**. XFCE works well even on **1GB** devices.
* Installation time ranges from **5–30 minutes**, depending on the desktop choice.

---
