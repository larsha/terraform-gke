#!/bin/bash

gcloud container clusters get-credentials $1 \
    --zone $2 \
    --project $3

kubectl create ns tiller
kubectl create -f ./local-exec/setup.yaml

helm init \
    --service-account tiller \
    --tiller-namespace tiller \
    --wait

# Install cert-manager
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.7/deploy/manifests/00-crds.yaml

# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Label the cert-manager namespace to disable resource validation
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install \
  --namespace cert-manager \
  --tiller-namespace tiller \
  --name cert-manager \
  --version v0.7.2 \
  jetstack/cert-manager

# Install nginx-ingress
helm install \
    --namespace nginx-ingress \
    --tiller-namespace tiller \
    --name nginx \
    --set controller.service.loadBalancerIP=$4 \
    --set controller.service.externalTrafficPolicy=Local \
    --set controller.ingressClass=external \
    --set controller.stats.enabled=true \
    --set controller.metrics.enabled=true \
    --version 1.6.0 \
    stable/nginx-ingress