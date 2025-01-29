#!/bin/bash

#Installing Docker
echo "************ Docker installation - start *************"
yum install yum-utils -y 
yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo 
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 
systemctl start docker 
systemctl enable docker 
usermod -aG docker ec2-user 
echo "*********** Docker installation - completed *************"

# ec2 instance creation request for Docker expense project
# =============================================
# RHEL-9-DevOps-Practice
# t3.micro
# allow-everything
# 50 GB
# echo "******* Resize EBS Storage - start **************"
# #Note: We can't use these commands in the creation of ec2 instances.
# lsblk 
# sudo growpart /dev/nvme0n1 4  #t3.micro used only
# sudo lvextend -l +50%FREE /dev/RootVG/rootVol 
# sudo lvextend -l +50%FREE /dev/RootVG/varVol 
# sudo xfs_growfs / 
# sudo xfs_growfs /var 
# echo "******* Resize EBS Storage - completed **************"

echo "*************   eksctl installation - start *************"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp 
sudo mv /tmp/eksctl /usr/local/bin 
eksctl version 
echo "*************   eksctl installation - completed *************"

echo "*************   kubectl installation - start *************"
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.0/2024-05-12/bin/linux/amd64/kubectl 
sudo chmod +x ./kubectl 
sudo mv kubectl  /usr/local/bin/ 
kubectl version --client 
echo "*************   kubectl installation - completed *************"

echo "*************kubens Setup - start*************"
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx 
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens 
kubens expense 
echo "*************kubens Setup - completed*************"

echo "*************Install K9s - Start*************"
#Installing K9s
curl -sS https://webinstall.dev/k9s | bash 
k9s --version
echo "*************Install K9s - completed*************"


echo "*************Install Helm - Start*************"
#Installing Helm in Kubernetes
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 
chmod 700 get_helm.sh 
./get_helm.sh 
echo "*************Install Helm - completed*************"

# echo "*************   eksctl cluster creation started *************"
#eksctl create cluster --config-file=eks.yaml 
# VALIDATE $? "eksctl cluster creation process"
# echo "*************   eksctl cluster creation completed *************"