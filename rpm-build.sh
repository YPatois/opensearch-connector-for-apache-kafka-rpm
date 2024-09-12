#!/bin/bash -x


SPECFILE=opensearch-connector-for-apache-kafka.spec

rm -rf build
export TOPDIR=$(pwd)/build/rpmbuild

# make TOPDIR
mkdir -p ${TOPDIR}
mkdir -p ${TOPDIR}/SPECS
mkdir -p ${TOPDIR}/SOURCES
cp -f $SPECFILE ${TOPDIR}/SPECS
spectool -C ${TOPDIR}/SOURCES  -g ${TOPDIR}/SPECS/$SPECFILE

# Direct
# rpmbuild --define "_topdir $TOPDIR" -ba ${TOPDIR}/SPECS/$SPECFILE

# mock
rpmbuild -bs --nodeps --define "_topdir $TOPDIR" ${TOPDIR}/SPECS/$SPECFILE
mock --enable-network $TOPDIR/SRPMS/opensearch-connector-for-apache-kafka*.src.rpm
