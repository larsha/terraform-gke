# terraform-gke

This will create a complete Kubernetes cluster on GKE bootstrapped with [helm](https://helm.sh/). This will also be installed by default:
- [cert-manager](https://github.com/jetstack/cert-manager)

### Init
```
terraform init
```

### Setup new cluster (prompted)

```
terraform apply
```

### Setup new cluster (pre-defined)

```
terraform apply \
  -var 'zone=europe-north1-a' \
  -var 'machine_type=n1-standard-1' \
  -var 'node_count=3' \
  -var 'disk_size_gb=50' \
  -var 'cluster_name=bumblebee'
```