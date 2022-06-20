# Servers setup

## Configuration

```
make .inventory
```

Add a file called hosts with your server's info.

## Eva (local)

```
make plex
```

## killcss.xyz (Digital Ocean)

K3s runs in killcss:

```
kubectl get pods
kubectl apply -f k8s/codingnews.info.yml
```
