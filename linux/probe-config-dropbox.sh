echo "=== DROPBOX INFO.JSON ==="
cat ~/.dropbox/info.json 2>&1

echo
echo "=== DROPBOX CONFIG DIRECTORY ==="
ls -alh ~/.dropbox

echo
echo "=== HOME DROPBOX TOP LEVEL ==="
ls -alh ~/Dropbox | head -50

echo
echo "=== T7 DROPBOX TOP LEVEL ==="
ls -alh /mnt/T7-Shield/Dropbox

echo
echo "=== FILESYSTEM IDs ==="
df -T ~/Dropbox /mnt/T7-Shield/Dropbox

echo
echo "=== HOME/T7 REAL PATHS ==="
readlink -f ~/Dropbox
readlink -f /mnt/T7-Shield/Dropbox
