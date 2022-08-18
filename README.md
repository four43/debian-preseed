# Debian Preseed

A small helper to create a preseeded ISO of Debian for rapid install. Will work in a VM, Netboot, or can be saved to a USB stick. This is rather opinionated to get up and running quickly - 

 * Basic debian install (but can easily add a GUI)
 * Auto networking
 * Single User (as sepcified in vars.sh config)
     * no root active
 * Small LVM with /home, /var, /tmp, swap which can easily be expanded to fit your needs

This is an implementation of: https://wiki.debian.org/DebianInstaller/Preseed/EditIso

[Debian Example .cfg](https://www.debian.org/releases/squeeze/example-preseed.txt)
[partman-auto-recipe.txt](https://github.com/xobs/debian-installer/blob/master/doc/devel/partman-auto-recipe.txt)

## Installation

Assumption: This was tested from an existing Debian machine. Really all that would need to change are the packages that get installed. See ./build to change those.

1. Fork this repo so you can make your own changes, most of this is config. You'll probably want to change a few things
2. Create your own `vars.sh` based on `vars.example.sh`
3. Modify the config sections in preseed.d to your needs
4. Download a Debian ISO [from their website](https://www.debian.org/distrib/netinst#smallcd) (this was created with the amd64 variant, but might work on others)
5. Run `source ./vars.sh && ./build [path to your iso]`
6. A preseed- ISO will be created in the current directory
7. Use the ISO file however you see fit!

## Expanding Partitions

Partitions are creating using LVM, so it's pretty simple to expand them:

```bash
sudo lvextend -l 25G /dev/mapping/main/var
resize2fs /dev/mapping/main/var
```


