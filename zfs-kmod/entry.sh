
ZFS_VERSION=2.2.2

wget https://github.com/openzfs/zfs/releases/download/zfs-${ZFS_VERSION}/zfs-${ZFS_VERSION}.tar.gz

tar -xzvf zfs-${ZFS_VERSION}.tar.gz

cd zfs-${ZFS_VERSION}

./configure --with-spec=redhat

make -j1 rpm-utils rpm-kmod
