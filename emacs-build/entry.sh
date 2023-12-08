#!/usr/bin/env bash

set -eu -o pipefail
shopt -s failglob

cd /root/rpmbuild/SOURCES/

git clone https://src.fedoraproject.org/rpms/emacs.git .

spectool -g -R emacs.spec

dnf builddep -y emacs.spec

rpmbuild -bs emacs.spec

cd /root/rpmbuild/SRPMS/

rpmbuild --rebuild emacs*.src.rpm
