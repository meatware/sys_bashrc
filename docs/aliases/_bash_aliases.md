
Undefined. Add composure cite-about to shell script file
========================================================


***(in /home/bsgt/sys_bashrc/aliases/_bash_aliases.sh)***
## Function Index


```bash
01 - check_alias_clashes()
02 - mkcd()
03 - up
```

******
### check_alias_clashes():


***about***: Check alias clashes


***group***: aliases


***example***: `$ check_alias_clashes`


```bash
function check_alias_clashes() {

	alias | sed 's/^[^ ]* *\|=.*$//g' | while read a; do
	printf "%20.20s : %s\n" $a "$(type -ta $a | tr '\n' ' ')"
	done | awk -F: '$2 ~ /file/'
}

```
#### Function Calls:


```bash
└─ Ngedit(){
   └─ gedit(){
└─ awskeys
   ├─ __awskeys_region
   ├─ __awskeys_list
   ├─ __awskeys_show
   |  └─ __awskeys_get
   ├─ __awskeys_export
   |  └─ __awskeys_get
   └─ __awskeys_unset
└─ __awskeys_help
   └─ awskeys
      ├─ __awskeys_region
      ├─ __awskeys_list
      ├─ __awskeys_show
      ├─ __awskeys_export
      └─ __awskeys_unset
└─ __awskeys_show
   └─ __awskeys_get
└─ __awskeys_export
   └─ __awskeys_get
└─ __awskeys_comp
   └─ __awskeys_list
└─ check_alias_clashes()
   └─ up
```




******
### mkcd():


***about***: Make a folder and go into it


***group***: aliases


***param***: 1: Name of the directory to create & enter


***example***: `mkcd my_new_dir`


```bash
function mkcd() {

    mkdir -p $1; cd $1
}

```
#### Function Calls:


```bash
└─ Ngedit(){
   └─ gedit(){
└─ awskeys
   ├─ __awskeys_region
   ├─ __awskeys_list
   ├─ __awskeys_show
   |  └─ __awskeys_get
   ├─ __awskeys_export
   |  └─ __awskeys_get
   └─ __awskeys_unset
└─ __awskeys_help
   └─ awskeys
      ├─ __awskeys_region
      ├─ __awskeys_list
      ├─ __awskeys_show
      ├─ __awskeys_export
      └─ __awskeys_unset
└─ __awskeys_show
   └─ __awskeys_get
└─ __awskeys_export
   └─ __awskeys_get
└─ __awskeys_comp
   └─ __awskeys_list
└─ check_alias_clashes()
   └─ up
└─ mkcd()
   └─ up
```




******
### up:


***about***: Go up N directories in the file path


***group***: aliases


***param***: 1: Integer corresponding to number of directories to go up.


***example***: `$ up 3`


```bash
function up () {

	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

```
#### Function Calls:


```bash
No functions called.
```



## Aliases


| **Alias Name** | **Code** | **Descripion** |
| :------------- |:-------------:| -----:|
| **mkdir** | `mkdir -p` | 
| **ls** | `ls -ah --colo` | 
| **qs** | `/bin/ls'` |  fast ls with no options (many files in a directory)
| **la** | `ls -Alh'` |  show hidden files
| **lao** | `ls -ld .?*'` |  show ONLY hidden files
| **lx** | `ls -lXBh'` |  sort by extension
| **lk** | `ls -lSrh'` |  sort by size
| **lc** | `ls -lcrh'` |  sort by change time
| **lu** | `ls -lurh'` |  sort by access time
| **lr** | `ls -lRh'` |  recursive ls
| **lt** | `ls -ltrh'` |  sort by date
| **lm** | `ls -alh | less'` |  pipe through 'less'
| **lw** | `ls -xAh'` |  wide listing format
| **ll** | `ls -lth'` |  long listing format
| **labc** | `ls -lap'` | alphabetical sort
| **lf** | `ls -l | egrep -v '^d'"` |  files only
| **ldir** | `ls -l | egrep '^d'"` |  directories only
| **cd..** | `cd ..` | 
| **..** | `cd ..` | 
| **...** | `cd ../..` | 
| **....** | `cd ../../..` | 
| **.....** | `cd ../../../..` | 
| **bashrc** | `cd ${HOME}/sys_bashrc; ll'` |  Switch to sys_bashrc directory in home and ls
| **grep** | `grep --colo` | 
| **egrep** | `egrep --colo` | 
| **fgrep** | `fgrep --colo` | 
| **quick-ssh** | `ssh -Y -C -c blowfish-cbc,arcfour username@yourhost.com'` |  Use faster ssh ciphers
| **edbash** | `gedit ~/.bashrc ~/sys_bashrc/bashrc_assets/*.sh &` | 
| **F5** | `source ~/.bashrc` | 
| **df** | `df -x "squashfs"'` |  Stop showing mounted snap in file system
| **dfraw** | `df"'` |  raw df with all options disabled
