cite about-module
about-module 'Base module'


function ips() {
    about 'display all ip addresses for this host'
    group 'base'

    if command -v ifconfig &>/dev/null
    then
        ifconfig | awk '/inet /{ gsub(/addr:/, ""); print $2 }'
    elif command -v ip &>/dev/null
    then
        ip addr | grep -oP 'inet \K[\d.]+'
    else
        echo "You don't have ifconfig or ip command installed!"
    fi
}

function down4me() {
    about 'checks whether a website is down for you, or everybody'
    param '1: website url'
    example '$ down4me http://www.google.com'
    group 'base'

    curl -Ls "http://downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

function myip() {
    about 'displays your ip address, as seen by the Internet'
    group 'base'

    list=("http://myip.dnsomatic.com/" "http://checkip.dyndns.com/" "http://checkip.dyndns.org/")
    for url in ${list[*]}
    do
        res=$(curl -s "${url}")
        if [ $? -eq 0 ];then
            break;
        fi
    done
    res=$(echo "$res" | grep -Eo '[0-9\.]+')
    echo -e "Your public IP is: ${echo_bold_green} $res ${echo_normal}"
}

function pickfrom() {
    about 'picks random line from file'
    param '1: filename'
    example '$ pickfrom /usr/share/dict/words'
    group 'base'

    local file=$1
    [ -z "$file" ] && reference $FUNCNAME && return
    length=$(cat $file | wc -l)
    n=$(expr $RANDOM \* $length \/ 32768 + 1)
    head -n $n $file | tail -1
}

function passgen() {
    about 'generates random password from dictionary words'
    param 'optional integer length'
    param 'if unset, defaults to 4'
    example '$ passgen'
    example '$ passgen 6'
    group 'base'

    local i pass length=${1:-4}
    pass=$(echo $(for i in $(eval echo "{1..$length}"); do pickfrom /usr/share/dict/words; done))
    echo "With spaces (easier to memorize): $pass"
    echo "Without (use this as the password): $(echo $pass | tr -d ' ')"
}

function mkcd() {
    about 'make one or more directories and cd into the last one'
    param 'one or more directories to create'
    example '$ mkcd foo'
    example '$ mkcd /tmp/img/photos/large'
    example '$ mkcd foo foo1 foo2 fooN'
    example '$ mkcd /tmp/img/photos/large /tmp/img/photos/self /tmp/img/photos/Beijing'
    group 'base'

    mkdir -p -- "$@" && eval cd -- "\"\$$#\""
}

function lsgrep() {
    about 'search through directory contents with grep'
    group 'base'

    ls | grep "$*"
}

function usage() {
    about 'disk usage per directory, in Mac OS X and Linux'
    param '1: directory name'
    group 'base'

    if [ $(uname) = "Darwin" ]; then
        if [ -n "$1" ]; then
            du -hd 1 "$1"
        else
            du -hd 1
        fi

    elif [ $(uname) = "Linux" ]; then
        if [ -n "$1" ]; then
            du -h --max-depth=1 "$1"
        else
            du -h --max-depth=1
        fi
    fi
}

function comex() {
    about 'checks for existence of a command'
    param '1: command to check'
    example '$ comex ls'
    group 'base'

    type "$1"  #&> /dev/null ;
}


# useful for administrators and configs
function buf() {
    about 'back up file with timestamp'
    param 'filename'
    group 'base'

    local filename=$1
    local filetime=$(date +%Y%m%d_%H%M%S)
    cp -a "${filename}" "${filename}_${filetime}"
}

function del() {
    about 'move files to hidden folder in tmp, that gets cleared on each reboot'
    param 'file or folder to be deleted'
    example 'del ./file.txt'
    group 'base'

    mkdir -p /tmp/.trash && mv "$@" /tmp/.trash;
}

#--------------------------------------------------------------
#  Automatic setting of $DISPLAY (if not set already).
#  This works for me - your mileage may vary. . . .
#  The problem is that different types of terminals give
#+ different answers to 'who am i' (rxvt in particular can be
#+ troublesome) - however this code seems to work in a majority
#+ of cases.
#--------------------------------------------------------------

# function get_xserver ()
# {
#     case $TERM in
#         xterm )
#             XSERVER=$(whoami | awk '{print $NF}' | tr -d ')''(' )
#             # Ane-Pieter Wieringa suggests the following alternative:
#             #  I_AM=$(who am i)
#             #  SERVER=${I_AM#*(}
#             #  SERVER=${SERVER%*)}
#             XSERVER=${XSERVER%%:*}
#             ;;
#             aterm | rxvt)
#             # Find some code that works here. ...
#             ;;
#     esac
# }

# if [ -z ${DISPLAY:=""} ]; then
#     get_xserver
#     if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) ||
#        ${XSERVER} == "unix" ]]; then
#           DISPLAY=":0.0"          # Display on local host.
#     else
#        DISPLAY=${XSERVER}:0.0     # Display on remote host.
#     fi
# fi

# export DISPLAY