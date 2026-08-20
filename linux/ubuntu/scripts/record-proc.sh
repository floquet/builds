#!/usr/bin/env bash
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

: "${pSelf:?pSelf is not defined}"

# ----------------------------------------------------------------------

# /proc recorder

# ----------------------------------------------------------------------

procStart=$SECONDS

pProc="${pSelf}/proc"
mkdir -p "${pProc}"

pLog="${pProc}/record-proc.log"
: > "${pLog}"

# ----------------------------------------------------------------------

# Capture one /proc file

# ----------------------------------------------------------------------

proc_probe() {
local probe="$1"
local description="$2"

```
local safe="${probe//\//-}"
local source="/proc/${probe}"
local output="${pProc}/proc-${safe}.txt"
local start=$SECONDS

{
    date
    echo
    echo "COMMAND: cat ${source}"
    echo "DESCRIPTION: ${description}"
    echo

    if [[ -f "${source}" ]]; then
        cat "${source}"
    else
        echo "NOT AVAILABLE: ${source}"
    fi
} > "${output}" 2>&1

printf "%s  %-24s time=%d seconds\n" \
    "$(date)" "${probe}" "$((SECONDS - start))" >> "${pLog}"
```

}

# ----------------------------------------------------------------------

# Standard /proc probes

# ----------------------------------------------------------------------

proc_probe "buddyinfo" 
"Memory fragmentation information" &

proc_probe "cmdline" 
"Kernel command line used at boot" &

proc_probe "cpuinfo" 
"Processor and logical CPU information" &

proc_probe "crypto" 
"Cryptographic algorithms registered with the kernel" &

proc_probe "devices" 
"Configured character and block device major numbers" &

proc_probe "dma" 
"Registered DMA channels" &

proc_probe "execdomains" 
"Execution domains supported by the kernel" &

proc_probe "fb" 
"Registered framebuffer devices" &

proc_probe "filesystems" 
"Filesystem types supported by the kernel" &

proc_probe "interrupts" 
"Interrupt counts and IRQ information" &

proc_probe "iomem" 
"Physical memory and device address map" &

proc_probe "ioports" 
"Registered I/O port regions" &

proc_probe "loadavg" 
"System load averages and scheduler information" &

proc_probe "locks" 
"File locks currently managed by the kernel" &

proc_probe "mdstat" 
"Linux software RAID status" &

proc_probe "meminfo" 
"Detailed memory statistics" &

proc_probe "misc" 
"Miscellaneous character devices" &

proc_probe "modules" 
"Currently loaded kernel modules" &

proc_probe "mounts" 
"Mounted filesystems" &

proc_probe "mtrr" 
"Memory Type Range Register information" &

proc_probe "partitions" 
"Known block-device partitions" &

proc_probe "scsi/scsi" 
"SCSI devices known to the kernel" &

proc_probe "slabinfo" 
"Kernel slab allocator statistics" &

proc_probe "stat" 
"Kernel and system statistics since boot" &

proc_probe "swaps" 
"Configured swap devices and utilization" &

proc_probe "uptime" 
"System uptime and aggregate idle time" &

proc_probe "version" 
"Kernel version and compiler build information" &

# ----------------------------------------------------------------------

# Wait for all standard probes

# ----------------------------------------------------------------------

wait

# ----------------------------------------------------------------------

# CPU model summary

# ----------------------------------------------------------------------

{
date
echo
echo "COMMAND: grep -i 'model name' /proc/cpuinfo | sort -u"
echo

```
grep -i 'model name' /proc/cpuinfo | sort -u
```

} > "${pProc}/cpu-models.txt" 2>&1

# ----------------------------------------------------------------------

# Selected /proc/sys settings

# ----------------------------------------------------------------------

{
date
echo
echo "COMMAND: cat /proc/sys/vm/panic_on_oom"
echo

```
if [[ -f /proc/sys/vm/panic_on_oom ]]; then
    cat /proc/sys/vm/panic_on_oom
else
    echo "NOT AVAILABLE: /proc/sys/vm/panic_on_oom"
fi
```

} > "${pProc}/panic-on-oom.txt" 2>&1

# ----------------------------------------------------------------------

# Directory inventories for useful /proc subtrees

# ----------------------------------------------------------------------

{
date
echo
echo "COMMAND: find /proc/driver -maxdepth 2 -type f -print"
echo

```
if [[ -d /proc/driver ]]; then
    find /proc/driver -maxdepth 2 -type f -print 2>/dev/null | sort
else
    echo "NOT AVAILABLE: /proc/driver"
fi
```

} > "${pProc}/proc-driver-files.txt" 2>&1

{
date
echo
echo "COMMAND: find /proc/bus -maxdepth 2 -print"
echo

```
if [[ -d /proc/bus ]]; then
    find /proc/bus -maxdepth 2 -print 2>/dev/null | sort
else
    echo "NOT AVAILABLE: /proc/bus"
fi
```

} > "${pProc}/proc-bus-files.txt" 2>&1

# ----------------------------------------------------------------------

# Completion

# ----------------------------------------------------------------------

printf "%s  %-24s COMPLETE  time=%d seconds\n" 


