gc 'e:\111.txt'|%
{
    if (Test-Connection $_ -Count 1 -Quiet)
        {
            Copy-Item -Path "e:\bispc\*" -Destination "\\$_\c$\Program Files\BIS\BisPC" -Force
        }
}