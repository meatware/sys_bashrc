
Undefined. Add composure cite-about to shell script file
========================================================


***(in /home/bsgt/sys_bashrc/bashrc_assets/internal_helper_functions.sh)***
## Function Index


```bash
01 - check_new_bashrc_vers()
02 - gedit(){
03 - nomacs(){
04 - Ngedit(){
05 - terminator(){
06 - sshub(){
07 - sshec2(){
08 - sshbast(){
```

******
### check_new_bashrc_vers():


```bash
function check_new_bashrc_vers() {
    git --git-dir=${HOME}/sys_bashrc/.git fetch --quiet
    BASHRC_CURR_BRANCH=$(git --git-dir=${HOME}/sys_bashrc/.git rev-parse --abbrev-ref HEAD)
    BASHRC_COMMIT_DETAILS=$(git --git-dir=${HOME}/sys_bashrc/.git rev-list --left-right \
                            --count origin/master..."${BASHRC_CURR_BRANCH}")
    BC_BEHIND=$(echo "$BASHRC_COMMIT_DETAILS" | awk '{print $1}' | sed 's/^[ \t]*//;s/[ \t]*$//')
    BC_AHEAD=$(echo "$BASHRC_COMMIT_DETAILS" | awk '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')

    echo -e "\n${PureCHATREU}Your bashrc is ${PureBRed}${BC_BEHIND} ${PureCHATREU}commits behind origin/master and ${PureBBlue}${BC_AHEAD} ${PureCHATREU}commits ahead\n${NOCOL}"
}

```
#### Function Calls:


```bash
No functions called.
```




******
### gedit(){:


```bash
function gedit(){ command gedit "$@" &>/dev/null & }

```
#### Function Calls:


```bash
No functions called.
```




******
### nomacs(){:


```bash
function nomacs(){ command nomacs "$@" &>/dev/null & }

```
#### Function Calls:


```bash
No functions called.
```




******
### Ngedit(){:


```bash
function Ngedit(){ command gedit --new-window "$@" &>/dev/null & }

```
#### Function Calls:


```bash
└─ Ngedit(){
   └─ gedit(){
```




******
### terminator(){:


```bash
function terminator(){ command terminator --geometry=945x1200+0+0 "$@" &>/dev/null & }

```
#### Function Calls:


```bash
No functions called.
```




******
### sshub(){:


```bash
function sshub(){
    HOST_ADDR="$1"
    ssh -A ubuntu@${HOST_ADDR}
}

```
#### Function Calls:


```bash
No functions called.
```




******
### sshec2(){:


```bash
function sshec2(){
    HOST_ADDR="$1"
    ssh -A ec2-user@${HOST_ADDR}
}

```
#### Function Calls:


```bash
No functions called.
```




******
### sshbast(){:


```bash
function sshbast(){
    HOST_ADDR="$1"
    ssh -A -J username@bastion.com ubuntu@${HOST_ADDR}
}

grepo() {
    find ./ -not -path "*/\.*" -not -path "*venv/*" -not -path "*node_modules/*" -name "*" -exec grep --color=auto -Isi "$1" {}  \;
}

grepoall() {
    TXT_PATTERN="$1"
    if [[ $# -eq 2 ]]; then
        FILE_SEARCH="$2"
    else
        FILE_SEARCH="*"
    fi

    find ./ -not -path "*/\.*" -not -path "*venv/*" -not -path "*node_modules/*" -iname "${FILE_SEARCH}" -exec grep --color=auto -Isin "$TXT_PATTERN" {} /dev/null \;
}

del_file_by_ext() {
    file_ext="$1"
    find . -name "$file_ext" -exec rm -fv {} \;
}

venv_create() {
    if [[ $# -ge 1 ]]; then
        desired_py_version=$1
        pyth_ver=$(which $desired_py_version)
        if [[ -z "${pyth_ver}" ]]; then
            echo "python version $desired_py_version not found"
        else
            $pyth_ver -m venv venv
            source venv/bin/activate
        fi
    else
        echo "supply an arg"
    fi
}

venv_activate() {
    source venv/bin/activate
}

```
#### Function Calls:


```bash
No functions called.
```


