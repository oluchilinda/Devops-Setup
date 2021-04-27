echo "deleting the volume..."

kubectl delete -f ./kubernetes/postgres-persistent-vol.yml

echo "deleting the database credentials..."

kubectl delete -f ./kubernetes/secret.yml

echo "deleting the postgres deployment and service..."

kubectl delete -f ./kubernetes/postgres-deployment.yml

echo "deleting the flask deployment and service..."

kubectl delete -f ./kubernetes/flask-deployment.yml


kubectl delete -f ./kubernetes/ingress.yml

echo "deleting the vue deployment and service..."

kubectl delete -f ./kubernetes/vue-deployment.yml

echo "deleting EFK deployment"

kubectl delete -f ./kubernetes/elastic_fluentd_kibana/logging.yml
kubectl delete -f ./kubernetes/elastic_fluentd_kibana/elastic_search_service.yml 
kubectl delete -f ./kubernetes/elastic_fluentd_kibana/elastic_search_statefulset.yaml
kubectl delete -f ./kubernetes/elastic_fluentd_kibana/kibana_deployment.yml 