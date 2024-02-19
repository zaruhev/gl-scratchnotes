# gl-scratchnotes
A bunch of code files I write to test certain stuff. This repo services primarily as a "where was that one thing I did a long time ago that would help me right now?" repository.

Includes dependencies out-of-the-box to avoid any gross stuff.

## Building

If you intend to build this project as well as its dependencies, cloning the submodules (GLFW and GLM) is necessary as well. Clone the repo via:
```sh
~ $ git clone https://github.com/zaruhev/gl-scratchnotes.git --recurse-submodules
```

### For Beginners
If the CMake building process eludes you at the moment, feel free to run `install.bat`. It will default to the default toolchain of your machine, but use GNU if the core count (first argument) is specified:
```sh
~/gl-scratchnotes $ install.bat
~/gl-scratchnotes $ install.bat 14 # will use GNU toolchain
...
~/gl-scratchnotes $ cd 01-hello-window
~/gl-scratchnotes/01-hello-window $ .\build\HelloWindow.exe
```

### For Experienced Developers

To build the each of the demo programs in this repository, the dependencies should be built with the `CMakeLists.txt` file at the root of the project.

```sh
~/gl-scratchotes $ cmake -S . -B build
```
If you're building with GCC on Windows, you should use specify generating Makefiles via `-G "Unix Makefiles"`:
```sh
~/gl-scratchnotes $ cmake -S . -B build -G "Unix Makefiles"
```
The same goes for using any other build system that isn't MSVC, which is the Windows default builder.

After configuring, build the dependencies via:
```
~/gl-scratchnotes $ cmake --build build
```
> Note: If using GNU/mingw, compile with multiple jobs via `cmake --build build -j <core count>` to minimize compilation times.

### Building Subfolders
To build a nested project folder, simply do the same thing as with building the dependencies within the root directory in each subfolder. For example:
```sh
~/gl-scratchnotes/01-hello-window $ cmake -S . -B build
...
~/gl-scratchnotes/01-hello-window $ cmake --build build
```

> Note: To get fast build times using the GNU toolchain, specify `-j <core count>` at the end of your `cmake --build` command.

## Contributing
This repository is primarily meant as a reference for stuff I will use at some point, but feel free to open PRs for suggestions to existing demos.

### Creating New Projects
You can make a project template using the `newproject.bat` script.
Example:
```sh
~/gl-scratchnotes $ newproject.bat 02-shader-testing ShaderTesting
```
generates a basic project and a demo-ready CMakeLists.txt.
