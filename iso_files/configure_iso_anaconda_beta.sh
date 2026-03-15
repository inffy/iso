#!/usr/bin/env bash

set -eoux pipefail

# Run the standard Aurora ISO configuration
bash "$(dirname "$(realpath "$0")")/configure_iso_anaconda.sh"

# Additionally hide user account creation for beta ISOs
sed -i '/^hidden_spokes =/a\    UserSpoke' /etc/anaconda/profile.d/aurora.conf
sed -i '/^hidden_webui_pages =/a\    anaconda-screen-accounts' /etc/anaconda/profile.d/aurora.conf
