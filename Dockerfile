FROM centos:7 as demo_ansible
RUN  yum check-update; \
   yum install -y gcc libffi-devel python3-devel openssl-devel epel-release; \
   yum install -y python3-pip python3-wheel sshpass; 
RUN  pip3 install ansible
RUN yum install -y openssh*;
RUN yum install -y initscripts;
RUN ansible-galaxy collection install ibm.ibm_zos_core:==1.1.0-beta1
# RUN ansible-galaxy collection install ibm.ibm_zos_core
WORKDIR /root
COPY ansible.cfg .
COPY hosts.yml .
COPY tvt5106.yml .
COPY ping.yml .
COPY submit-job.yml .
COPY proc-update.yml .
RUN service sshd restart
ENTRYPOINT /bin/bash 