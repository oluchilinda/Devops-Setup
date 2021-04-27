cd kubernetes/metrics
export APP_INSTANCE_NAME=flask-app-monitoring
export NAMESPACE=metrics-monitoring
kubectl create namespace "$NAMESPACE"
export GRAFANA_GENERATED_PASSWORD="$(echo -n 'your_grafana_password' | base64)"

awk 'FNR==1 {print "---"}{print}' manifest/* \
 | envsubst '$APP_INSTANCE_NAME $NAMESPACE $GRAFANA_GENERATED_PASSWORD' \
 > "${APP_INSTANCE_NAME}_manifest.yaml"

kubectl apply -f "${APP_INSTANCE_NAME}_manifest.yaml" --namespace "${NAMESPACE}"

kubectl get pods --namespace=$NAMESPACE
# kubectl patch svc "$APP_INSTANCE_NAME-grafana" \
#   --namespace "$NAMESPACE" \
#   -p '{"spec": {"type": "LoadBalancer"}}'

# kubectl get service "$APP_INSTANCE_NAME-grafana" -w

#delete all in namespace
#kubectl delete all --all -n metrics-monitoring

#kubectl port-forward --namespace ${NAMESPACE} ${APP_INSTANCE_NAME}-grafana-0 3000

# kubectl get service "$APP_INSTANCE_NAME-grafana" -w
 
