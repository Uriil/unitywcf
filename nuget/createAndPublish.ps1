PARAM 
(
	[Parameter(Mandatory=$true)]
	[string] $ApiKey
)

$destinationDll = "lib\net45\Unity.Wcf.dll"

Write-Host 'Copying dll file...'
Copy-Item ..\Unity.Wcf\bin\Release\Unity.Wcf.dll $destinationDll

Write-Host 'Updating nuspec version file...'
$nuspecFile = 'Unity.Wcf.nuspec'
[xml]$nuspec = Get-Content $nuspecFile
$version = (Get-Item $destinationDll).VersionInfo.FileVersion
$nuspec.package.metadata.version = $version
$nuspec.Save("$pwd\$nuspecFile")

Write-Host 'Publishing package...'
.\nuget.exe pack $nuspecFile
.\nuget.exe setapikey $ApiKey
.\nuget.exe push "UnityWcf.$version.nupkg"

Write-Host 'Removing files...'
Remove-Item *.dll
Remove-Item *.xml
Remove-Item *.nupkg
Remove-Item -Path lib -Recurse

Write-Host 'Done'