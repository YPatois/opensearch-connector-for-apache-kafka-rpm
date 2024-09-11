%define rel_ver 3.1.1
%define pkg_ver 1
Name:           opensearch-connector-for-apache-kafka
Version:        %{rel_ver}
Release:        %{pkg_ver}%{?dist}
Summary: Aiven's OpenSearch Sink Connector for Apache Kafka
License: Apache License v2.0
Group: Applications/Databases
URL: https://github.com/Aiven-Open/opensearch-connector-for-apache-kafka
BuildArch: noarch
Source0: https://github.com/Aiven-Open/opensearch-connector-for-apache-kafka/archive/refs/tags/v%{rel_ver}.zip


BuildRoot: %{_tmppath}/%{name}-%{rel_ver}-%{release}-root
#BuildRequires: gcc,make,libtool,autoconf,cppunit-devel,maven,hostname,systemd
BuildRequires: java-11-openjdk-devel
#BuildRequires:	python3-devel

Requires: kafka

AutoReqProv: no

%description
Aiven's OpenSearch Connector for Apache Kafka

%define _ocfak_src_dir  %{name}-%{version}
%define _ocfak_noarch_libdir %{_noarch_libdir}/opensearch-connector-for-apache-kafka

%define _ocfak_bi_dir build/install/%{name}

%prep
%setup -q -n %{_ocfak_src_dir}

%build
./gradlew clean installDist

%install
rm -rf %{buildroot}
install -p -d %{buildroot}%{_ocfak_noarch_libdir}
cp -a %{_ocfak_bi_dir}*.jar %{buildroot}%{_ocfak_noarch_libdir}

install -p -d %{buildroot}%{_sysconfdir}/kafka/opensearch-connector-for-apache-kafka
install -p -D -m 644 %{_ocfak_bi_dir}/config/quickstart-elasticsearch.properties %{buildroot}%{_sysconfdir}/kafka/opensearch-connector-for-apache-kafka/quickstart-elasticsearch.properties

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
%doc LICENSE README.md version licenses
%{_ocfak_noarch_libdir}
%config(noreplace) %{_sysconfdir}/kafka/opensearch-connector-for-apache-kafka


%changelog
* Wed Sep 11 2024 Yannick Patois <yannick.patois@iphc.cnrs.fr> - 3.1.1
- Create package project
