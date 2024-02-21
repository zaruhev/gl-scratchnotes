@echo OFF
setlocal

set FOLDER=%~dp0%1
set CMAKELISTS="%FOLDER%\CMakeLists.txt"
set PROJECT_NAME=%2

if NOT "%cd%\"=="%~dp0" (goto :ERR_BAD_DIRECTORY)
if [%1]==[] (goto :ERR_BAD_ARGS)
if "%4"=="FIX" (goto :CMAKE_CONFIGURE)
if exist %FOLDER% (goto :ERR_PATHNAME_UNAVAILABLE)
if [%2]==[] (set PROJECT_NAME=%1)

:WRITE_FOLDER_WITH_CMAKELISTS
echo Building project in %FOLDER% with name %PROJECT_NAME%.
mkdir %FOLDER%

echo cmake_minimum_required(VERSION 3.20) > %CMAKELISTS%
echo project("%PROJECT_NAME%") >> %CMAKELISTS%
echo. >> %CMAKELISTS%
echo set(CMAKE_CXX_STANDARD 20) >> %CMAKELISTS%
echo set(CMAKE_CXX_STANDARD_REQUIRED ON) >> %CMAKELISTS%
echo. >> %CMAKELISTS%
echo file(GLOB_RECURSE SOURCES "src/*.cpp") >> %CMAKELISTS%
echo add_executable("%PROJECT_NAME%" ${SOURCES}) >> %CMAKELISTS%

set PATH_ROOT=%~dp0
set PATH_ROOT=%PATH_ROOT:\=/%
echo target_include_directories("%PROJECT_NAME%" PRIVATE "%PATH_ROOT%/libs/glm") >> %CMAKELISTS%
echo target_include_directories("%PROJECT_NAME%" PRIVATE "%PATH_ROOT%/libs/glfw/include") >> %CMAKELISTS%
echo target_include_directories("%PROJECT_NAME%" PRIVATE "%PATH_ROOT%/libs/glad/include") >> %CMAKELISTS%
echo. >> %CMAKELISTS%

echo target_link_directories("%PROJECT_NAME%" PRIVATE "%PATH_ROOT%/build/libs/glad") >> %CMAKELISTS%
echo target_link_directories("%PROJECT_NAME%" PRIVATE "%PATH_ROOT%/build/libs/glfw/src") >> %CMAKELISTS%
echo target_link_directories("%PROJECT_NAME%" PRIVATE "%PATH_ROOT%/build/libs/glm/glm") >> %CMAKELISTS%
echo. >> %CMAKELISTS%

echo target_link_libraries("%PROJECT_NAME%" PRIVATE glm glfw3 glad) >> %CMAKELISTS%

echo CMake configuration written to %CMAKELISTS%.

mkdir "%FOLDER%\src"
if exist "%~dp0\demos\01-hello-window\src\main.cpp" (
	copy "%~dp0\demos\01-hello-window\src\main.cpp" "%FOLDER%\src\main.cpp" /a
) else (
	echo #include ^<iostream^> > "%FOLDER%\src\main.cpp"
	echo int main^(^) ^{ >> "%FOLDER%\src\main.cpp"
	echo     std::cout ^<^< "Meow, I'm a cat!\n"; >> "%FOLDER%\src\main.cpp"
	echo ^} >> "%FOLDER%\src\main.cpp"
	echo. >> "%FOLDER%\src\main.cpp"
)
echo.
:CMAKE_CONFIGURE
if NOT [%3]==[] (
	set BUILDSYS=%3
	echo Configuring...
	call cmake -S "%FOLDER%" -B "%FOLDER%\build" -G %3
	if NOT %errorlevel%==0 (goto :ERR_BAD_CMAKE_CALL)
)
echo.
echo Template created. Make sure to configure CMake locally. The bootstrap script ONLY configures and builds 01-hello-window.

REM end of WRITE_FOLDER_WITH_CMAKELISTS

goto :eof
:ERR_BAD_DIRECTORY
echo.
echo ERROR: This script must be called in it's directory.
goto :eof
:ERR_BAD_ARGS
echo.
echo ERROR: Invalid input. Please specify a folder name.
goto :eof
:ERR_PATHNAME_UNAVAILABLE
echo.
echo ERROR: Path %FOLDER% already exists.
goto :eof
:ERR_BAD_CMAKE_CALL
echo.
echo ERROR: CMake failed to configure. Do you have the required toolchain installed? If building with MinGW on Windows, specify UNIX as the third argument Run via %~dp0 ^%DIR^% ^%PROJECT^% ^%TOOLCHAIN^% FIX to fix broken cmake config.
rm -rf "%FOLDER%\build"
REM TODO: Use switch args instead of positional args
goto :eof
