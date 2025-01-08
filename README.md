# Docker-OpenSSH

A Docker container for OpenSSH server setup.

## 🛠️ Setup Instructions

1. Build the Docker image :
   ```bash
   docker build -t 'Name':6.9p1 .

2. Run the Docker image :
   ```bash   
   docker run --rm -it 'Name':6.9p1

3. Check the Version :
   ```bash
   docker run --rm 'Name':6.9p1 ssh -V

## 🌐 OpenSSH Source (Download tar.gz Files)
   🔗 https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/
   ```bash
     wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-(version).tar.gz
     tar -xzf openssh-(version).tar.gz
     cd openssh-(version)
 

