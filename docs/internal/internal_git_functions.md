
Undefined. Add composure cite-about to shell script file
========================================================


***(in /home/bsgt/sys_bashrc/bashrc_assets/internal_git_functions.sh)***
## Function Index


```bash
01 - parse_git()
02 - parse_git_minimal()
03 - find_git_branch()
04 - get_git_commid()
05 - find_git_dirty()
06 - git_com_diff()
07 - format_git_stats()
```

******
### parse_git():


```bash
function parse_git() {

    git_str=$(find_git_branch)
    if [[ ! -z "$git_str" ]]; then
        git_str="${BARCOL}──${TXTCOL}[$(git_com_diff)${git_str}$(find_git_dirty)"

        git_str="${git_str}$(format_git_stats)"

        git_str="${git_str}${TXTCOL}]"


        echo $git_str
    else
        echo ""
    fi
}

```
#### Function Calls:


```bash
No functions called.
```




******
### parse_git_minimal():


```bash
function parse_git_minimal() {

    git_str=$(find_git_branch)
    if [[ ! -z "$git_str" ]]; then
        git_str="${BARCOL}─${TXTCOL}(${git_str}$(find_git_dirty)"

        git_str="${git_str}${TXTCOL})"


        echo $git_str
    else
        echo ""
    fi
}

```
#### Function Calls:


```bash
No functions called.
```




******
### find_git_branch():


```bash
function find_git_branch() {
    local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ ! -z "$branch" ]]; then
        if [[ "$branch" == "HEAD" ]]; then
            branch_fmt="${RED}!detached"
        else
            branch_fmt="${TXTCOL}${branch}"
        fi
        git_branch="${branch_fmt}"
    else
        git_branch=""
    fi
    echo $git_branch
}

```
#### Function Calls:


```bash
No functions called.
```




******
### get_git_commid():


```bash
function get_git_commid() {
    curr_commitid=$(git rev-parse --short HEAD 2> /dev/null)
    prev_commitid=$(git rev-list --max-count=2 --abbrev-commit HEAD  | tail -1)
    echo "${BARCOL}──${TXTCOL}[c~${curr_commitid}]${BARCOL}──${TXTCOL}[p~${prev_commitid}]"
}

```
#### Function Calls:


```bash
No functions called.
```




******
### find_git_dirty():


```bash
function find_git_dirty() {
    gdirtstr=$(git status 2> /dev/null | tail -n1 | sed 's/,//' | awk '{print $1, $2, $3}')
    if [[ ${gdirtstr} == "nothing to commit" ]]
        then
        dirty_state=""
    elif [[ ${gdirtstr} == "" ]]
        then
        dirty_state=""
    else
        dirty_state='\[\033[01;38;5;221m\]*'
    fi
    echo $dirty_state
}

```
#### Function Calls:


```bash
No functions called.
```




******
### git_com_diff():


```bash
function git_com_diff() {
    gbranchrel=$(git status 2> /dev/null | grep "Your branch is")
    gup=$(echo $gbranchrel 2> /dev/null | grep ahead)
    gdown=$(echo $gbranchrel 2> /dev/null | grep behind)
    grelN=$(echo $gbranchrel | sed -nr 's/.*by ([0-9]+) commit?[a-z]./\1/p')

    gupdown=""
    if [[ $gup != "" ]]; then
        gupdown="${grelN}↑"
    fi

    if [[ $gdown != "" ]]; then
        gupdown="${grelN}↓"
    fi
    echo $gupdown
}

```
#### Function Calls:


```bash
No functions called.
```




******
### format_git_stats():


```bash
function format_git_stats() {
    gporcelain=$(git status --porcelain 2> /dev/null)
    untrN=$(echo $gporcelain | tr ' ' '\n' | grep -w '??' | wc -l) # untracked
    addN=$(echo $gporcelain | tr ' ' '\n' | grep -w '^A' | wc -l)  # added
    modN=$(echo $gporcelain | tr ' ' '\n' | grep -w '^M' | wc -l)  # modified
    commN=$(echo $gporcelain | tr ' ' '\n' | grep -w '^AM' | wc -l)  # added & modified?
    delN=$(echo $gporcelain | tr ' ' '\n' | grep -w '^D' | wc -l)  # deleted


    gitlegend=""
    gitstats_str=""
    if [[ $untrN != "0" ]]; then
        gitlegend="${gitlegend}${TEAL}u"
        gitstats_str="${gitstats_str}${TEAL}${untrN}"
    fi

    if [[ $addN != "0" ]]; then
        gitlegend="${gitlegend}${LBLUE}a"
        gitstats_str="${gitstats_str}${LBLUE}${addN}"
    fi

    if [[ $modN != "0" ]]; then
        gitlegend="${gitlegend}${MAGENTA}m"
        gitstats_str="${gitstats_str}${MAGENTA}${modN}"
    fi

    if [[ $commN != "0" ]]; then
        gitlegend="${gitlegend}${HIGreen}c"
        gitstats_str="${gitstats_str}${HIGreen}${commN}"
    fi

    if [[ $delN != "0" ]]; then
        gitlegend="${gitlegend}${RED}d"
        gitstats_str="${gitstats_str}${RED}${delN}"
    fi

    gitlegend="${gitlegend}${SLATE}: "


    if [[ $gitstats_str == "" ]]; then
        joined_gitstats=""
    else
        joined_gitstats=" ${gitlegend}${gitstats_str}"
    fi
    echo "${gupdown}${TXTCOL}${gbranchstr}${dirty_state}${joined_gitstats}"
}

```
#### Function Calls:


```bash
No functions called.
```


