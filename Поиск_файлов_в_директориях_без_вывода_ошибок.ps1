# Get-ChildItem C:\* -Include *.log -Recurse -Force
#Get-ChildItem \\10.195.32.240\c$\users\* -Include pool.drv -Recurse -Force -ErrorAction Ignore >> C:\Temp\10.195.32.240.txt
Get-ChildItem C:\users\* -Include pool.drv -Recurse -Force -ErrorAction Ignore
Get-ChildItem C:\users\* -Include 4433.dat  -Recurse -Force -ErrorAction Ignore
Get-ChildItem C:\users\* -Include sta.dll -Recurse -Force -ErrorAction Ignore
Get-ChildItem C:\users\* -Include qq34.dat -Recurse -Force -ErrorAction Ignore
Get-ChildItem C:\intel\* -Include 8.exe -Recurse -Force -ErrorAction Ignore
Get-ChildItem C:\temp\*  -Include 8.exe -Recurse -Force -ErrorAction Ignore 
Get-ChildItem C:\Windows\* -Include 8.exe -Recurse -Force -ErrorAction Ignore
Get-ChildItem C:\users\* -Include qq34.dat -Recurse -Force -ErrorAction Ignore
Get-ChildItem C:\temp\* -Include Mimikatz.exe -Recurse -Force -ErrorAction Ignore
Get-ChildItem C:\temp\* -Include Netscan.exe -Recurse -Force -ErrorAction Ignore