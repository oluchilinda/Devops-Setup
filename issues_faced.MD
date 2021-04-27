## Bug 1
```shell
an error from server (InternalError): error when creating "./kubernetes/ingress.yml": 
Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io":
 an error on the server ("") has prevented the request from succeeding
```
## Reproducing it
`kubectl apply -f ./kubernetes/ingress.yml`

#### Fix : 
`kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission`


