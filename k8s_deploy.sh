#!/bin/bash
echo "start minikube"
minikube start --driver=hyperkit

echo "Adding the ingress..."
minikube addons enable ingress
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

echo "Creating the volume..."

kubectl apply -f ./kubernetes/postgres-persistent-vol.yml

echo "Creating the database credentials..."

kubectl apply -f ./kubernetes/secret.yml

echo "Creating the postgres deployment and service..."

kubectl create -f ./kubernetes/postgres-deployment.yml

echo "Creating the flask deployment and service..."

kubectl create -f ./kubernetes/flask-deployment.yml

echo "Adding the ingress..."

minikube addons enable ingress
kubectl apply -f ./kubernetes/ingress.yml


echo "Creating the vue deployment and service..."

kubectl create -f ./kubernetes/vue-deployment.yml

echo "setting up elastic-Fluentd-stack....."

kubectl create -f ./kubernetes/elastic_fluentd_kibana/kube-logging.yml
kubectl create -f ./kubernetes/elastic_fluentd_kibana/elastic_search_service.yml 
kubectl create -f ./kubernetes/elastic_fluentd_kibana/elastic_search_statefulset.yaml
kubectl create -f ./kubernetes/elastic_fluentd_kibana/kibana_deployment.yml 
kubectl create -f ./kubernetes/elastic_fluentd_kibana/fluentd.yaml


# echo " Creating Nginx deployment..."
# kubectl apply -f ./kubernetes/nginx-deployment.yaml  
# echo "Describe Nginx deployment"
# kubectl describe deployment nginx-deployment
# echo "List the Pods created by the deployment"
# kubectl get pods -l app=nginx

# kubectl describe pod nginx-deployment-7f4b6df69f-8mpbq 

#kubectl exec -it nginx-deployment-7f4b6df69f-8mpbq  -- /bin/bash
