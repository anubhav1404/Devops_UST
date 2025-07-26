### \# Delete deployments

kubectl delete deployment postgres-deployment

kubectl delete deployment web-app-deployment



### \# Delete services

kubectl delete service postgres-service

kubectl delete service web-app-service

### 



##### root@kmaster:/home/ubuntu# kubectl rollout history deployment/nginx-deployment

deployment.apps/nginx-deployment

REVISION  CHANGE-CAUSE

0         <none>

\# It's shown only if the rollout history is empty or has no complete ReplicaSet for that revision.

2         <none>

3         <none> 

The first rollout didn’t generate a complete ReplicaSet.



You deleted and re-created the Deployment, skipping revision 1 internally.



Or revision 1 was garbage collected if old replicaset history was cleaned up (default max history is 10).

##### 

##### root@kmaster:/home/ubuntu# kubectl rollout history deployment/nginx-deployment --revision=2

##### deployment.apps/nginx-deployment with revision #2

Pod Template:

  Labels:       app=nginx

        pod-template-hash=8cf4bf97

  Containers:

   nginx:

    Image:      nginx:1.22

    Port:       80/TCP

    Host Port:  0/TCP

    Environment:        <none>

    Mounts:     <none>

  Volumes:      <none>



##### root@kmaster:/home/ubuntu# kubectl rollout history deployment/nginx-deployment --revision=3

##### deployment.apps/nginx-deployment with revision #3

Pod Template:

  Labels:       app=nginx

        pod-template-hash=f5d9744f

  Containers:

   nginx:

    Image:      nginx:1.9.1

    Port:       80/TCP

    Host Port:  0/TCP

    Environment:        <none>

    Mounts:     <none>

  Volumes:      <none>

