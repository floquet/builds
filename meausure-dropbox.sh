echo "=== DROPBOX STATUS ==="
dropbox status

echo
echo "=== HOME DROPBOX SIZE ==="
du -sh ~/Dropbox

echo
echo "=== T7 FREE SPACE ==="
df -h /mnt/T7-Shield

echo
echo "=== FILE COUNTS ==="
printf "HOME Dropbox files: "
find ~/Dropbox -type f | wc -l

printf "T7 Dropbox files: "
find /mnt/T7-Shield/Dropbox -type f | wc -l

echo
echo "=== DROPBOX OPEN FILES IN ~/Dropbox ==="
lsof +D "$HOME/Dropbox" 2>/dev/null | head -40

echo
echo "=== MOUNTS ==="
findmnt -T ~/Dropbox
findmnt -T /mnt/T7-Shield/Dropbox
