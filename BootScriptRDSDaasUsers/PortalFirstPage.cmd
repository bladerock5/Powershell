@echo off
rem Меняем ссылку с "https://portal.softline.ru" на "https://portal.softlinegroup.com"
=================================
reg query "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "start page" | find /C /I "https://portal.softline.ru" & if not errorlevel 1 reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "Start Page" /d https://portal.softlinegroup.com /f

rem Меняем дефолтную ссылку с "go.microsoft.com" на "https://portal.softlinegroup.com"
=================================
reg query "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "start page" | find /C /I "go.microsoft.com" & if not errorlevel 1 reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "Start Page" /d https://portal.softlinegroup.com /f

rem проверяем наличие ключа "start page"
=================================
reg query "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "start page"

rem ключ есть - выход, ключа нет - переход :NotFindStartPage
=================================
IF errorlevel 1 goto :NotFindStartPage

rem выход
=================================
exit

rem если используются настройки по умолчанию (пользователь ничего не менял), то устанавливаем стартовую страницу https://portal.softlinegroup.com
=================================
:NotFindStartPage
reg query "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "Start Page Redirect Cache" | find /C /I "msn.com" & if not errorlevel 1 reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN" /v "Start Page" /d https://portal.softlinegroup.com /f

exit