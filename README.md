# sys bashrc

## Premise
Slimmed down sysadmin .bashrc that should hopefully have minimal system dependencies.

## Extended Documentation
https://meatware.github.io/sys_bashrc/


## Installation - Git Clone
```
cd
git clone https://github.com/meatware/sys_bashrc.git
mv .bashrc .your_old_bashrc
ln -fs ~/sys_bashrc/_bashrc ~/.bashrc
source ~/.bashrc
```

## Installation - wget & unzip
```sh
cd
mv .bashrc .your_old_bashrc
#
RELEASE_VERSION=1.0.0
wget https://github.com/meatware/sys_bashrc/archive/refs/tags/v${RELEASE_VERSION}.zip -O sys_bashrc.zip
unzip sys_bashrc.zip
mv sys_bashrc-${RELEASE_VERSION} sys_bashrc
ln -fs ~/sys_bashrc/_bashrc ~/.bashrc
source ~/.bashrc
```