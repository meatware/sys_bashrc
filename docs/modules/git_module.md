
git helper functions
====================


***(in /home/bsgt/sys_bashrc/modules/git_module.sh)***
## Function Index


```bash
01 - git_remote
02 - git_first_push
03 - git_pub()
04 - git_revert()
05 - git_rollback()
06 - git_remove_missing_files()
07 - local-ignore()
08 - git_info()
09 - git_stats
10 - gittowork()
11 - gitignore-reload()
12 - git_greedy_get()
```

******
### git_remote:


***about***: adds remote $GIT_HOSTING:$1 to current repo


***group***: git


```bash
function git_remote {

  echo "Running: git remote add origin ${GIT_HOSTING}:$1.git"
  git remote add origin $GIT_HOSTING:$1.git
}

```
#### Function Calls:


```bash
No functions called.
```




******
### git_first_push:


***about***: push into origin refs/heads/master


***group***: git


```bash
function git_first_push {

  echo "Running: git push origin master:refs/heads/master"
  git push origin master:refs/heads/master
}

```
#### Function Calls:


```bash
No functions called.
```




******
### git_pub():


***about***: publishes current branch to remote origin


***group***: git


```bash
function git_pub() {
  BRANCH=$(git rev-parse --abbrev-ref HEAD)

  echo "Publishing ${BRANCH} to remote origin"
  git push -u origin $BRANCH
}

```
#### Function Calls:


```bash
No functions called.
```




******
### git_revert():


***about***: applies changes to HEAD that revert all changes after this commit


***group***: git


```bash
function git_revert() {

  git reset $1
  git reset --soft HEAD@{1}
  git commit -m "Revert to ${1}"
  git reset --hard
}

```
#### Function Calls:


```bash
No functions called.
```




******
### git_rollback():


***about***: resets the current HEAD to this commit


***group***: git


```bash
function git_rollback() {

  function is_clean() {
    if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then
      echo "Your branch is dirty, please commit your changes"
      kill -INT $$
    fi
  }

  function commit_exists() {
    git rev-list --quiet $1
    status=$?
    if [ $status -ne 0 ]; then
      echo "Commit ${1} does not exist"
      kill -INT $$
    fi
  }

  function keep_changes() {
    while true
    do
      read -p "Do you want to keep all changes from rolled back revisions in your working tree? [Y/N]" RESP
      case $RESP
      in
      [yY])
        echo "Rolling back to commit ${1} with unstaged changes"
        git reset $1
        break
        ;;
      [nN])
        echo "Rolling back to commit ${1} with a clean working tree"
        git reset --hard $1
        break
        ;;
      *)
        echo "Please enter Y or N"
      esac
    done
  }

  if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
    is_clean
    commit_exists $1

    while true
    do
      read -p "WARNING: This will change your history and move the current HEAD back to commit ${1}, continue? [Y/N]" RESP
      case $RESP
        in
        [yY])
          keep_changes $1
          break
          ;;
        [nN])
          break
          ;;
        *)
          echo "Please enter Y or N"
      esac
    done
  else
    echo "you're currently not in a git repository"
  fi
}

```
#### Function Calls:


```bash
No functions called.
```




******
### git_remove_missing_files():


***group***: git


```bash
function git_remove_missing_files() {

  git ls-files -d -z | xargs -0 git update-index --remove
}

```
#### Function Calls:


```bash
No functions called.
```




******
### local-ignore():


***about***: adds file or path to git exclude file


***param***: 1: file or path fragment to ignore


***group***: git


```bash
function local-ignore() {
  echo "$1" >> .git/info/exclude
}

```
#### Function Calls:


```bash
No functions called.
```




******
### git_info():


***about***: overview for your git repo


***group***: git


```bash
function git_info() {

    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        echo "git repo overview"
        echo "-----------------"
        echo

        for remote in $(git remote show); do
            echo $remote:
            git remote show $remote
            echo
        done

        echo "status:"
        if [ -n "$(git status -s 2> /dev/null)" ]; then
            git status -s
        else
            echo "working directory is clean"
        fi

        echo
        echo "log:"
        git log -5 --oneline
        echo

    else
        echo "you're currently not in a git repository"

    fi
}

```
#### Function Calls:


```bash
No functions called.
```




******
### git_stats:


***about***: display stats per author


***group***: git


```bash
function git_stats {


if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
    echo "Number of commits per author:"
    git --no-pager shortlog -sn --all
    AUTHORS=$( git shortlog -sn --all | cut -f2 | cut -f1 -d' ')
    LOGOPTS=""
    if [ "$1" == '-w' ]; then
        LOGOPTS="$LOGOPTS -w"
        shift
    fi
    if [ "$1" == '-M' ]; then
        LOGOPTS="$LOGOPTS -M"
        shift
    fi
    if [ "$1" == '-C' ]; then
        LOGOPTS="$LOGOPTS -C --find-copies-harder"
        shift
    fi
    for a in $AUTHORS
    do
        echo '-------------------'
        echo "Statistics for: $a"
        echo -n "Number of files changed: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f3 | sort -iu | wc -l
        echo -n "Number of lines added: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f1 | awk '{s+=$1} END {print s}'
        echo -n "Number of lines deleted: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f2 | awk '{s+=$1} END {print s}'
        echo -n "Number of merges: "
        git log $LOGOPTS --all --merges --author=$a | grep -c '^commit'
    done
else
    echo "you're currently not in a git repository"
fi
}

```
#### Function Calls:


```bash
No functions called.
```




******
### gittowork():


***about***: Places the latest .gitignore file for a given project type in the current directory, or concatenates onto an existing .gitignore


***group***: git


***param***: 1: the language/type of the project, used for determining the contents of the .gitignore file


***example***: `$ gittowork java`


```bash
function gittowork() {

  result=$(curl -L "https://www.gitignore.io/api/$1" 2>/dev/null)

  if [[ $result =~ ERROR ]]; then
    echo "Query '$1' has no match. See a list of possible queries with 'gittowork list'"
  elif [[ $1 = list ]]; then
    echo "$result"
  else
    if [[ -f .gitignore ]]; then
      result=`echo "$result" | grep -v "# Created by http://www.gitignore.io"`
      echo ".gitignore already exists, appending..."
      echo "$result" >> .gitignore
    else
      echo "$result" > .gitignore
    fi
  fi
}

```
#### Function Calls:


```bash
No functions called.
```




******
### gitignore-reload():


***about***: Empties the git cache, and readds all files not blacklisted by .gitignore


***group***: git


***example***: `$ gitignore-reload`


```bash
function gitignore-reload() {



  git update-index -q --ignore-submodules --refresh
  err=0

  if ! git diff-files --quiet --ignore-submodules --
  then
    echo >&2 "ERROR: Cannot reload .gitignore: Your index contains unstaged changes."
    git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
    err=1
  fi

  if ! git diff-index --cached --quiet HEAD --ignore-submodules
  then
    echo >&2 "ERROR: Cannot reload .gitignore: Your index contains uncommited changes."
    git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
    err=1
  fi

  if [ $err = 1 ]
  then
    echo >&2 "Please commit or stash them."
  fi


  if [ $err = 0 ]; then
    git rm -r --cached .

    echo >&2 "Running git add ."
    git add .
    echo >&2 "Files readded. Commit your new changes now."
  fi
}

```
#### Function Calls:


```bash
No functions called.
```




******
### git_greedy_get():


***about***: Pulls all existing remote brachches when executed in an existing git repo


***group***: git


***example***: `$ git_greedy_get`


```bash
function git_greedy_get() {
  git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
  git fetch --all
  git pull --all
}

```
#### Function Calls:


```bash
No functions called.
```


