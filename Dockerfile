FROM centos:centos7
MAINTAINER Onkar Kadam, onkar.kadam@outlook.com

ARG JAVA_VERSION=8
ARG JAVA_BUILD=131

# Install Java.
RUN \
  yum clean all && \
  yum install wget -y && \
   curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_BUILD}-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-${JAVA_VERSION}u${JAVA_BUILD}-linux-x64.rpm > /tmp/jdk-${JAVA_VERSION}u${JAVA_BUILD}-linux-x64.rpm && \ 
  yum install /tmp/jdk-${JAVA_VERSION}u${JAVA_BUILD}-linux-x64.rpm -y && \
  rm -rf /usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_BUILD}/man /usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_BUILD}/*{COPYRIGHT,LICENSE,README,javafx,src}* && \
  yum clean all  && \
  rm -f /usr/bin/java /usr/bin/jar /usr/bin/javac /var/lib/alternatives/java /var/lib/alternatives/jar /var/lib/alternatives/javac && \
  /usr/sbin/alternatives --install /usr/bin/java java /usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_BUILD}/bin/java 2000000 && \
  /usr/sbin/alternatives --install /usr/bin/jar jar /usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_BUILD}/bin/jar 2000000 && \
  /usr/sbin/alternatives --install /usr/bin/javac javac /usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_BUILD}/bin/javac 2000000 && \
  /usr/sbin/update-alternatives --set java /usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_BUILD}/bin/java && \
  /usr/sbin/update-alternatives --set jar /usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_BUILD}/bin/jar && \
  /usr/sbin/update-alternatives --set javac /usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_BUILD}/bin/javac && \
  rm -rf /var/lib/rpm/__db* && \
  rpm --rebuilddb && \
  rm -rf /var/lib/yum/{history,repos,rpmdb-indexes,yumdb} && \
  rm -rf /var/log/* /tmp/* /var/tmp/* 

ENV JAVA_HOME /usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_BUILD}

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

