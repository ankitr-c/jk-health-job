#!/bin/bash

ip_addr=$1

if [ -z "$ip_addr" ]; then
  echo "IP address not provided"
  exit 1
fi

result=$(gcloud compute instances list --filter="networkInterfaces.accessConfigs.natIP:${ip_addr} OR networkInterfaces.networkIP:${ip_addr}" | awk 'NR==2 {print $1, $NF; exit}')
status=$(echo $result | awk '{print $NF}')
name=$(echo $result | awk '{print $1}')

if [ -z "$status" ]; then
  echo "Status is: DELETED or VM Unavailable"
elif [ "$status" = "RUNNING" ]; then
  echo "VM with IP: $ip_addr"
  echo "NAME: $name"
  echo "STATUS: RUNNING"  
elif [ "$status" = "TERMINATED" ]; then
  echo "VM with IP: $ip_addr"
  echo "NAME: $name"
  echo "STATUS: STOPPED"
fi
