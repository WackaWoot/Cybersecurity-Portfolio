#Get the current directory
$currentDirectory = Get-Location

#Retrieve the contents of the current directory
$directory = Get-ChildItem -Path $currentDirectory

#Iterate through each item in the directory
foreach ($item in $directory) {
    # Check if $item is a file or directory
    if ($item.PSIsContainer) {
        Write-Host "Directory: $($item.FullName)"
    } else {
        Write-Host "File: $($item.FullName)"
    }

#Get the ACL for the current item
    $acl = Get-Acl -Path $item.FullName

    # Display the ACL details
    Write-Host "ACL for $($item.FullName):"
    $acl | Format-List
    Write-Host "---------------------------------------------"
}