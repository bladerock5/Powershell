
#$server="192.168.0.28"
$server="192.168.0.60"
$pathroot="C:\SheduledScripts\common"

$pathroot="C:\SheduledScripts\common"
$offhours_period=30
$offhours_start=21
$offhours_end=05
$offhours_limit=30
$config=import-clixml -Path ($pathroot+"\msg_db.xml") -erroraction silentlycontinue

$msg_fail=@()

$now=get-date
if ($config.messages.count -ge 1) {
    foreach ($msg in $config.messages) {
        if($msg.offhours) {
            #skip if not offhours
            if($now.Hour -ge $offhours_end -and $now.Hour -lt $offhours_start) {
                $msg_fail+=$msg
                continue
            }
            #прошел период отправки, сброс счётчика
            if($now -ge (get-date $config.limitdate).AddMinutes($offhours_period)) {
                $config.limitdate=$now
                $config.limitcount=0
            }
            #limit reached
            if($config.limitcount -ge $offhours_limit) {
                $msg_fail+=$msg
                continue
            }
            $config.limitcount+=1
        }
        try {
			if($msg.priority) {
				$priority='High'
			} else {
				$priority='Normal'
			}
			
            $margs=@{}
            @('cc','Attachments') | % {
                if($msg.$_) {
                    $margs[$_]=$msg.$_
			    }
            }
            Send-MailMessage -From $msg.from -to $msg.to -Subject $msg.subject -Body $msg.body -BodyAsHtml -Encoding ([System.Text.Encoding]::UTF8) -SmtpServer $server -erroraction Stop -Priority $priority @margs
        }
        catch {
            $msg.reason=$_.Tostring()
            $msg_fail+=$msg
        }
    }
    $config.messages=$msg_fail
    export-clixml -InputObject $config -Path ($pathroot+"\msg_db.xml")
}

Get-PSSession | Remove-PSSession