### Connecting kubernet 



kubeadm init

kubectl get node

&nbsp;	will show the node in "NotReady" status

kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

watch -n 1 kubectl get po -n kube-system

&nbsp;	wait until all pods changes to "1/1" or "2/2" "Running"

kubectl describe node | grep -i taint

&nbsp;	copy the taint 

kubectl get node 

&nbsp;	copy the name 

kubectl taint node <node name from above command> node-role.kubernetes.io/control-plane:NoSchedule-

kubectl run nginx --image=nginx

kubectl get po

kubectl get po -o wide

&nbsp;	note the ip 

curl <ip>



### ....





hostnamectl set-hostname kmaster

master - kubeadm init

kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml 

watch -n 1 kubectl get po -n kube-system

kubectl run vilaspod --image=nginx

kubectl get pod -o wide

curl <ip>



### Working with Replica set 







root@kmaster:/home/ubuntu# nano replicaset.yaml



root@kmaster:/home/ubuntu# kubectl apply -f replicaset.yaml



replicaset.apps/nginx-replicaset created



root@kmaster:/home/ubuntu# kubectl get pod



NAME                     READY   STATUS    RESTARTS   AGE

my-nginx-pod             1/1     Running   0          47m

nginx-replicaset-hkzxh   1/1     Running   0          12s

nginx-replicaset-vmshl   1/1     Running   0          12s



root@kmaster:/home/ubuntu# kubectl get replicaset

NAME               DESIRED   CURRENT   READY   AGE

nginx-replicaset   3         3         3       25s





root@kmaster:/home/ubuntu# kubectl delete po my-nginx-pod

pod "my-nginx-pod" deleted



root@kmaster:/home/ubuntu# kubectl get pods



NAME                     READY   STATUS    RESTARTS   AGE

nginx-replicaset-8pmxh   1/1     Running   0          20s

nginx-replicaset-hkzxh   1/1     Running   0          32m

nginx-replicaset-vmshl   1/1     Running   0          32m















