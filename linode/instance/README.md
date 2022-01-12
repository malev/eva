## Linode K8s cluster

### Usage

Start running `terraform init`, then create a file `terraform.tfvars` with the following content:

```
label       = "galileo"
k8s_version = "1.22"
region      = "us-central"
pools = [
  {
    type : "g6-standard-1"
    count : 3
  }
]
pvt_key = "YOU-PUB-KEY"
token   = "YOUR-LINODE-TOKEN"
```

Run:

```
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

If you need to change the type of nodes, run `curl https://api.linode.com/v4/linode/types` to retrieve a list of available types.
