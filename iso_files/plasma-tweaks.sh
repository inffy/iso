#!/usr/bin/env bash
set -eoux pipefail

# add installer to kickoff
sed -i '2s/$/;liveinst.desktop/' /usr/share/kde-settings/kde-profile/default/xdg/kicker-extra-favoritesrc

tee -a /etc/xdg/kwalletrc <<EOF
[Wallet]
Enabled=false
EOF

git clone https://github.com/get-aurora-dev/branding /tmp/branding
cp -r /tmp/branding/iso_files/usr/* /usr/
rm -rf /tmp/branding

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Setup conky hardware info overlay
mkdir -p /usr/share/conky /etc/xdg/autostart
cp "$SCRIPT_DIR/conky/conky.conf" /usr/share/conky/conky.conf
cp "$SCRIPT_DIR/conky/conky_efi.sh" /usr/share/conky/conky_efi.sh
chmod +x /usr/share/conky/conky_efi.sh
cp "$SCRIPT_DIR/conky/conky.desktop" /etc/xdg/autostart/conky.desktop

