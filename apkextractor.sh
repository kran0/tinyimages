#!/bin/sh

# Extracts installed apk package files
#  from Alpine system to the target directory
#
# USAGE: $0 PACKAGE [PACKAGE] ... [PACKAGE]
#

[ -z "${1}" ]      && exit 0            #We need packages names in ${@}
[ -z "${TARGET}" ] && TARGET='/target'
mkdir -p "${TARGET}"

function getDependsOn {                 #Find full number of depencies

 [ -z "${1}" ] && exit 0

 if [ -z "${SEENFILE}" ]
 then
  SEENFILE="$(mktemp)"
  printf '%s\n' ${@} > "${SEENFILE}"
  trap 'rm "${SEENFILE}"' EXIT
 fi

 DEPENDSON=$(apk info -R ${@}\
             | sed -e '/ depends on:$/d;/^[[:space:]]*$/d;s/=.*$//'\
             | grep -Fxvf "${SEENFILE}"\
             | tee -a "${SEENFILE}")

 printf '%s\n' ${@} ${DEPENDSON} $(getDependsOn ${DEPENDSON})
}

function getContains {    # find unique file names containing in given packages
 (

 [ -z "${ADDFILES}" ]\
  || printf '%s\n' ${ADDFILES}

 [ -z "${1}" ]\
  || apk info -L ${@} | sed -e '/ contains:$/d'

 )\
  | sed -e '/^[[:space:]]*$/d'\
  | sort -u

}

# MAIN call

apk add --quiet --update --virtual .apkextractor ${@}

getContains $(getDependsOn .apkextractor | sort -u)\
 | tar vc -C / -T -\
 | tar x -C "${TARGET}"

apk del .apkextractor
