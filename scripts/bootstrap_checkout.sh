#!/bin/bash

CUR=`pwd`
TOPDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

HOSTNAME=${1:-open4us.org}
DBNAME=${2:-wordpress}
DBUSER=${3:-dbuser}
DBPASS=${4:-}

cd ${TOPDIR}

#
# Git submodules
#

git submodule init
git submodule update

#
# Process substitutions in .in files
#

subst="s|@env_dir@|${TOPDIR}/python_env|;s|@dbname@|${DBNAME}|;s|@dbuser@|${DBUSER}|;s|@dbpass@|${DBPASS}|"
subst_files="docroot/wp-config-local.php"

for i in ${subst_files}
do
    sed -e "${subst}" < "$i.in" > "$i"
done

cd ${CUR}
