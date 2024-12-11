.PHONY: run minikuibe-init minikube-deploy minikube-reset

run:
	python app.py

minikube-init:
	@#Ensure docker image will be pushed to minikube
	@minikube start --kubernetes-version=v1.27.0
	@minikube addons enable ingress
	minikube status

minikube-deploy: minikube-init
	@eval $$(minikube -p minikube docker-env) && docker pull registry.k8s.io/git-sync/git-sync:v4.2.3
	@eval $$(minikube -p minikube docker-env) && docker build -t flask-app:latest .
	kubectl apply -f k8s/pvc.yaml
	kubectl apply -f k8s/deployment.yaml
	kubectl apply -f k8s/ingress-nginx.yaml

minikube-reset:
	minikube delete
