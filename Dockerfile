# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update; yum clean all
RUN yum -y install openssh-server passwd openssh-clients vim openssl; yum clean all
RUN yum -y group install "Development Tools"; yum clean all
RUN yum -y install dos2unix; yum clean all
RUN yum -y install sudo; yum clean all
RUN yum -y install cronie; yum clean all
RUN yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
RUN yum -y install ripgrep; yum clean all
RUN cd /tmp && curl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py && cd -
ADD ./start.sh /start.sh
RUN mkdir /var/run/sshd

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
# todo copy my sshd_config

RUN chmod 755 /start.sh
# EXPOSE 22
RUN ./start.sh
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
