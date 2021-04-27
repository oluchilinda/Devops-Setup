echo "$(minikube ip) note.app" | sudo tee -a /etc/hosts
http GET http://note.app/home/
http POST http://note.app/v1/notes/   title="First day in Nairobi" notes="A visit to Yaba"
http POST http://note.app/v1/notes/   title="First day in Nairobi"  notes="I  love Nairobi, it is so beautiful"