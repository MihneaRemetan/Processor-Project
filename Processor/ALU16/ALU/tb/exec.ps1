$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Convert-Path (Join-Path $ScriptDir "../../../..")
$FileList = Convert-Path (Join-Path $RootDir "files_debian.txt")
$OutBin = Join-Path $ScriptDir "lic"
$TbFile = Join-Path $RootDir "Processor/ALU16/ALU/ALU_tb2.v"
$WaveFile = Join-Path $ScriptDir "wave.gtkw"

& iverilog -o $OutBin $TbFile -c $FileList
& vvp $OutBin -fst
& gtkwave $WaveFile
