

################################
####    	kubectl
################################

kubectl get 		# list resources
kubectl describe 	# show detailed information about a resource
kubectl logs 	 	# print the logs from a container in a pod
kubectl exec 		# execute a command on a container in a pod


## Examples
kubectl get pods
kubectl describe pods



################################
##		 Tutorial from:  https://kubernetes.io/docs/tutorials/kubernetes-basics/
################################

## Get pod name
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME
## verify
curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/
## Execute a commong on the container. The name of the container itself can be omitted since we only have a single container in the Pod.
kubectl exec $POD_NAME env
## Start a bash session in the Pod’s container:
kubectl exec -ti $POD_NAME bash



# A Service in Kubernetes is an abstraction which defines a logical set of Pods and a policy by which to access them

## Module 4 - Expose your app publicly

## List the current Services from our cluster:
kubectl get services
## expose
kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
## Verify with:
kubectl get services

kubectl describe services/kubernetes-bootcamp

export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT

## Test it
curl $(minikube ip):$NODE_PORT



## Scaliing the app
kubectl scale deployments/kubernetes-bootcamp --replicas=4

## Verify 
kubectl get deployments
## Check nr of instances 
kubectl get pods -o wide
## The change was registered in the Deployment events log. To check that, use the describe command:
kubectl describe deployments/kubernetes-bootcamp
## To find out the exposed IP and Port we can use the describe service as we learned in the previously Module:
kubectl describe services/kubernetes-bootcamp





