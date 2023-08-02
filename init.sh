#!/usr/bin/bash
etcdctl user add root:${ETCD_ROOT_PASSWORD}
etcdctl role add root
etcdctl role grant-permission --prefix=true root readwrite '/'
etcdctl user grant-role root root

etcdctl user add ${ETCD_BAMBOOFW_USER}:${ETCD_BAMBOOFW_PASSWORD}
etcdctl role add ${ETCD_BAMBOOFW_USER}
etcdctl role grant-permission --prefix=true ${ETCD_BAMBOOFW_USER} readwrite '/calico'
etcdctl user grant-role ${ETCD_BAMBOOFW_USER} ${ETCD_BAMBOOFW_USER}
etcdctl auth enable
