<# :
:: Header to create Batch/PowerShell hybrid
@echo off
cd %~dp0
echo 此脚本将会在当前文件夹安装Mirai Dice
echo 请确定脚本放置于正确的文件夹！
pause
setlocal
set "POWERSHELL_BAT_ARGS=%*"
if defined POWERSHELL_BAT_ARGS set "POWERSHELL_BAT_ARGS=%POWERSHELL_BAT_ARGS:"=\"%"
endlocal & powershell -NoLogo -NoProfile -Command "$_ = $input; Invoke-Expression $( '$input = $_; $_ = \"\"; $args = @( &{ $args } %POWERSHELL_BAT_ARGS% );' + [String]::Join( [char]10, $( Get-Content \"%~f0\" ) ) )"

:: Any batch code that gets run after your PowerShell goes here
pause
goto :EOF
#>

Import-Module BitsTransfer

if (Test-Path -Path ".\mcl.jar" -PathType Leaf)
{
    Write-Host "当前文件夹下已经有一份Mirai安装!" -ForegroundColor red
    Exit
}

Try 
{
	Add-Type -AssemblyName System.IO.Compression.FileSystem -ErrorAction Stop
	function Unzip
	{
		param([string]$zipfile, [string]$outpath)

		[System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
	}
}
Catch {
	if (-Not (Test-Path -Path ".\unzip.exe" -PathType Leaf))
	{
		$ZipURL = "https://gitee.com/suhuiw4123/mirai-dice-release/attach_files/646126/download/unzip.exe"
		Start-BitsTransfer -Source $ZipURL -Destination ".\unzip.exe"
	}
	
	if (-Not (Test-Path -Path ".\unzip.exe" -PathType Leaf))
	{
		Write-Host "无法加载Unzip" -ForegroundColor red
		Exit
	}
	
	function Unzip
	{
		param([string]$zipfile, [string]$outpath)

		& .\unzip.exe $zipfile -d $outpath
	}
}

Write-Host "检测Git"
$GitURL = "https://gitee.com/suhuiw4123/mirai-dice-release/attach_files/637695/download/MinGit-Windows-x86.zip"
$GIT = ""

Try 
{
	$Command = Get-Command -Name git -ErrorAction Stop
	$GIT = "git"
}
Catch {}

Try 
{
	$Command = Get-Command -Name ".\git\cmd\git" -ErrorAction Stop
	$GIT = ".\git\cmd\git"
}
Catch {}

if ($GIT -eq "")
{
	Start-BitsTransfer -Source $GitURL -Destination ".\git.zip"
	Unzip ".\git.zip" ".\git\"
	Remove-Item ".\git.zip"
	Try 
	{
		$Command = Get-Command -Name ".\git\cmd\git" -ErrorAction Stop
		$GIT = ".\git\cmd\git"
	}
	Catch 
	{
		Write-Host "无法加载Git!" -ForegroundColor red
		Exit
	}
}

Write-Host "Git: $GIT" -ForegroundColor green
Remove-Item -Path .\.git -Recurse -ErrorAction SilentlyContinue

& $GIT init -b main
& $GIT remote add origin https://gitee.com/diceki/mirai-dice-windows
& $GIT fetch --depth=1
& $GIT checkout main
Write-Host "安装成功!" -ForegroundColor green