#!/bin/bash
#
# Script to connect to prod kubernet
#
#cd provission_cluster
terraform init
terraform apply

export KUBE_API_EP=`terraform output kubernet_host`
export KUBE_API_TOKEN=`terraform output kubernet_token`
#export KUBE_API_CERT=`terraform output kubernet_certificate`
#echo $KUBE_API_CERT > deploy.crt

kubectl config set-cluster k8s --server=$KUBE_API_EP --insecure-skip-tls-verify=true
#kubectl config set-cluster k8s --server=$KUBE_API_EP --certificate-authority=deploy.crt --embed-certs=true
kubectl config set-credentials k8s-deployer --token=$KUBE_API_TOKEN
kubectl config set-context k8s --cluster k8s --user k8s-deployer
kubectl config use-context k8s
kubectl get nodes 
export NGNX_LOAD_BALANCER_IP=`kubectl get services nginx-ingress-controller --output jsonpath='{.status.loadBalancer.ingress[0].ip}'`
cd ../provission_domain
terraform init
terraform apply -var loadbalancer_ip=$NGNX_LOAD_BALANCER_IP


