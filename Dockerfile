FROM centos:7

# Update repository to use vault
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum update -y && \
    yum install -y \
    gcc \
    make \
    openssl-devel \
    zlib-devel \
    pam-devel \
    wget \
    tar && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.9p1.tar.gz && \
    tar -xzf openssh-6.9p1.tar.gz && \
    cd openssh-6.9p1 && \
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc/ssh \
        --with-pam \
        --with-zlib \
        --with-ssl-dir=/usr \
        --with-md5-passwords \
        --with-privsep-path=/var/lib/sshd && \
    make && \
    make install

RUN mkdir -p /etc/ssh && \
    echo "Host *" > /etc/ssh/ssh_config && \
    echo "    KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256" >> /etc/ssh/ssh_config && \
    echo "    Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com" >> /etc/ssh/ssh_config && \
    echo "    MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com" >> /etc/ssh/ssh_config && \
    echo "    HashKnownHosts yes" >> /etc/ssh/ssh_config && \
    echo "    VerifyHostKeyDNS yes" >> /etc/ssh/ssh_config

RUN useradd -m -s /bin/bash sshuser && \
    mkdir -p /home/sshuser/.ssh && \
    chmod 700 /home/sshuser/.ssh && \
    chown -R sshuser:sshuser /home/sshuser/.ssh

USER sshuser
WORKDIR /home/sshuser