kubectl get services --namespace=kube-logging
kubectl get pods --namespace=kube-logging

echo "monitor statefulset rolling out status....."
kubectl rollout status sts/es-cluster --namespace=kube-ogging

echo "check elasticsearch cluster is functioning correctly by performing a request against the REST API."
echo " To do so To do so, first forward the local port 9200 to the port 9200 on one of the Elasticsearch \
        nodes (es-cluster-0) using kubectl port-forward:"

kubectl port-forward es-cluster-0 9200:9200 --namespace=kube-logging

# echo "curl against the REST API"
# curl http://localhost:9200/_cluster/state?pretty

echo "You can check that the rollout "

kubectl rollout status deployment/kibana --namespace=kube-logging



kubectl get pods --namespace=kube-logging

#Here we observe that our Kibana Pod is called kibana-XXXXXX.

#Forward the local port 5601 to port 5601 on this Pod:

kubectl port-forward kibana-XXXXXX 5601:5601 --namespace=kube-logging

#http://localhost:5601 Open on browser
