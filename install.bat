@echo off
setlocal

:BuildWithGNU
    echo Building with GNU.

    cmake -S . -B build -G "Unix Makefiles"
    cmake --build build -j %1

    cd 01-hello-window
    mkdir build

    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B build -G "Unix Makefiles"
    cmake --build build -j %1
goto :INSTALLDONE

:BuildWithDefault
    echo Building with default toolchain.

    cmake -S . -B build
    cmake --build build

    cd 01-hello-window
    mkdir build

    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B build
    cmake --build build
goto :INSTALLDONE

if "%1"=="" (
    call :BuildWithDefault
) else (
    call :BuildWithGNU %1
)

:INSTALLDONE
CALL COLOR 07
echo.
echo.
echo Installation and build completed.
echo.
echo.
echo Run HelloWindow.exe via .\01-hello-window\build\HellowWindow.exe