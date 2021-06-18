# ----------------------------------------------------------------------------
#
# Package       : infinispan
# Version       : 12.1.3.Final
# Source repo   : https://github.com/infinispan/infinispan
# Tested on     : ubi8.3
# Script License: Apache License, Version 2 or later
# Maintainer    : Md.Afsan Hossain <mdafsan.hossain@ibm.com>
#
# Disclaimer: This script has been tested in root mode on given
# ==========  platform using the mentioned version of the package.
#             It may not work as expected with newer versions of the
#             package and/or distribution. In such case, please
#             contact "Maintainer" of this script.
#
# ----------------------------------------------------------------------------

#!/bin/bash

BUILD_VERSION=12.1.3.Final

#Install dependencies
yum -y update
yum -y install wget git lsof
yum install -y openssl-devel.ppc64le 
yum install -y maven

#Install java
yum install -y java-11-openjdk java-11-openjdk-devel
whichJavaString=$(ls /usr/lib/jvm/ | grep -P '^(?=.*java-11-openjdk-11)(?=.*ppc64le)')
export JAVA_HOME=/usr/lib/jvm/$whichJavaString

#Build Infinispan
git clone https://github.com/infinispan/infinispan
cd infinispan && git checkout $BUILD_VERSION
mvn -s maven-settings.xml clean install -Dmaven.test.failure.ignore=true
