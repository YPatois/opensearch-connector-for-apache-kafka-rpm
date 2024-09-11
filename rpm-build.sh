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

rpmbuild --define "_topdir $TOPDIR" -ba ${TOPDIR}/SPECS/$SPECFILE

exit 0


rm -rf build
# def
export TOPDIR=$(pwd)/build/rpmbuild
#rpmdev-setuptree --define "_rpmdir $TOPDIR"

# make TOPDIR
mkdir -p ${TOPDIR}

# copy SPECS to TOPDIR
cp -rf SPECS ${TOPDIR}
# copy SOURCES to TOPDIR
cp -rf SOURCES ${TOPDIR}

# build
spectool -C ${TOPDIR}/SOURCES -g ${TOPDIR}/SPECS/kafka.spec

# Direct
#rpmbuild --define "_topdir $TOPDIR" -ba ${TOPDIR}/SPECS/kafka.spec

# mock
rpmbuild -bs --nodeps --define "_topdir $TOPDIR" ${TOPDIR}/SPECS/kafka.spec
mock --enable-network $TOPDIR/SRPMS/kafka*.src.rpm
