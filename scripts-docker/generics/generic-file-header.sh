#! /bin/
printf '%s\n' "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# source generic-file-header.sh <file-name>

    date                  >  ${1}
    echo ""               >> ${1}
    echo "${SPACK_ROOT}"  >> ${1}
    echo ""               >> ${1}
    echo "lsb_release -a" >> ${1}
          lsb_release -a  >> ${1}
    echo ""               >> ${1}
    echo "lsb_release -a" >> ${1}
    cat /etc/os-release   >> ${1}
    echo ""               >> ${1}
