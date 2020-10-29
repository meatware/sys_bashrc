
Undefined. Add composure cite-about to shell script file
========================================================


***(in /home/bsgt/sys_bashrc/bashrc_assets/internal_colour_functions.sh)***
## Function Index


```bash
01 - _check_integer()
02 - _check_theme_range()
03 - colsw(){
04 - colsw_path(){
05 - col_set_prompt_style()
06 - csp1()
07 - csp2()
08 - csp3()
09 - col_cp_root(){
10 - col_ssh(){
11 - virtualenv_min_info(){
12 - virtualenv_info(){
13 - ssh_info(){
14 - aws_info(){
```

******
### _check_integer():


```bash
function _check_integer() {
    local MYINT="$1"
    local REX=^[0-9]*$
    if [[ "$MYINT" =~ $REX ]]; then
        echo "$MYINT"
    else
        echo 0
    fi
}

```
#### Function Calls:


```bash
No functions called.
```




******
### _check_theme_range():


```bash
function _check_theme_range() {
    local MYINT="$1"
    local MAX_LEN="$2"
    if [ "$MYINT" -ge 0 -a "$MYINT" -lt "$MAX_LEN" ]; then
        echo "$MYINT"
    else
        echo 0
    fi
}

```
#### Function Calls:


```bash
No functions called.
```




******
### colsw(){:


```bash
function colsw(){

    local NEWCOL_IDX=${1}

    local NEWCOL_IDX=$(_check_integer "${NEWCOL_IDX}")

    local NEWCOL_IDX=$(_check_theme_range "${NEWCOL_IDX}" "$BARCOL_ARR_LEN")

    cp ${HOME}/sys_bashrc/theme_settings.sh ${HOME}/sys_bashrc/theme_settings_BACKUP.sh
    local CURRCOL_IDX=$(grep "SET_THEME_VAR=" ${HOME}/sys_bashrc/theme_settings.sh | grep -v sed | tr '=' ' ' | awk '{print $2}')

    local CURRPATH_IDX=$(grep "SET_PATHCOL_VAR=" ${HOME}/sys_bashrc/theme_settings.sh | grep -v sed | tr '=' ' ' | awk '{print $2}' | sed 's/\"//g')


    SET_THEME_VAR="${SET_THEME_VAR:=0}"
    SET_BARCOL="${SET_BARCOL:=\[\033[38;5;202m\]}"
    SET_TXTCOL="${SET_TXTCOL:=\[\033[38;5;221m\]}"
    SET_PATHCOL_VAR="${SET_PATHCOL_VAR:=1}"
    SET_PATHCOL="${SET_PATHCOL:=\[\033[0;37m\]}"
cat << BACON > ${HOME}/sys_bashrc/theme_settings.sh




SET_THEME_VAR="${NEWCOL_IDX}"
SET_BARCOL="${BARCOL_ARR[${NEWCOL_IDX}]}"
SET_TXTCOL="${TXTCOL_ARR[${NEWCOL_IDX}]}"
SET_PATHCOL_VAR="${CURRPATH_IDX}"
SET_PATHCOL="${PATH_COLS_ARR[${CURRPATH_IDX}]}"

BACON

    PRINTCOLVAR="ON"
    if [ $PRINTCOLVAR = "ON" ]; then
        PATHCOL_NAME=${PATH_COLS_ARR[${CURRPATH_IDX}]}
        BARCOL_NAME=${BARCOL_ARR[${THEME_VAR}]}
        TXTCOL_NAME=${TXTCOL_ARR[${THEME_VAR}]}
        echo "BARCOL = ${BARCOL_NAME}"
        echo "TXTCOL = ${TXTCOL_NAME}"
        echo "PATHCOL = ${PATHCOL_NAME}"
    fi

    source ${HOME}/sys_bashrc/_bashrc
}

```
#### Function Calls:


```bash
No functions called.
```




******
### colsw_path(){:


```bash
function colsw_path(){

    local NEWPATH_IDX=${1}

    NEWPATH_IDX=$(_check_integer "${NEWPATH_IDX}")

    NEWPATH_IDX=$(_check_theme_range "${NEWPATH_IDX}" "$PATHCOLS_ARR_LEN")

    cp ${HOME}/sys_bashrc/theme_settings.sh ${HOME}/sys_bashrc/theme_settings_BACKUP.sh

    local NEWPATH_COL="${PATH_COLS_ARR[${NEWPATH_IDX}]}"

    sed -i "/^SET_PATHCOL/d" ${HOME}/sys_bashrc/theme_settings.sh

cat << CHEESE >> ${HOME}/sys_bashrc/theme_settings.sh
SET_PATHCOL_VAR="${NEWPATH_IDX}"
SET_PATHCOL="${NEWPATH_COL}"
CHEESE
    echo "No of Themes: $BARCOL_ARR_LEN"
    source ${HOME}/sys_bashrc/_bashrc
}

```
#### Function Calls:


```bash
No functions called.
```




******
### col_set_prompt_style():


```bash
function col_set_prompt_style() {
    local CHOICE="$1"
    if [[ "$CHOICE" =~ (full|mid) ]]; then
        export SET_FULL_PROMPT=$CHOICE
        source ~/.bashrc
    else
        echo "enter 'full' or 'mid'"
    fi
}

```
#### Function Calls:


```bash
No functions called.
```




******
### csp1():


```bash
function csp1() {
    col_set_prompt_style full
}

```
#### Function Calls:


```bash
No functions called.
```




******
### csp2():


```bash
function csp2() {
    col_set_prompt_style mid
}

```
#### Function Calls:


```bash
No functions called.
```




******
### csp3():


```bash
function csp3() {
    unset SET_FULL_PROMPT
    export SET_FULL_PROMPT=
    source ~/.bashrc
}

```
#### Function Calls:


```bash
No functions called.
```




******
### col_cp_root(){:


```bash
function col_cp_root(){
    sudo mv /root/.bashrc /root/.your_old_bashrc
    sudo cp -rf ${HOME}/sys_bashrc /root/
    sudo ln -s /root/sys_bashrc/_bashrc /root/.bashrc
    sudo su root
    source /root/.bashrc
}

```
#### Function Calls:


```bash
No functions called.
```




******
### col_ssh(){:


```bash
function col_ssh(){
    rsync -av ${HOME}/sys_bashrc ${1}:~/
    ssh -A "${1}" 'mv ~/.bashrc ~/.your_old_bashrc; ln -s ${HOME}/sys_bashrc/_bashrc ~/.bashrc'
}

```
#### Function Calls:


```bash
No functions called.
```




******
### virtualenv_min_info(){:


```bash
function virtualenv_min_info(){
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local venv="${VIRTUAL_ENV##*/}"
    else
        local venv=""
    fi
    [[ -n "$venv" ]] && echo "$venv"
}

```
#### Function Calls:


```bash
No functions called.
```




******
### virtualenv_info(){:


```bash
function virtualenv_info(){
    local venv=$(virtualenv_min_info)
    [[ -n "$venv" ]] && echo "${BARCOL}─${TXTCOL}[${HIRed}$venv${TXTCOL}]"
}

```
#### Function Calls:


```bash
No functions called.
```




******
### ssh_info(){:


```bash
function ssh_info(){
    ssh_state=""
    [[ -n "$ssh_state" ]] && echo "${BARCOL}─${TXTCOL}[${HIRed}${ssh_state}${TXTCOL}]"
}

```
#### Function Calls:


```bash
No functions called.
```




******
### aws_info(){:


```bash
function aws_info(){
    aws_profile="$(printenv AWS_PROFILE)"
    if [[ -n "${aws_profile}" ]]; then
        set_aws_profile=${aws_profile}
    else
        set_aws_profile=""
    fi
    [[ -n "$set_aws_profile" ]] && echo "${BARCOL}─${TXTCOL}[${HIRed}${set_aws_profile}${TXTCOL}]"
}

pwdtail () {
    pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}' #TODO: Use for something?
}

```
#### Function Calls:


```bash
No functions called.
```


