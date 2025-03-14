
ZFS_VERSION=2.3.1

rm -f ${ZFS_VERSION}.tar.gz
rm -rf zfs-${ZFS_VERSION}

wget https://github.com/openzfs/zfs/releases/download/zfs-${ZFS_VERSION}/zfs-${ZFS_VERSION}.tar.gz

tar -xzvf zfs-${ZFS_VERSION}.tar.gz

cd zfs-${ZFS_VERSION}

./configure

make -j1 rpm-utils rpm-kmod
