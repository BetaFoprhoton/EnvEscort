Add-Type -AssemblyName PresentationFramework

$installLocation = Read-Host "Enter the installation location, empty to install on desktop"

while (-not $installLocation -eq "" -and -not $isExist) {
    $isExist = 0
    try {
        $isExist = Test-Path $installLocation
    } finally {
        if (-not $isExist) {
            $installLocation = Read-Host "Invalid path, enter the installation location, empty to install on desktop"
        }
    }
}
if ($installLocation -eq "") {
    $installLocation = [System.Environment]::GetFolderPath("Desktop")
}
Write-Output "Installation location: $installLocation"
"Copying files..."
Copy-Item ($pwd.Path + "/AriaMolecule") -Destination $installLocation -Recurse -Force
"Done!"
"Starting notification..."
$flag1 = $true
$flag2 = $true
while ($true) {
    Start-Sleep -Seconds 1
    $date = Get-Date -UFormat "%H:%M"
    if ($flag1 -and $date -eq "22:20") {
        $msgBoxInput =  [System.Windows.MessageBox]::Show("Time to go!!! It's 22:20 now!" , 'Notification', 'YesNo','Information')
        if ($msgBoxInput -eq "Yes") {
            break
        }
        $flag1 = $false
    }
    if ($flag2 -and $date -eq "22:25") {
        [System.Windows.MessageBox]::Show("Time to go!!! It's 22:25 now!",'Information')
        break
        $flag2 = $false
    }
}

"Starting backup..."
Remove-Item ($pwd.Path + "/AriaMolecule") -Recurse -Force
Copy-Item ($installLocation + "/AriaMolecule") -Destination ($pwd.Path + "/AriaMolecule") -Recurse -Force
"Backup complete!"
"Shutting down in 60s..."
#shutdown.exe /s /t 60