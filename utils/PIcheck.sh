#!/bin/bash

# Check current status of PI

echo '*** Check status of systemd services'
systemctl --no-pager status nfcserver2 nfcserver3 kiosk_beeper launch_kiosk2

echo '*** Service starts'
journalctl -b | grep nfc | grep -i Started

echo '*** Versions available and installed version'
apt list nfcserver2 -a

echo '*** Architecture (should be armv7l)'
uname -m

echo '*** OS version: should be PRETTY_NAME="Raspbian GNU/Linux 11 (bullseye)"'
cat /etc/os-release

echo '*** Word size: should be 32'
getconf LONG_BIT

echo '*** unattended-upgrades email: MailOnlyOnError should be commented out'
grep Mail /etc/apt/apt.conf.d/51unattended-upgrades

echo '*** unattended-upgrades files'
sudo ls -l /etc/apt/trusted.gpg.d/rfstag.gpg /etc/apt/sources.list.d/rfstag.list
# Should be
# -rw-r--r-- 1 root root   94 Mar  6  2023 /etc/apt/sources.list.d/rfstag.list
# -rw-r--r-- 1 root root 4025 Mar  6  2023 /etc/apt/trusted.gpg.d/rfstag.gpg

echo '*** Dwservice monitor'
grep "monitor_desktop_notification" /usr/share/dwagent/config.json
# Fix if not set: sed -i.bak -e '/listen_port/a \ "monitor_desktop_notification": "none",' /usr/share/dwagent/config.json
# Fix if already set: sed  -i.bak -e "/monitor_desktop_notification/s/visible/none/" /usr/share/dwagent/config.json

echo '*** unattended-upgrade dry run'
sudo unattended-upgrade --dry-run