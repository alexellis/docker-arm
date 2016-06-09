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

RUN apt-get install git
RUN apt-get install curl wget

RUN curl -s \
https://packagecloud.io/install/repositories/Hypriot/Schatzkiste/script.deb.sh | sudo bash
RUN sudo apt-get install docker-hypriot=1.11.1-1
RUN usermod jenkins -aG docker

RUN apt-get install make

EXPOSE 22
USER jenkins
WORKDIR /home/jenkins/
ADD ./init.sh ./init.sh

CMD ["./init.sh"]
