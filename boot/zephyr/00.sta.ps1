
# Change code page to UTF-8
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
CLS

$host.ui.RawUI.WindowTitle = "Zephyr-RTOS BUILD ENVIRONMENT"

# Option "zephyr", "gnuarmemb"
$env:ZEPHYR_TOOLCHAIN_VARIANT = "zephyr"
$env:ZEPHYR_SDK_INSTALL_DIR   = "C:/toolchain/zephyr/sdk/0.15.1"
$env:GNUARMEMB_TOOLCHAIN_PATH = "C:/toolchain/gnuarmemb/10.3-2021.10"
$env:ZEPHYR_BASE  = "C:/toolchain/zephyr/zephyr_rtos"

$env:CMAKE_PATH   = "C:/toolchain/cmake/3.23/bin"           # cmake.exe
$env:NINJA_PATH   = "C:/toolchain/ninja/1.10.2"             # ninja.exe
$env:DTC_PATH     = "C:/toolchain/dtc/1.4.7"                # dtc.exe
$env:GCC_ARM_PATH = "C:/toolchain/gnuarmemb/10.3-2021.10/bin"

$env:Path = $env:CMAKE_PATH + ';' + $env:NINJA_PATH + ';' + $env:GCC_ARM_PATH + ';' + $env:DTC_PATH + ';' + $env:Path

# Get-ChildItem env:

Write-Host " Welcome to Zephyr-RTOS build environment" -ForegroundColor White

# cmake -B cmake_build -G Ninja -D BOARD=atsamc21_xpro -D CONF_FILE=prj.conf
Write-Host " example generate cmake command :" -ForegroundColor Green
Write-Host " cmake " -ForegroundColor Red  -NoNewline;
Write-Host "-B " -ForegroundColor Blue -NoNewline;
Write-Host "cmake_build " -ForegroundColor Magenta -NoNewline;
Write-Host "-G " -ForegroundColor Blue -NoNewline;
Write-Host "Ninja " -ForegroundColor Magenta -NoNewline;
Write-Host "-D " -ForegroundColor Blue -NoNewline;
Write-Host "BOARD" -ForegroundColor Magenta -NoNewline;
Write-Host "=" -ForegroundColor Blue -NoNewline;
Write-Host "atsamc21_xpro " -ForegroundColor Yellow -NoNewline;
Write-Host "-D " -ForegroundColor Blue -NoNewline;
Write-Host "CONF_FILE" -ForegroundColor Magenta -NoNewline;
Write-Host "=" -ForegroundColor Blue -NoNewline;
Write-Host "prj.conf" -ForegroundColor Magenta;
Write-Host ""

# cmake -B cmake_build -G Ninja -D BOARD=bmu-a22c -D BOARD_ROOT=. -D CONF_FILE=prj.conf
Write-Host " cmake " -ForegroundColor Red  -NoNewline;
Write-Host "-B " -ForegroundColor Blue -NoNewline;
Write-Host "cmake_build " -ForegroundColor Magenta -NoNewline;
Write-Host "-G " -ForegroundColor Blue -NoNewline;
Write-Host "Ninja " -ForegroundColor Magenta -NoNewline;
Write-Host "-D " -ForegroundColor Blue -NoNewline;
Write-Host "BOARD" -ForegroundColor Magenta -NoNewline;
Write-Host "=" -ForegroundColor Blue -NoNewline;
Write-Host "bmu-a22c " -ForegroundColor Yellow -NoNewline;
Write-Host "-D " -ForegroundColor Blue -NoNewline;
Write-Host "BOARD_ROOT" -ForegroundColor Magenta -NoNewline;
Write-Host "=" -ForegroundColor Blue -NoNewline;
Write-Host ". " -ForegroundColor Magenta -NoNewline;
Write-Host "-D " -ForegroundColor Blue -NoNewline;
Write-Host "CONF_FILE" -ForegroundColor Magenta -NoNewline;
Write-Host "=" -ForegroundColor Blue -NoNewline;
Write-Host "prj.conf" -ForegroundColor Magenta;
Write-Host ""

# ninja -C cmake_build
Write-Host " example build command :" -ForegroundColor Green
Write-Host " ninja " -ForegroundColor Red  -NoNewline;
Write-Host "-C " -ForegroundColor Blue -NoNewline;
Write-Host "cmake_build " -ForegroundColor Magenta;
Write-Host ""

# Ready to rock !!!
Clear-History
$cmd_history = (Get-Item .).FullName + '\cmd_history.xml'
Add-History -InputObject (Import-Clixml -Path $cmd_history)

# Create Junction
# New-Item -ItemType Junction -Path "cmake_build" -Target "T:\cmake_build\bmu-a22c\"

# Cmake command for MCUBoot
$boardRootPath = "C:/ndrs_wks/vcs/s/sikor/sikor_bms_bmu_csu_fw"
#$dtcOverlayFile = "$boardRootPath/boards/bmu-a22c.overlay"

Invoke-Expression -Command "cmake -B cmake_build -G Ninja -D BOARD=bmu-a22c -D BOARD_ROOT=$boardRootPath -D CONF_FILE=boards/bmu-a22c.conf"
#Invoke-Expression -Command "cmake -B cmake_build -G Ninja -D BOARD=bmu-a22c -D BOARD_ROOT=$boardRootPath -D DTC_OVERLAY_FILE=$dtcOverlayFile -D CONF_FILE=prj.conf"

# NOTE
# Generate list file by using objdump
# -S, --source             Intermix source code with disassembly
# -d, --disassemble        Display assembler contents of executable sections
# C:\toolchain\zephyr\sdk\0.15.1\arm-zephyr-eabi\bin\arm-zephyr-eabi-objdump.exe -S -d .\mw_bal.cpp.obj > mw_bal.lst
