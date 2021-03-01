$userprofile="C:\Users\$env:username"
#������ ����� �� ������ �������
$shPathSh=$userprofile+"\Links"
Remove-Item "$shPathSh\loc*.lnk" -force

#�������� �� ������� ����� ������ ��� ���������� �������� �����
$block_error=0
$shPathSh=$userprofile+"\Links\Local desktop.lnk"
if ( -not ($oshell=New-Object -comObject WScript.Shell )) {$block_error=1}
if ( -not ($shct=$oshell.CreateShortcut($shPathSh)     )) {$block_error=1}
$shct.TargetPath = "\\tsclient\c\users\$env:username\desktop\"
$shct.Arguments = "" 
$shct.Description = "Local Desktop"
if ($shct.Save()) {$block_error=1}

#�������� �� ������� ����� ������ ��� ��������� ����������
$block_error=0
$shPathSh=$userprofile+"\Links\Local documents.lnk"
if ( -not ($oshell=New-Object -comObject WScript.Shell )) {$block_error=1}
if ( -not ($shct=$oshell.CreateShortcut($shPathSh)     )) {$block_error=1}
$shct.TargetPath = "\\tsclient\c\users\$env:username\Documents\"
$shct.Arguments = "" 
$shct.Description = "Local Documents"
if ($shct.Save()) {$block_error=1}