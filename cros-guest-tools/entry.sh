#!/usr/bin/env bash

set -eu -o pipefail
shopt -s failglob

cd /root/rpmbuild/SOURCES/

git clone https://github.com/mbkulik/cros-guest-tools .

spectool -g -R cros-guest-tools.spec

dnf builddep -y cros-guest-tools.spec

rpmbuild -bs cros-guest-tools.spec

cd /root/rpmbuild/SRPMS/

rpmbuild --rebuild cros-guest-tools*.src.rpm
