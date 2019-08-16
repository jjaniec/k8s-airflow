all: cadvisor

ns:
	kubectl apply -f ./ns.yaml

cadvisor: ns
	kustomize build . | kubectl apply -f -

fclean:
	kubectl delete --all -n cadvisor all
