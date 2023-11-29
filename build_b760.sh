#!/bin/bash
# GenericPC Power Daemon
# Building GenericPC Power  Daemon script

WORKDIR=$PWD

mkdir -p ${WORKDIR}/debian/usr/lib/systemd/system
mkdir -p ${WORKDIR}/debian/usr/sbin

mkdir -p ${WORKDIR}/debian/var/cache/gpowerd
chmod 600 ${WORKDIR}/debian/var/cache/gpowerd


#VER=$(grep VERSION Makefile | awk 'NR==5{print $2}' FS=" = ")
VER=1.0.0
sed -i "s/Version:.*/Version: ${VER}/g" ${WORKDIR}/debian/DEBIAN/control

cp -f  generic_pc_b760_powerd ${WORKDIR}/debian/usr/sbin
chmod 755 ${WORKDIR}/debian/usr/sbin/generic_pc_powerd
#cd ../..

cp -f  genericpc.service ${WORKDIR}/debian/usr/lib/systemd/system

cp -f saved_parameters_tfb760.genericpcd ${WORKDIR}/debian/var/cache/gpowerd
cp -f saved_results_tfb760.genericpcd ${WORKDIR}/debian/var/cache/gpowerd 


rm -f *.deb

dpkg-deb --build --root-owner-group debian
dpkg-name debian.deb
