$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Convert-Path $ScriptDir
$FileList = Convert-Path (Join-Path $RootDir "files_debian.txt")
$TmpFileList = Join-Path $RootDir ".filelist.win.tmp"
$OutBin = Join-Path $RootDir "SoC/SoC_tb2.out"
$TbFile = Join-Path $RootDir "SoC/SoC_tb2.v"

# Normalize file list to absolute Windows paths for iverilog
$fileLines = Get-Content -LiteralPath $FileList | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
$absPaths = $fileLines | ForEach-Object { Convert-Path (Join-Path $RootDir $_) }
Set-Content -LiteralPath $TmpFileList -Value $absPaths

& iverilog -o $OutBin -c $TmpFileList $TbFile
& vvp $OutBin
