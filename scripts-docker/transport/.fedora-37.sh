#!/bin/bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Wed Dec 29 15:05:49 MST 2021

source ~/.bashrc

# # I D E N T I F Y   P L A T F O R M
export      owner="docker"
export  bash_file=".${moniker}.sh"

# # I D E N T I F Y   S O F T W A R E
export         os="linux"
export       dist="fedora"
export    release="37"
export      build=""
export  bash_file=".${dist}-${release}.sh"

export        tag="${dist}-${release}"
export    mySpack="${tag}-${USER}-docker-spack"

# #  R E P O S I T O R I E S
export         repos="/repos"

export        github="${repos}/github"
export  bash_scripts="${github}/gitlab-bash-scripts"
export          core="${bash_scripts}/core-scripts"

# #  D R O P B O X
export  dirDropbox="/Dropbox"

# #  S P A C K
export          mySpack="/spacktivity"
export big_spack_mirror="${mySpack}/mirror"
export      local_spack="${HOME}/${mySpack}"

# #  C O M P I L E R S
export gcc_system_compiler="gcc@11.2.0"

# **  **  **  **  **  **  **  **

source "${core}/master.sh"

# **  **  **  **  **  **  **  **

source "${HOME}/${extras}"


alias reap-spack="source ${repo_build}/scripts-spack/reaper/test-reaper.sh"

alias hot="cd ${bitbucket}/code-fortran/aer/shell-scripting; pwd"

# Quaxolotl:~ dantopa$ gcc --version
# Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/c++/4.2.1
# Apple clang version 13.0.0 (clang-1300.0.29.30)
# Target: x86_64-apple-darwin21.2.0
# Thread model: posix
# InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

# Quaxolotl:~ dantopa$ uname -a
# Darwin Quaxolotl.local 21.2.0 Darwin Kernel Version 21.2.0: Sun Nov 28 20:28:54 PST 2021; root:xnu-8019.61.5~1/RELEASE_X86_64 x86_64
# Quaxolotl:~ dantopa$ cat /etc/*release
