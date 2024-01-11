#!/usr/bin/env bash

set -eu pipefail
shopt -s failglob

DIR=/root/src
mkdir -p $DIR
pushd $DIR

git config --global user.email "test@test.com"
git config --global user.name "Testy Test"

git clone https://github.com/SolidRun/lx2160a_build.git
git clone https://github.com/nxp-qoriq/u-boot
git clone https://github.com/nxp-qoriq/atf
git clone https://github.com/nxp-qoriq/rcw
git clone https://github.com/nxp-qoriq/ddr-phy-binary

mkdir -p $DIR/toolchain
pushd $DIR/toolchain

wget https://releases.linaro.org/components/toolchain/binaries/7.4-2019.02/aarch64-linux-gnu/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz
tar -xvf gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz
popd

export PATH=$DIR/toolchain/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin:$PATH
export CROSS_COMPILE=aarch64-linux-gnu-
export ARCH=arm64

pushd $DIR/u-boot
git checkout -b LSDK-21.08 refs/tags/LSDK-21.08
git am ../lx2160a_build/patches/u-boot-LSDK-21.08/*
popd

pushd $DIR/atf
git checkout -b LSDK-21.08 refs/tags/LSDK-21.08
git am ../lx2160a_build/patches/atf-LSDK-21.08/*
popd

pushd $DIR/rcw
git checkout -b LSDK-21.08 refs/tags/LSDK-21.08
git am ../lx2160a_build/patches/rcw-LSDK-21.08/*
popd


pushd $DIR/u-boot
make lx2160acex7_tfa_defconfig
make -j16
export BL33=$PWD/u-boot.bin
popd

pushd $DIR/rcw/lx2160acex7
export SPEED=2000_800_3200
mkdir -p RCW
echo "#include <configs/lx2160a_defaults.rcwi>" > RCW/template.rcw
echo "#include <configs/lx2160a_${SPEED}.rcwi>" >> RCW/template.rcw
echo "#include <configs/lx2160a_SD1_8.rcwi>" >> RCW/template.rcw
echo "#include <configs/lx2160a_SD2_5.rcwi>" >> RCW/template.rcw
echo "#include <configs/lx2160a_SD3_2.rcwi>" >> RCW/template.rcw
make clean
make -j16
popd

pushd $DIR/atf
make PLAT=lx2160acex7 clean
make -j16 PLAT=lx2160acex7 DDR_PHY_BIN_PATH=$DIR/ddr-phy-binary/lx2160a \
     RCW=$DIR/rcw/lx2160acex7/RCW/template.bin TRUSTED_BOARD_BOOT=0 \
     SECURE_BOOT=false GENERATE_COT=0 BOOT_MODE=auto \
     all fip fip_ddr pbl
popd
