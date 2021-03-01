gc 'c:\Temp\111.txt'|%
    {
        if (Test-Connection $_ -Count 1 -Quiet)
        {
            if (test-connection -computername $_ -Quiet) 
                {
                    Copy-Item -Path "c:\Temp\w7.msu" -Destination "\\$_\c$\temp\" -Force
                    Write-host $_
                }
        }
    }