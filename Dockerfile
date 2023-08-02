FROM ubuntu:22.04

LABEL author="bientd88@gmail.com"
WORKDIR /bamboofw


ENV DEBIAN_FRONTEND noninteractive

ENV ETCD_VER=v3.4.26
ENV CALICO_VER=v3.22.1

ENV ETCDCTL_CACERT=/etc/etcd/ssl/ca.pem
ENV ETCDCTL_CERT=/etc/etcd/ssl/etcd.pem
ENV ETCDCTL_KEY=/etc/etcd/ssl/etcd-key.pem
ENV ETCDCTL_API=3

# choose either URL
RUN apt update && apt install tar curl -y && \
    curl -L https://github.com/etcd-io/etcd/releases/download/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz && \
    curl -L https://github.com/projectcalico/calico/releases/download/${CALICO_VER}/calicoctl-linux-amd64 -o /tmp/calicoctl && \
    tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /tmp && \
    cp /tmp/etcd-${ETCD_VER}-linux-amd64/etcdctl /usr/bin/etcdctl && \
    mv /tmp/calicoctl /usr/bin/calicoctl && \
    chmod 0755 /usr/bin/etcdctl && \
    chmod 0755 /usr/bin/calicoctl && \
    rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/*

ADD init.sh /bamboofw/init.sh
RUN chmod 0755 /bamboofw/init.sh
