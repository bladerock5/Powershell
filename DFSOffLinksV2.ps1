$as = @()
Get-DfsnFolder -Path "\\office.softline.ru\FILES\*" | % {$as += $_.Path} #папки в корне 'FILES'
foreach ($a in $as){
    $string = (Get-DfsnFolderTarget -Path $a).TargetPath #целевые шары папок корня
    $b = $string.Substring(2) #Удаляем первые 2 символа в строке
    $c = $b.Split("/\") #Делим строки знаком "\" на элементы массива
    $per = $c[0] #искомый элемент массива, проверка
    if ($per -match "null") { #если начинается с 'null'
        #действие - проверить следующее значение
    } elseif ($per -match "^\d") {
        if (!((Resolve-DNSName -Name $per).NameHost)) { #если не резольвится
            if (!(ping -c 1 $per)) { #если не пингуется
                Write-Host "$per не пингуется, нужно отключить" #действие
                Set-DfsnFolderTarget -Path $a -TargetPath $string -State "Offline" –ErrorAction SilentlyContinue -WhatIf
                
            }
        }                
    } else {
        if (!($per -match "[.]")){    
            Try {
                if (Get-ADComputer $per) {
                    continue
                }
            }
            Catch {
                "$per нет в АД, нужно отключить " #действие
                Set-DfsnFolderTarget -Path $a -TargetPath $string -State "Offline" –ErrorAction SilentlyContinue -WhatIf
            }
        }    
    }    
}