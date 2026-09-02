#!/usr/bin/env bash
printf '%s\n' "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"
# Mon Aug 31 2026

# device plugged into isomer
spacktivity="/mnt/tethys/spacktivity"
spack_mirror="${spacktivity}/spack_mirror"
spack_yaml="${spacktivity}/spack_yaml"

export TMPDIR=/mnt/T7-Shield/tmp

feed_spack_mirror()
{
    echo "rsync from \${SPACK_ROOT} = ${SPACK_ROOT}"
    echo "rsync to   \${spack_mirror} = ${spack_mirror}"

    rsync -vauh \
        "${SPACK_ROOT}/var/spack/cache/_source-cache/archive/." \
        "${spack_mirror}/_source-cache/archive/."
}

