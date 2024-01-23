ip_addr=$1
gcloud compute instances list --filter="networkInterfaces.accessConfigs.natIP:${ip_addr} OR networkInterfaces.networkIP:${ip_addr}" 
