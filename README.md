# Debian Preseed

A small helper to create a preseeded ISO of Debian for rapid install. Will work in a VM, Netboot, or can be saved to a USB stick. This is rather opinionated to get up and running quickly - 

 * Basic debian install (but can easily add a GUI)
 * **Sets user + ssh key auth**
 	* Disables root login
 * Auto networking
 * Small LVM with /home, /var, /tmp, swap which can easily be expanded to fit your needs

This is an implementation of: https://wiki.debian.org/DebianInstaller/Preseed/EditIso

[Debian Example .cfg](https://www.debian.org/releases/squeeze/example-preseed.txt)
[partman-auto-recipe.txt](https://github.com/xobs/debian-installer/blob/master/doc/devel/partman-auto-recipe.txt)

## Background

At first glance through the Debian docs on preseeding, it's a little daunting. Upon closer inspection though, its pretty straight forward. Installation options take the following format:

```
d-i [key] [type?] [value]
```

Where `key` is a lot like a field id on an HTML form, it identifies the specific option (they are namespaced with [namespace]/[id] type format). The type helps the installer guess which data type you're using, typically `string` or `boolean`. The `value` is of course your chosen option.

Each item in the Debian install GUI is configurable with these options. While Debian provides a [single large example file](https://www.debian.org/releases/squeeze/example-preseed.txt), I chose to break them up by section into separate more digestible files in [./preseed.d](./preseed.d)

Once you have your config options all set, you need to be able to use it when booting. PXE boot (network boot) can use the file directly, but that might be tough to setup in some cases. There are a number of steps required to bake the `preseed.cfg` options into the ISO, but that's okay - we can script that.

## Installation

This requires a few specific packages to unpack and repack the ISO. A `Dockerfile` is provided as an example of how to get a Debian environment setup to do this.

1. Fork this repo so you can make your own changes, most of this is config. You'll probably want to change a few things
2. Create your own `vars.sh` based on `vars.example.sh`
3. Modify the config sections in preseed.d to your needs
4. Download a Debian ISO [from their website](https://www.debian.org/distrib/netinst#smallcd) (this was created with the amd64 variant, but might work on others)
5. Run `source ./vars.sh && ./build [path to your iso]`
6. A `preseed-` ISO will be created in the current directory
7. Use the ISO file however you see fit!

## Expanding Partitions

Partitions are set quite small by default. This should help many users get up and running easily while allowing maximum flexibility. Docker user? /var probably needs to be bigger. Lots of big projects? /home needs to be bigger, etc. 

They partitions are created using LVM, which is much easier to expand than it is to contract. It's pretty simple to expand them:

```bash
sudo lvextend -L 25G /dev/mapper/main-var
sudo resize2fs /dev/mapper/main-var
```


