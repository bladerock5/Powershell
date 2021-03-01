#Копирование через robocopy
$a = "\\dfs\files\Softline\Moscow\IMS\SystemsBackup\Backup\Veeam\Update"
$b = "\\bgd01vsbkp01\c$\temp\"
robocopy $a $b /E /Z /R:10 /W:3 /MT:64
#$a - источник
#$b - приемник
# E - вложенные каталоги
# Z - дозакачка при отсутствии связи
# R - число попыток копирования
# W - время ожидания между повторами
# MT - кол-во потоков копирования