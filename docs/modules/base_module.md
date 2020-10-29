
Undefined. Add composure cite-about to shell script file
========================================================


***(in /home/bsgt/sys_bashrc/modules/base_module.sh)***
## Function Index


```bash
01 - del()
```

******
### del():


***about***: move files to hidden folder in tmp, that gets cleared on each reboot


***param***: file or folder to be deleted


***example***: `del ./file.txt`


***group***: base


```bash
function del() {

    mkdir -p /tmp/.trash && mv "$@" /tmp/.trash;
}

```
#### Function Calls:


```bash
No functions called.
```


