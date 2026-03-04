Set-Location $PSScriptRoot\..
Get-ChildItem .\reviewed\ | ForEach-Object { 
    $name = $_.Name
    $newName = $name.Replace(".md",".epub")
    write-host "Md: $($_.LastWriteTime), $((Get-Item ".\epubs\$newName").LastWriteTime)"
    if ((-not (Test-Path ".\epubs\$newName")) -or ($_.LastWriteTime -gt (Get-Item ".\epubs\$newName").LastWriteTime)) {
        write-host $_.LastWriteTime, (Get-Item ".\epubs\$newName").LastWriteTime
        Write-Host "Creating $newName"
        pandoc ".\reviewed\$name" -o ".\epubs\$newName"
    } else {
        Write-Host "$newName already exists, skipping."
    }
}
Get-ChildItem .\wip\ | ForEach-Object { 
    $name = $_.Name
    $newName = $name.Replace(".md",".epub")
    
    write-host "Md: $($_.LastWriteTime), $((Get-Item ".\epubs\wip\$newName").LastWriteTime)"
    if ((-not (Test-Path ".\epubs\wip\$newName")) -or ($_.LastWriteTime -ge (Get-Item ".\epubs\wip\$newName").LastWriteTime)) {
        Write-Host "Creating $newName"
        pandoc ".\wip\$name" -o ".\epubs\wip\$newName"
    } else  {
        Write-Host "$newName already exists, skipping."
    }
}