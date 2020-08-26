# sys bashrc

## Premise
Slimmed down sysadmin .bashrc that should hopefully have minimal system dependencies.


## Installation

### Clone repo, activate via symlink and backup your pre-existing .bashrc
```
cd
git clone https://github.com/meatware/sys_bashrc.git
mv .bashrc .your_old_bashrc
ln -fs ~/sys_bashrc/_bashrc ~/.bashrc
source ~/.bashrc
```