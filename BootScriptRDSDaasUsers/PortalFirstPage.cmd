@echo off
rem ������ ������ � "https://portal.softline.ru" �� "https://portal.softlinegroup.com"
=================================
reg query "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "start page" | find /C /I "https://portal.softline.ru" & if not errorlevel 1 reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "Start Page" /d https://portal.softlinegroup.com /f

rem ������ ��������� ������ � "go.microsoft.com" �� "https://portal.softlinegroup.com"
=================================
reg query "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "start page" | find /C /I "go.microsoft.com" & if not errorlevel 1 reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "Start Page" /d https://portal.softlinegroup.com /f

rem ��������� ������� ����� "start page"
=================================
reg query "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "start page"

rem ���� ���� - �����, ����� ��� - ������� :NotFindStartPage
=================================
IF errorlevel 1 goto :NotFindStartPage

rem �����
=================================
exit

rem ���� ������������ ��������� �� ��������� (������������ ������ �� �����), �� ������������� ��������� �������� https://portal.softlinegroup.com
=================================
:NotFindStartPage
reg query "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "Start Page Redirect Cache" | find /C /I "msn.com" & if not errorlevel 1 reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "Start Page" /d https://portal.softlinegroup.com /f

exit