cite 'about-internal'
about-internal 'Internal bash helper functions'

function check_new_bashrc_vers() {
    about 'checks whether sys_bashrc is up-to-date'
    group 'internal'
    example 'check_new_bashrc_vers'

    git --git-dir=${HOME}/sys_bashrc/.git fetch --quiet
    # check relation of our local .bashrc to remote basshrc at https://github.com/meatware/sys_bashrc
    BASHRC_CURR_BRANCH=$(git --git-dir=${HOME}/sys_bashrc/.git rev-parse --abbrev-ref HEAD)
    BASHRC_COMMIT_DETAILS=$(git --git-dir=${HOME}/sys_bashrc/.git rev-list --left-right \
                            --count origin/master..."${BASHRC_CURR_BRANCH}")
    BC_BEHIND=$(echo "$BASHRC_COMMIT_DETAILS" | awk '{print $1}' | sed 's/^[ \t]*//;s/[ \t]*$//')
    BC_AHEAD=$(echo "$BASHRC_COMMIT_DETAILS" | awk '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')

    echo -e "\n${PureCHATREU}Your bashrc is ${PureBRed}${BC_BEHIND} ${PureCHATREU}commits behind origin/master and ${PureBBlue}${BC_AHEAD} ${PureCHATREU}commits ahead\n${NOCOL}"
}

function gedit() {
    about 'Opens non-blocking program from terminal'
    group 'base'
    example 'gedit $filename'

    command gedit "$@" &>/dev/null &
}

function nomacs() {
    about 'Opens non-blocking program from terminal'
    group 'base'
    example 'nomacs $filename'

    command nomacs "$@" &>/dev/null &
}

function Ngedit() {
    about 'Opens non-blocking program from terminal'
    group 'base'
    example 'Ngedit $filename'

    command gedit --new-window "$@" &>/dev/null &
}

function terminator() {
    about 'Opens non-blocking program from terminal'
    group 'base'
    example 'terminator $filename'

    command terminator --geometry=945x1200+0+0 "$@" &>/dev/null &
}

function sshub() {
    about 'Signs into AWS EC2 instance using pattern ubuntu@${address}'
    group 'base'
    param: 'Ip address or FQDN'
    example 'sshub 172.17.0.1'

    HOST_ADDR="$1"
    ssh -A ubuntu@${HOST_ADDR}
}

function sshec2() {
    about 'Signs into AWS EC2 instance using pattern ec2-user@${address}'
    group 'base'
    param: 'Ip address or FQDN'
    example 'sshec2 172.17.0.1'

    HOST_ADDR="$1"
    ssh -A ec2-user@${HOST_ADDR}
}

function sshbast() {
    about 'ssh via jump host. You need to have added your .pem key via ssh-add -k. Edit this function ($USERNAME) to have the machine you want to jump to'
    group 'base'
    param: 'Ip address or FQDN'
    example 'sshbast ${MachineYouWantToJumpTo}'
    example 'sshbast 185.22.33.68'

    HOST_ADDR="$1"
    ssh -A -J USERNAME@bastion.com ubuntu@${HOST_ADDR}
}

################################################
function grepo() {
    about 'Find all files "*" recursively from current directory and grep within each file for a pattern'
    group 'base'
    param: 'Pattern to grep for'
    example 'grepo $PATERN'
    example 'grepo import'
    # finds all files in current directory recursively and searches each for grep pattern
    # (case insensitive)
    find ./ -not -path "*/\.*" -not -path "*venv/*" -not -path "*node_modules/*" -name "*" -exec grep --color=auto -Isi "$1" {}  \;
}

function grepoall() {
    about 'Find all files "*" recursively from current directory and grep within each file for a pattern'
    group 'base'
    param: '1. Pattern to grep for'
    param: '2. File type to find in double quotes'
    example 'grepoall $PATERN'
    example 'grepoall import'
    example 'grepoall $PATERN $FILE_PATTERN'
    example 'grepoall import "*.py"'
    # finds all files in current directory recursively and searches each for grep pattern
    # Shows the file name in which the pattern was found (case insensitive + linenumber)
    # FILE_SEARCH eaxmple "*.py" with quotes or "*" if not supplied

    TXT_PATTERN="$1"
    if [[ $# -eq 2 ]]; then
        FILE_SEARCH="$2"
    else
        FILE_SEARCH="*"
    fi

    find ./ -not -path "*/\.*" -not -path "*venv/*" -not -path "*node_modules/*" -iname "${FILE_SEARCH}" -exec grep --color=auto -Isin "$TXT_PATTERN" {} /dev/null \;
}

function del_file_by_patt() {
    about 'Delete all files matching a pattern'
    group 'base'
    param: '1. Delete pattern'
    example 'del_file_by_patt $DEL_PATERN'
    example 'del_file_by_patt "*.css"'

    file_ext="$1"
    find . -name "$file_ext" -exec rm -fv {} \;
}

# TODO: figure out virtualenv for python2
# https://stackoverflow.com/questions/41573587/what-is-the-difference-between-venv-pyvenv-pyenv-virtualenv-virtualenvwrappe
function venv_create() {
    about 'Create & activte a python virtual environment. Works with Python3'
    group 'base'
    param: 'python version findable on path. Test with $(which)'
    example 'venv_create python3.6'

    if [[ $# -ge 1 ]]; then
        # takes argument like python3.6
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

function venv_activate() {
    about 'Activte an existing python virtual environment'
    group 'base'
    param: 'python version findable on path. Test with $(which)'
    example 'venv_activate'

    source venv/bin/activate
}