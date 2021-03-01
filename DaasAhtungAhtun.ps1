# $ConnectionBroker - Активный сервер RDCB. Если не указан, будет произведена попытка выявить его автоматически (для этого обязательно чтобы скрипт выполнялся на одном из серверов фермы RDS)
# $SessionHostCollection – Имя RD-коллекции в которой нужно вывести сообщение.
# 
$ConnectionBroker = "msk02daas01.office.softline.ru"
$SessionHostCollection = "My Virtual Desktop"

$MessageTitle = "Сообщение от Инженерного подразделения"
$MessageText = "Коллеги, добрый день.
В свете возросшей нагрузки на оборудование, произошедшей из-за 
увеличения использования сервиса  Daas, вероятно появление 
ограничений производительности и доступности сервиса.
В первую очередь эта ситуация спровоцирована появившейся 
практикой хранения документов внутри Daas.
Убедительная просьба: использовать для хранения сетевые 
ресурсы, которые доступны как из Daas, так и с рабочих ПК. 
Это позволит разгрузить сервис, обеспечить длительную его 
работу без инцидентов.
Просьба, до 14.09.18 перенести все необходимые файлы документов 
на сетевые ресурсы, т.к. 17.09.18 будет запущена процедура 
принудительной очистки профилей. "

If ($ConnectionBroker -eq "") {
 $HAFarm = Get-RDConnectionBrokerHighAvailability
 $ConnectionBroker = $HAFarm.ActiveManagementServer
}

$Sessions = Get-RDUserSession -ConnectionBroker $ConnectionBroker -CollectionName $SessionHostCollection
ForEach ($Session in $Sessions) {
Send-RDUserMessage -HostServer $Session.ServerName -UnifiedSessionID $Session.UnifiedSessionID -MessageTitle $MessageTitle -MessageBody $MessageText 
}