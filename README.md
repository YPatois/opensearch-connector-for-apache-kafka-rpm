# Overview

This repository contains everything needed to build RPM's for opensearch-connector-for-apache-kafka.
The spec has been tested on EL9.

## Prepare

Ensure packages are installed that provide tools to build the srpm and mock build the binary rpms.

- `sudo dnf install -y rpm-build rpmdevtools mock`

## Building

1. `git clone `
2. `cd opensearch-connector-for-apache-kafka-rpms`
3. `rpmdev-setuptree`
4. `spectool -g opensearch-connector-for-apache-kafka.spec`
5. `rpmbuild -bs --nodeps --define "_sourcedir $(pwd)" --define "_srcrpmdir $(pwd)" opensearch-connector-for-apache-kafka.spec`
6. `sudo mock --enable-network <the srpm from step 5>`


## License

All files in this repository are licensed under the Apache 2 license. Any
redistribution of these files must include the original license as well as
attribution to this repository.
