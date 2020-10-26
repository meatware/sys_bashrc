cite about-plugin
about-plugin 'Install additional packages'

# GH_INSTALL_LIB = {{program-name: $GITHUB_USER,$GITHUB_REPO,$Description}}
declare -A GH_INSTALL_LIB='([ccat]="owenthereal,ccat,coloured-cat")'

function get-latest-gh-release {
    about 'Download & extract the latest package release from gihub releases page to /tmp. Use install-usr-local() to install correct file'
    group 'installers'
    param '1: package name. This is used to search an internal dictionary for github connection details'
    example '$ get-latest-gh-release ccat'

    local PACKAGE_NAME=$1
    local GITHUB_USER=$(echo "${GH_INSTALL_LIB[${PACKAGE_NAME}]}" | cut -d, -f1)
    local GITHUB_REPO=$(echo "${GH_INSTALL_LIB[${PACKAGE_NAME}]}" | cut -d, -f2)

    local LNX_AMD64_RELEASE_URL=$(wget -q -nv -O- "https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPO/releases/latest" 2>/dev/null |  jq -r '.assets[] | select(.browser_download_url | contains("linux-amd64")) | .browser_download_url')

    local REL_FILE=$(basename $LNX_AMD64_RELEASE_URL)

	wget -q -nv -O "/tmp/a${REL_FILE}" $LNX_AMD64_RELEASE_URL
	if [ ! -f "/tmp/${REL_FILE}" ]; then
		echo -e "\nDidn't download $LNX_AMD64_RELEASE_URL properly.  Where is /tmp/${REL_FILENAME}?"
        exit 1
	fi

    echo "Now extracting $REL_FILE to /tmp"
    cd /tmp
    extract $REL_FILE
    # As github release packaging style varies - have a look at the uncompressed file and copy
    # correct file(s) using install-usr-local
}


function install-usr-local {
    about 'Move program '
    group 'installers'
    param '1: Program file to move to /usr/local/bin. This function makes it executable '
    example '$ install-usr-local ${SOME_PROG}'

    MYPROG=$1

	sudo mv -fv $MYPROG /usr/local/bin
	sudo chmod -v +x /usr/local/bin/$(basename $MYPROG)
}