#! /usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Mon Feb 28 03:27:15 UTC 2022

export elapsed=${SECONDS}

echo "begin: $(date)"
echo ""

echo "Step 1 of 2: apk update"
echo ""

date > results-update.txt
echo "apk update 2>&1 | tee -a results-update.txt" >> results-update.txt
      apk update 2>&1 | tee -a results-update.txt
echo ""

echo "Step 2 of 2: apk upgrade"
echo ""

date > results-upgrade.txt
echo "apk upgrade 2>&1 | tee -a results-upgrade.txt" >> results-upgrade.txt
      apk upgrade 2>&1 | tee -a results-upgrade.txt
echo ""

echo "results posted to results-update.txt and results-upgrade.txt"
echo ""

echo "end: $(date)"

echo ""

export elapsed=$((${SECONDS}-${elapsed}))

printf "time to refresh apk distribution: %dh:%dm:%ds\n" $(($elapsed/3600)) $(($elapsed%3600/60)) $(($elapsed%60))
