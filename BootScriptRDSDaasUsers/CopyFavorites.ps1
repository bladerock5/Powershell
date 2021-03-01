# Копирование избранного в профиль сотрудникам
$login = $env:USERNAME
$from1 = "\\dfs\files\Softline\Moscow\IMS\ServiseFolder\GPScripts\FavoritesAll\_Corporate Services"
$from2 = "\\dfs\files\Softline\Moscow\IMS\ServiseFolder\GPScripts\FavoritesAll\_Corporate Sites"
$from3 = "\\dfs\files\Softline\Moscow\IMS\ServiseFolder\GPScripts\FavoritesAll\_Helpful Links"
$to1 = "\\msk02daascl02\Profile\$login\Favorites\_Corporate Services"
$to2 = "\\msk02daascl02\Profile\$login\Favorites\_Corporate Sites"
$to3 = "\\msk02daascl02\Profile\$login\Favorites\_Helpful Links"
$servicesexists = Test-Path $to1
$sitesexists = Test-Path $to2
$linksexists = Test-Path $to3
If (!$servicesexists) {
	$filepath = $env:USERPROFILE + "\errorServices.txt"
	try {
		New-Item -Path $to1 -type directory -Force | Out-Null		
		ROBOCOPY "$from1" "$to1" /z /r:1 /w:15 /xo /xd DfsrPrivate /purge | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
	catch {
		$text = "обнаружена ошибка:"+"$_"
		$text | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
}
else {
	$filepath = $env:USERPROFILE + "\errorServices.txt"
	try {
		ROBOCOPY "$from1" "$to1" /z /r:1 /w:15 /xo /xd DfsrPrivate /purge | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false 
	}
	catch {
		$text = "обнаружена ошибка:"+"$_"
		$text | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
}
If (!$sitesexists) {
	$filepath = $env:USERPROFILE + "\errorsites.txt"
	try {
	New-Item -Path $to2 -type directory -Force | Out-Null
	ROBOCOPY "$from2" "$to2" /z /r:1 /w:15 /xo /xd DfsrPrivate /purge | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
	catch {
		$text = "обнаружена ошибка:"+"$_"
		$text | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
}
else {
	$filepath = $env:USERPROFILE + "\errorsites.txt"
	try {
		ROBOCOPY "$from2" "$to2" /z /r:1 /w:15 /xo /xd DfsrPrivate /purge | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
	catch {
		$text = "обнаружена ошибка:"+"$_"
		$text | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
}
If (!$linksexists) {
	$filepath = $env:USERPROFILE + "\errorlinks.txt"
	try {
		New-Item -Path $to3 -type directory -Force | Out-Null
		ROBOCOPY "$from3" "$to3" /z /r:1 /w:15 /xo /xd DfsrPrivate /purge | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
	catch {
		$text = "обнаружена ошибка:"+"$_"
		$text | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
}
else {
	$filepath = $env:USERPROFILE + "\errorlinks.txt"
	try {
		ROBOCOPY "$from3" "$to3" /z /r:1 /w:15 /xo /xd DfsrPrivate /purge | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
	catch {
		$text = "обнаружена ошибка:"+"$_"
		$text | Out-File -FilePath $filepath -Encoding UTF8 -Force -Confirm:$false
	}
}
