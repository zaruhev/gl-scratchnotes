# gl-scratchnotes
A bunch of code files I write to test certain stuff. This repo services primarily as a "where was that one thing I did a long time ago that would help me right now?" repository.

Includes dependencies out-of-the-box to avoid any gross stuff.

## Building

If you intend to build this project as well as its dependencies, cloning the submodules (GLFW and GLM) is necessary as well. Clone the repo via:
```sh
~ $ git clone https://github.com/zaruhev/gl-scratchnotes.git --recurse-submodules
```

To build the each of the demo programs in this repository, the dependencies should be built with the `CMakeLists.txt` file at the root of the project.

```sh
~/gl-scratchotes $ cmake -S . -B build
```
If you're building with GCC on Windows, you should use specify generating Makefiles via `-G "Unix Makefiles"`:
```sh
~/gl-scratchnotes $ cmake -S . -B build -G "Unix Makefiles"
```
The same goes for using any other build system that isn't MSVC, which is the Windows default builder.

## Building Subfolders
To build a nested project folder, simply do the same thing as with building the dependencies within the root directory in each subfolder. For example:
```sh
~/gl-scratchnotes/01-hello-window $ cmake -S . -B build
...
~/gl-scratchnotes/01-hello-window $ cmake --build build
```

> Note: To get fast build times using the GNU toolchain, specify `-j <core count>` at the end of your `cmake --build` command.

## Contributing
This repository is primarily meant as a reference for stuff I will use at some point, feel free to open PRs for suggestions to existing demos.