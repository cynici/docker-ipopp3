FROM centos:7
LABEL maintainer "Cheewai Lai <clai@csir.co.za>"

ARG GOSU_VERSION=1.11

RUN yum update -y \
 && yum install -y epel-release \
 && yum update -y \
 # IPOPP required packages \
 && yum install -y bash bc curl ed ftp gawk perl rsync tar tcsh unzip wget libXp libXext libXrender libXtst ImageMagick libaio jemalloc xauth libstdc++.i686 \
 # extra packages for troubleshooting \
 && yum install -y cifs-utils file incron less net-tools openssh-clients rsyslog sudo vim-minimal \
 && echo -e "LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8\n" >/etc/environment \
 && echo -e "*\tsoft\tnproc\t65535\n" >/etc/security/limits.d/20-nproc.conf \
 && curl -o gosu -kfsSL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" \
 && mv gosu /usr/bin/gosu \
 && chmod +x /usr/bin/gosu \
 && yum clean all

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
WORKDIR /home/ipopp
