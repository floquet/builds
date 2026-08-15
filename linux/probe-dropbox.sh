echo "=== DROPBOX PROCESSES ==="
pgrep -a -f dropbox

echo
echo "=== DROPBOX COMMAND ==="
command -v dropbox
dropbox status 2>&1

echo
echo "=== T7 MOUNT ==="
findmnt /mnt/T7-Shield

echo
echo "=== T7 TOP LEVEL ==="
ls -alh /mnt/T7-Shield

echo
echo "=== EXPECTED DROPBOX DIRECTORY ==="
ls -alh /mnt/T7-Shield/Dropbox 2>&1

echo
echo "=== HOME DROPBOX POSSIBILITIES ==="
ls -ald ~/Dropbox ~/.dropbox ~/.dropbox-dist 2>&1

echo
echo "=== DISK USAGE ==="
du -sh /mnt/T7-Shield/Dropbox 2>/dev/null
du -sh ~/Dropbox 2>/dev/null
