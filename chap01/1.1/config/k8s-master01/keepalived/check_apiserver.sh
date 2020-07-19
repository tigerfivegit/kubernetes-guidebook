#!/bin/bash

function check_apiserver() {
  for ((i=0;i<5;i++));do
    apiserver_job_id=$(pgrep kube-apiserver)
    if [[ ! -z $apiserver_job_id ]];then
       return
    else
       sleep 2
    fi
    apiserver_job_id=0
  done
}

# 1: running 0: stopped
check_apiserver
if [[ $apiserver_job_id -eq 0 ]]; then
    /usr/bin/systemctl stop keepalived
    exit 1
else
    exit 0
fi
