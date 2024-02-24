# Install Openslide (no root, Ubuntu)

To use Openslide Python on a computer running Ubuntu 18.04, separate installation is required as stated on the [Openslide website](https://openslide.org/api/python/#installing). Although it would have been convenient to use a package manager like apt, lacking root permissions, I had two options:
- Use conda
- Install manually

I opted for the latter due to personal preferences.
This repository contains a bash script for user-level installation of Openslide and its dependencies.

I installed version 3.4.1, which can be found [here](https://openslide.org/download/#source). 


Alternatively, version 4.0.0 is also available, but it requires meson for installation and you have to comment the following instructions:
```sh
./configure --prefix="$INSTALL_DIR"
make
make install
```
remove the # next to the meson instructions and change openslide url.

Once Openslide is installed, you can proceed with the installation of Openslide Python via pip. I have chosen version 1.2.0.

> [!WARNING]  
> When importing Openslide in Python using the 'import openslide' instruction, you may encounter the following error:
> `OSError: libopenslide.so.0: cannot open shared object file: No such file or directory`.
> In this case, you can somewhat naively modify the `lowlevel.py` file and change the instruction
> `else: _lib = cdll.LoadLibrary('libopenslide.so.0')` to load the file.
