# Note: When you create an EKS cluster with eksctl, it generates a kubeconfig file that kubectl uses to connect to the cluster.


```
aws eks update-kubeconfig --region us-east-1 --name expense 
```