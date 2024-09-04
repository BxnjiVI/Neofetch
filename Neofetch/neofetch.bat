@echo off

setlocal enabledelayedexpansion
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do set OS=%%i.%%j.%%k.%%l
for /f "tokens=*" %%i in ('systeminfo ^| find "System Boot Time"') do set BootTime=%%i
set BootTime=%BootTime:~28%
for /f "tokens=2 delims==" %%i in ('wmic path Win32_VideoController get CurrentHorizontalResolution /value') do set width=%%i
for /f "tokens=2 delims==" %%i in ('wmic path Win32_VideoController get CurrentVerticalResolution /value') do set height=%%i
for /f "tokens=2 delims==" %%i in ('wmic cpu get Name /value') do set CPUName=%%i
for /f "tokens=2 delims==" %%i in ('wmic path win32_videocontroller get Name /value') do set GPUName=%%i
for /f "tokens=2 delims==" %%i in ('wmic computersystem get TotalPhysicalMemory /value') do set TotalMemoryBytes=%%i
for /f %%i in ('powershell -command "([math]::Round(%TotalMemoryBytes% / 1GB, 2))"') do set TotalMemoryGB=%%i
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do (
    set IPAddress=%%i
    set IPAddress=!IPAddress:~1!
)
for /f "tokens=2 delims=:" %%A in ('systeminfo ^| find "Domain"') do set "domain=%%A"
set "domain=%domain:~20%"
for /f "tokens=2 delims==" %%A in ('wmic cpu get NumberOfCores /value') do set "cores=%%A"

echo.
echo [91m####################[0m [92m####################[0m   [93m[1m%computername%[0m
echo [91m####################[0m [92m####################[0m   [1m======
echo [91m####################[0m [92m####################[0m   [93m[1mOS:[0m %OS%
echo [91m####################[0m [92m####################[0m   [93m[1mUptime:[0m %BootTime%
echo [91m####################[0m [92m####################[0m   [93m[1mShell:[0m CMD
echo [91m####################[0m [92m####################[0m   [93m[1mResolution:[0m %width%x%height%
echo [91m####################[0m [92m####################[0m   [93m[1mTerminal:[0m Windows Terminal
echo [91m####################[0m [92m####################[0m   [93m[1mCPU:[0m %CPUName%
echo [91m####################[0m [92m####################[0m   [93m[1mGPU:[0m %GPUName%
echo                                             [93m[1mMemory:[0m %TotalMemoryGB% GB
echo [94m####################[0m [93m####################[0m   [93m[1mIP:[0m %IPAddress%
echo [94m####################[0m [93m####################[0m   [93m[1mUser:[0m %USERNAME%
echo [94m####################[0m [93m####################[0m   [93m[1mDomain:[0m %domain%
echo [94m####################[0m [93m####################[0m   [93m[1mWM:[0m Explorer
echo [94m####################[0m [93m####################[0m   [93m[1mCores:[0m %cores%
echo [94m####################[0m [93m####################[0m
echo [94m####################[0m [93m####################[0m
echo [94m####################[0m [93m####################[0m   [41m[41m [43m[43m [42m[42m [44m[44m [45m[45m [0m
echo [94m####################[0m [93m####################[0m   [41m[41m [43m[43m [42m[42m [44m[44m [45m[45m [0m
endlocal