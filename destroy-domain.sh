#!/bin/bash
#
# Script to connect to prod kubernet
#
#cd provission_cluster
export token=''
export domen_name='pattacpro.co.in'

export NGNX_LOAD_BALANCER_IP=`kubectl get services nginx-ingress-controller --output jsonpath='{.status.loadBalancer.ingress[0].ip}'`
cd provission_domain

terraform destroy -auto-approve -var loadbalancer_ip=$NGNX_LOAD_BALANCER_IP -var do_token=$token -var domain_name=$domen_name
cd ../provission_cluster
terraform destroy -auto-approve -var do_token=$token -var host_name=build.$domen_name


