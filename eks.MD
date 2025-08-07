eks


# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl


eksctl create cluster --name=anubhav-eks --region=us-east-1 --zones=us-east-1a,us-east-1b --without-nodegroup 



eksctl create nodegroup --cluster=anubhav-eks --region=us-east-1 --name=anubhav-eks-ng-public1 --node-type=t2.medium --nodes=2 --nodes-min=1 --nodes-max=3 --node-volume-size=30 --ssh-access --ssh-public-key=anubhavself --managed --asg-access --external-dns-access --full-ecr-access --appmesh-access --alb-ingress-access --spot


kubectl get nodes


aws eks update-kubeconfig --region us-east-2 --name anubhav-eks

kubectl get pod

kubectl run Anubhav --image=nginx


kubectl run -it --image=busybox -- /bin/sh

eksctl delete nodegroup --cluster anubhav-eks --region us-east-2 --name eksvilas-ng-public1 

eksctl delete cluster --name=anubhav-eks --region=us-east-2 






