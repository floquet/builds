#!/usr/bin/env bash

printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Initialize counters
counter=0
subcounter=0
start_time=${SECONDS}

# Count steps in batch process

function new_step() {
    counter=$((counter + 1))
    subcounter=0
    echo ""
    echo "Step ${counter}: ${1}"
}

function sub_step() {
    subcounter=$((subcounter + 1))
    echo ""
    echo "  Substep ${counter}.${subcounter}: ${1}"
}


new_step "wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg"
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/sublimehq-archive.gpg > /dev/null

new_step "add stable Sublime repository"
  echo "deb [signed-by=/usr/share/keyrings/sublimehq-archive.gpg] https://download.sublimetext.com/ apt/stable/" \
  | sudo tee /etc/apt/sources.list.d/sublime-text.list
new_step "sudo apt update"
  sudo apt update

new_step "Installs"
  sub_step "sudo apt install sublime-text"
            sudo apt install sublime-text
  sub_step "sudo apt install sublime-merge"
            sudo apt install sublime-merge

new_step "Notes"
  sub_step "launch sublime: subl ."
  sub_step "launch sublime-merge: smerge ."
  sub_step "License key: "
printf '%s\n' \
'----- BEGIN LICENSE -----' \
'Daniel M Topa' \
'Single User License' \
'E3D2-1326545-482417' \
'9FFE9520 BC696FA7 122AC80C A93C5D21' \
'4D1CCB23 FD7C3056 EC16C60D 2D234224' \
'1D89EC82 1C1E61CD 3F47C8E1 BD8CD281' \
'6DFF2BA0 004B8A1A 71BCAE25 93641DAD' \
'AEE13409 72DBF7E4 C410B15E 7EA5AE3F' \
'AA366745 5BCE6BCC 51689E2D 79DB79B1' \
'2C05AD48 696B41C3 07FE492B ECA20A3A' \
'E135A421 C75BF556 4B4A8863 CFC6B986' \
'------ END LICENSE ------'

elapsed=$((${SECONDS} - ${start_time}))

printf 'elapsed time: %dh:%dm:%ds\n' \
    $((${elapsed} / 3600)) \
    $((${elapsed} % 3600 / 60)) \
    $((${elapsed} % 60))

#dantopa@isomer:~/repos-isomer/github/builds/linux/apt$ ./apt-sublime.sh 
#Sun Aug 30 03:34:06 PM MDT 2026, ./apt-sublime.sh
#
#Step 1: wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg
#
#Step 2: add stable Sublime repository
#deb [signed-by=/usr/share/keyrings/sublimehq-archive.gpg] https://download.sublimetext.com/ apt/stable/
#
#Step 3: sudo apt update
#Hit:1 https://downloads.1password.com/linux/debian/amd64 stable InRelease
#Get:2 http://security.ubuntu.com/ubuntu resolute-security InRelease [137 kB]                                                                 
#Hit:3 https://brave-browser-apt-release.s3.brave.com stable InRelease                                                                        
#Get:4 https://dl.google.com/linux/chrome-stable/deb stable InRelease [2,548 B]                                                               
#Hit:5 http://apt.pop-os.org/release-ubuntu resolute InRelease                                                                                
#Hit:6 https://download.sublimetext.com apt/stable/ InRelease                                                                                 
#Get:7 https://zotero.retorque.re/file/apt-package-archive ./ InRelease [1,781 B]                                                             
#Hit:8 http://archive.ubuntu.com/ubuntu resolute InRelease                                                                              
#Get:9 http://security.ubuntu.com/ubuntu resolute-security/main amd64 Components [46.7 kB]           
#Hit:10 http://linux.dropbox.com/ubuntu resolute InRelease                                                   
#Get:11 https://dl.google.com/linux/chrome-stable/deb stable/main amd64 Packages [1,402 B]                   
#Get:12 http://security.ubuntu.com/ubuntu resolute-security/universe amd64 Components [43.1 kB]   
#Get:13 http://archive.ubuntu.com/ubuntu resolute-updates InRelease [137 kB]
#Get:14 http://archive.ubuntu.com/ubuntu resolute-backports InRelease [137 kB]
#Get:15 http://archive.ubuntu.com/ubuntu resolute-updates/main amd64 Components [98.0 kB]
#Get:16 http://archive.ubuntu.com/ubuntu resolute-updates/universe amd64 Components [187 kB]
#Get:17 http://archive.ubuntu.com/ubuntu resolute-backports/universe amd64 Components [1,056 B]
#Fetched 793 kB in 2s (505 kB/s)                
#43 packages can be upgraded. Run 'apt list --upgradable' to see them.
#
#Step 4: Installs
#
#  Substep 4.1: sudo apt install sublime-text
#sublime-text is already the newest version (4200).
#Summary:                    
#  Upgrading: 0, Installing: 0, Removing: 0, Not Upgrading: 43
#
#  Substep 4.2: sudo apt install sublime-merge
#Installing:                     
#  sublime-merge
#
#Summary:
#  Upgrading: 0, Installing: 1, Removing: 0, Not Upgrading: 43
#  Download size: 5,422 kB
#  Space needed: 27.8 MB / 734 GB available
#
#Get:1 https://download.sublimetext.com apt/stable/ sublime-merge 2125 [5,422 kB]
#Fetched 5,422 kB in 1s (6,196 kB/s)     
#Selecting previously unselected package sublime-merge.
#(Reading database… 571467 files and directories currently installed.)
#Preparing to unpack …/sublime-merge_2125_amd64.deb…
#Unpacking sublime-merge (2125)…
#Setting up sublime-merge (2125)…
#Processing triggers for hicolor-icon-theme (0.18-2build1)…
#Processing triggers for gnome-menus (3.38.1-1ubuntu1)…
#Processing triggers for desktop-file-utils (0.28-1build1)…
#
#Step 5: Notes
#
#  Substep 5.1: launch sublime: subl .
#
#  Substep 5.2: launch sublime-merge: smerge .
#
#  Substep 5.3: License key: 
#----- BEGIN LICENSE -----
#Daniel M Topa
#Single User License
#E3D2-1326545-482417
#9FFE9520 BC696FA7 122AC80C A93C5D21
#4D1CCB23 FD7C3056 EC16C60D 2D234224
#1D89EC82 1C1E61CD 3F47C8E1 BD8CD281
#6DFF2BA0 004B8A1A 71BCAE25 93641DAD
#AEE13409 72DBF7E4 C410B15E 7EA5AE3F
#AA366745 5BCE6BCC 51689E2D 79DB79B1
#2C05AD48 696B41C3 07FE492B ECA20A3A
#E135A421 C75BF556 4B4A8863 CFC6B986
#------ END LICENSE ------
#elapsed time: 0h:0m:7s
#dantopa@isomer:~/repos-isomer/github/builds/linux/apt$ date
#Sun Aug 30 03:34:27 PM MDT 2026

