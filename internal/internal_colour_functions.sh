cite about-internal
about-internal 'Internal theme related functions'

function _check_integer() {
    about 'Check if argument is an integer'
    group 'internal'
    param: 'A putative integer'
    example '_check_integer 42'

    local MYINT="$1"
    ### If not an integer - default to theme val 0
    local REX=^[0-9]*$
    if [[ "$MYINT" =~ $REX ]]; then
        #true # pass TODO: figure out annoying regex not
        echo "$MYINT"
    else
        #echo -e "$MYINT is not a valid no for THEME_VAR\nSetting to default theme"
        #echo "Setting to default theme"
        echo 0
    fi
}

function _check_theme_range() {
    about 'Check if argument is an integer between 0 --> N'
    group 'internal'
    param: '1. A test integer'
    param: '2. Ma=x number in range'
    example '_check_theme_range 56 1003'

    local MYINT="$1"
    local MAX_LEN="$2"
    ### If not an integer - default to theme val 0
    ### check if integer is between 0 and number of max theme array index (in _bash_colour_defs.sh)
    if [ "$MYINT" -ge 0 -a "$MYINT" -lt "$MAX_LEN" ]; then
        echo "$MYINT"
    else
        #echo " $MYINT is not a valid index no for THEME_VAR"
        echo 0
    fi
}

function colsw() {
    about 'Switch PS1 prompt theme color scheme usining a integer, N. There is a upper limit to N'
    group 'internal'
    param: '1. A integer corresponding to a theme color scheme. See internal_colour_defs.sh'
    example 'colsw 42'

    ## switches theme color set by $THEME_VAR vals

    local NEWCOL_IDX=${1}

    ### If not an integer - default to theme val 0
    local NEWCOL_IDX=$(_check_integer "${NEWCOL_IDX}")

    ### check if integer is between 0 and number of max theme array index (in _bash_colour_defs.sh)
    local NEWCOL_IDX=$(_check_theme_range "${NEWCOL_IDX}" "$BARCOL_ARR_LEN")

    ### create failsafe-backup first
    cp ${HOME}/sys_bashrc/theme_settings.sh ${HOME}/sys_bashrc/theme_settings_BACKUP.sh
    #local CURR_FULL_PROMPT=$(grep "SET_FULL_PROMPT=" ${HOME}/sys_bashrc/theme_settings.sh | grep -v sed | tr '=' ' ' | awk '{print $2}')
    local CURRCOL_IDX=$(grep "SET_THEME_VAR=" ${HOME}/sys_bashrc/theme_settings.sh | grep -v sed | tr '=' ' ' | awk '{print $2}')

    # This just replaced the existing one with the same one
    # change SET_PATH_COL in another function
    local CURRPATH_IDX=$(grep "SET_PATHCOL_VAR=" ${HOME}/sys_bashrc/theme_settings.sh | grep -v sed | tr '=' ' ' | awk '{print $2}' | sed 's/\"//g')

    ## Set default variables
    # If parameter is unset or null, the expansion of word is substituted.
    # Otherwise, the value of parameter is substituted.
    # ${parameter:=word}

    #CURR_FULL_PROMPT="${CURR_FULL_PROMPT:=\"no\"}"
    SET_THEME_VAR="${SET_THEME_VAR:=0}"
    SET_BARCOL="${SET_BARCOL:=\[\033[38;5;202m\]}"
    SET_TXTCOL="${SET_TXTCOL:=\[\033[38;5;221m\]}"
    SET_PATHCOL_VAR="${SET_PATHCOL_VAR:=1}"
    SET_PATHCOL="${SET_PATHCOL:=\[\033[0;37m\]}"
    ##################################################
cat << BACON > ${HOME}/sys_bashrc/theme_settings.sh
#!/bin/bash

# Do not edit this file directly. It is set by the function col_sw()

# default $SET_FULL_PROMPT is commented (basic prompt)
# Uncomenting & setting the value to full or mid acticates 3 or 2 line prompts.
# This allows temporary session-only use of this env-var.
# So in a shared environment with other opinionated users, you can have the
# default non-offensive 1 line prompt ($SET_FULL_PROMPT is commented) showing
# for everyone.
# When you create a new shell session, you can run:
#
# export SET_FULL_PROMPT="full"
# source ~/.bashrc
#
# or:
# col_set_prompt_style "full|mid"
# type alias: csp1 = full
# type alias: csp2 = mid
# type alias: csp3 = mid
#
# The 3 line prompt becomes active for your session only and other users will not have
# to deal with your asthethic design decisions.
# You can still use colsw $INTEGER to change theme settings. thes ewill not be seen till
# $SET_FULL_PROMPT is set to ""full" or "mid"

# SET_FULL_PROMPT="full"

# Theme vars below are unused when SET_FULL_PROMPT is commented
SET_THEME_VAR="${NEWCOL_IDX}"
SET_BARCOL="${BARCOL_ARR[${NEWCOL_IDX}]}"
SET_TXTCOL="${TXTCOL_ARR[${NEWCOL_IDX}]}"
SET_PATHCOL_VAR="${CURRPATH_IDX}"
SET_PATHCOL="${PATH_COLS_ARR[${CURRPATH_IDX}]}"

BACON
    ###################################################

    ### Debugging switch for when using theme_generator.py
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

function colsw_path() {
    about 'Fine Tune PS1 prompt theme $PATH_COL_VAR val color scheme usinng a integer, N. There is a upper limit to N'
    group 'internal'
    param: '1. A integer corresponding to a theme color scheme. See internal_colour_defs.sh'
    example 'colscolsw_path 2'

    local NEWPATH_IDX=${1}

    ### If not an integer - default to theme val 0
    NEWPATH_IDX=$(_check_integer "${NEWPATH_IDX}")

    ### check if integer is between 0 and number of max theme array index (in _bash_colour_defs.sh)
    NEWPATH_IDX=$(_check_theme_range "${NEWPATH_IDX}" "$PATHCOLS_ARR_LEN")

    ### create failsafebackup first
    cp ${HOME}/sys_bashrc/theme_settings.sh ${HOME}/sys_bashrc/theme_settings_BACKUP.sh

    local NEWPATH_COL="${PATH_COLS_ARR[${NEWPATH_IDX}]}"

    sed -i "/^SET_PATHCOL/d" ${HOME}/sys_bashrc/theme_settings.sh

    ##################################################
cat << CHEESE >> ${HOME}/sys_bashrc/theme_settings.sh
SET_PATHCOL_VAR="${NEWPATH_IDX}"
SET_PATHCOL="${NEWPATH_COL}"
CHEESE
    ###################################################
    echo "No of Themes: $BARCOL_ARR_LEN"
    source ${HOME}/sys_bashrc/_bashrc
}

function col_set_prompt_style() {
    about 'Change prompt style between full (3-line), mid (2-line) & default (1-line primitive)'
    group 'internal'
    param '1. A integer from 1-3'
    example 'col_set_prompt_style 1'
    local CHOICE="$1"
    if [[ "$CHOICE" =~ (full|mid) ]]; then
        #sed -i "s/SET_FULL_PROMPT=\".*\"/SET_FULL_PROMPT=\"${CHOICE}\"/" ${HOME}/sys_bashrc/theme_settings.sh
        export SET_FULL_PROMPT=$CHOICE
        source ~/.bashrc
    else
        echo "enter 'full' or 'mid'"
    fi
}

function csp1() {
    about 'Change prompt style to full 3-line glory'
    group 'internal'
    example 'csp1'
    col_set_prompt_style full
}

function csp2() {
    about 'Change prompt style to experimental 2-line worrying'
    group 'internal'
    example 'csp2'
    col_set_prompt_style mid
}

function csp3() {
    about 'Change prompt style to a basic 1-line primitive level (default)'
    group 'internal'
    example 'csp1'
    unset SET_FULL_PROMPT
    export SET_FULL_PROMPT=
    source ~/.bashrc
}

function col_cp_root() {
    about 'Copies .bashrc to root home on current machine. Only affects things if full color prompt is set'
    group 'internal'
    example 'col_cp_root'
    ## copies .bashrc to root home
    sudo mv /root/.bashrc /root/.your_old_bashrc
    sudo cp -rf ${HOME}/sys_bashrc /root/
    sudo ln -s /root/sys_bashrc/_bashrc /root/.bashrc
    sudo su root
    source /root/.bashrc
}

function col_ssh() {
    about 'Copy sys_bashrc PS1 prompt to remote host via rsync'
    group 'internal'
    param: '${USERNAME}@${HOSTNAME}'
    example 'col_ssh ubuntu@mywebserver.com'
    ## copies .bashrc to remote host specified by $1 commandline arg user@remotehost
    rsync -av ${HOME}/sys_bashrc ${1}:~/
    ssh -A "${1}" 'mv ~/.bashrc ~/.your_old_bashrc; ln -s ${HOME}/sys_bashrc/_bashrc ~/.bashrc'
}

function _virtualenv_info() {
    about 'Get Virtual Env and display in PS prompt (full version)'
    group 'internal'
    example '_virtualenv_min_info'

    local venv=$(_virtualenv_min_info)
    [[ -n "$venv" ]] && echo "${BARCOL}─${TXTCOL}[${HIRed}$venv${TXTCOL}]"
}

function _virtualenv_min_info() {
    about 'Get Virtual Env and display in PS prompt (minimal version)'
    group 'internal'
    example '_virtualenv_min_info'

    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        local venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        local venv=""
    fi
    [[ -n "$venv" ]] && echo "$venv"
}

function _ssh_info() {
    about 'Display ssh in PS prompt if current seesion is via ssh'
    group 'internal'
    example '_ssh_info'
    # Get ssh-sess info and display in prompt
    # if pstree -p | egrep --quiet --extended-regexp ".*sshd.*\($$\)"; then
    #     ssh_state="ssh"
    # else
    #     ssh_state=""
    # fi
    ssh_state=""
    [[ -n "$ssh_state" ]] && echo "${BARCOL}─${TXTCOL}[${HIRed}${ssh_state}${TXTCOL}]"
}

function _aws_info() {
    about 'Display the current AWS profile loaded in PS prompt'
    group 'internal'
    example '_aws_info'
    # Get aws profile info and display in prompt
    aws_profile="$(printenv AWS_PROFILE)"
    if [[ -n "${aws_profile}" ]]; then
        set_aws_profile=${aws_profile}
    else
        set_aws_profile=""
    fi
    [[ -n "$set_aws_profile" ]] && echo "${BARCOL}─${TXTCOL}[${HIRed}${set_aws_profile}${TXTCOL}]"
}

##################################
### returns the last 2 fields of the working directory
## for display in terminal titlebar
function _pwdtail() {
    about 'Display last two directories from `pwd` in PS prompt'
    group 'internal'
    example '_pwdtail'

    pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}' #TODO: Use for something?
}
