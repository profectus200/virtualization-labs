#! /bin/bash

set -e

if [ ! -f disk.img ]; then
	dd if=/dev/zero of=disk.img bs=1 count=0 seek=100M
	mkfs.ext4 disk.img
fi

sudo mkdir -p disk
sudo mount -o loop disk.img disk

cp benchmark.sh disk

cd disk
unshare --pid --net --mount --fork --map-root-user /bin/bash << 'EOF'

echo "PID: $$"

echo "Hello World!" >> test.txt

sh benchmark.sh | tee benchmark_results.txt

EOF
