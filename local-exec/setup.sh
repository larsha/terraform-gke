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

# Install defaults
helm install \
	--namespace cert-manager \
	--tiller-namespace tiller \
	--name cert-manager \
	stable/cert-manager