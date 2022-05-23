if command -v powershell.exe >/dev/null; then
  # TODO: Use fix-vpn.ps1 and pass it to powershell.exe command
  (powershell.exe -File 'D:\Tools\fix-vpn.ps1' -Silent &)
fi
