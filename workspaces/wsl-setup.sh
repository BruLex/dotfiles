if [ -z "$(awk -F "=" '/generateResolvConf/ {print $0}' /etc/wsl.conf)" ]; then
  echo -e "[network]\ngenerateResolvConf = false" >>/etc/wsl.conf
fi

if command -v powershell.exe >/dev/null; then
  # TODO: Use fix-vpn.ps1 and pass it to powershell.exe command
  (powershell.exe -File 'D:\Tools\fix-vpn.ps1' -Silent &)
fi
