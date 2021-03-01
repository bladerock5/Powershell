#пользователь выполнивший вход на компьютер
(Get-WmiObject -Class Win32_ComputerSystem -Property UserName -ComputerName W6700-IT0000003).UserName