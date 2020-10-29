
Apt & dpkg aliases for Ubuntu and Debian distros.
=================================================


***(in /home/bsgt/sys_bashrc/aliases/apt_aliases.sh)***
## Function Index


```bash
01 - ubupdate()
```

******
### ubupdate():


***about***: Ubdate & upgrade ubuntu via apt. Then run apt auto-remove


***group***: base


***example***: `ubupdate`


```bash
function ubupdate() {

    sudo apt update
    sudo apt upgrade -y
    sudo apt auto-remove
}

```
#### Function Calls:


```bash
No functions called.
```



## Aliases


| **Alias Name** | **Code** | **Descripion** |
| :------------- |:-------------:| -----:|
| **apts** | `apt-cache search` | 
| **aptshow** | `apt-cache show` | 
| **aptinst** | `sudo apt-get install -V` | 
| **aptupd** | `sudo apt-get update` | 
| **aptupg** | `sudo apt-get dist-upgrade -V && sudo apt-get autoremove` | 
| **aptupgd** | `sudo apt-get update && sudo apt-get dist-upgrade -V && sudo apt-get autoremove` | 
| **aptrm** | `sudo apt-get remove` | 
| **aptpurge** | `sudo apt-get remove --purge` | 
| **chkup** | `/usr/lib/update-notifier/apt-check -p --human-readable` | 
| **chkboot** | `cat /var/run/reboot-required` | 
| **pkgfiles** | `dpkg --listfiles` | 
