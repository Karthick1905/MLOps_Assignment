.PHONY: test docker-build helm-lint helm-template minikube-deploy helm-test

test:
	cd app && python -m pytest -q

docker-build:
	docker build -t ml-api:local ./app

helm-lint:
	helm lint ./helm/ml-api

helm-template:
	helm template ml-api ./helm/ml-api -f ./helm/ml-api/values-dev.yaml

minikube-deploy:
	bash ./scripts/minikube_deploy.sh

helm-test:
	helm test ml-api -n ml-api-dev
