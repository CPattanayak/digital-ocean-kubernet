#!/bin/bash
#
# Script to connect to prod kubernet
#
#cd provission_cluster
export token=''
export NGNX_LOAD_BALANCER_IP=`kubectl get services nginx-ingress-controller --output jsonpath='{.status.loadBalancer.ingress[0].ip}'`
cd provission_domain

terraform destroy -var loadbalancer_ip=$NGNX_LOAD_BALANCER_IP -var do_token=$token
cd ../provission_cluster
terraform destroy -var do_token=$token


