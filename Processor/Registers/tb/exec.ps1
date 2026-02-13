param(
    [ValidateSet("pc","sp","all")]
    [string]$Target = "all"
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RegDir = Convert-Path (Join-Path $ScriptDir "..")
$RootDir = Convert-Path (Join-Path $RegDir "../..")
$AluDir = Join-Path $RootDir "Processor/ALU16"

$Includes = @(
    "-I", (Join-Path $AluDir "Combinational/muxes"),
    "-I", (Join-Path $AluDir "Combinational/RCA"),
    "-I", (Join-Path $AluDir "Registers")
)

function Run-PcTest {
    Write-Host "=== Compilare PC ==="
    $OutBin = Join-Path $RegDir "tb/pc_tb"
    & iverilog @Includes -o $OutBin `
        (Join-Path $RegDir "PC.v") `
        (Join-Path $ScriptDir "PC_tb.v") `
        (Join-Path $AluDir "Registers/ffd.v") `
        (Join-Path $AluDir "Combinational/muxes/mux_2s.v") `
        (Join-Path $AluDir "Combinational/RCA/RCA.v")

    Write-Host "=== Rulare PC Testbench ==="
    & vvp $OutBin
}

function Run-SpTest {
    Write-Host "=== Compilare SP ==="
    $OutBin = Join-Path $RegDir "tb/sp_tb"
    & iverilog @Includes -o $OutBin `
        (Join-Path $RegDir "SP.v") `
        (Join-Path $ScriptDir "SP_tb.v") `
        (Join-Path $AluDir "Registers/ffd.v") `
        (Join-Path $AluDir "Combinational/muxes/mux_2s.v") `
        (Join-Path $AluDir "Combinational/RCA/RCA.v")

    Write-Host "=== Rulare SP Testbench ==="
    & vvp $OutBin
}

New-Item -ItemType Directory -Path (Join-Path $RegDir "tb") -Force | Out-Null

switch ($Target) {
    "pc"  { Run-PcTest }
    "sp"  { Run-SpTest }
    "all" { Run-PcTest; Write-Host ""; Run-SpTest }
}

Write-Host "=== Fisiere VCD generate in tb/ ==="
Get-ChildItem -Path (Join-Path $RegDir "tb") -Filter "*.vcd" -ErrorAction SilentlyContinue
