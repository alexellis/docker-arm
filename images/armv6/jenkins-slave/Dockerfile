FROM resin/rpi-raspbian

RUN apt-get update 
RUN apt-get install openjdk-7-jdk
RUN apt-get install ca-certificates \
  openssh-server openssl

RUN ssh-keygen -A

RUN addgroup jenkins && \
    useradd jenkins -m -g jenkins --shell /bin/bash && \
    chown -R jenkins:jenkins /home/jenkins && \
    echo "jenkins:jenkins" | chpasswd

RUN set -x && \
    echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowGroups jenkins" >> /etc/ssh/sshd_config

RUN    echo "%jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN mkdir -p  /var/run/sshd

EXPOSE 22
USER jenkins
CMD ["sudo", "/usr/sbin/sshd", "-D"]
