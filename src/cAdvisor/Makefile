all: cadvisor

cadvisor:
	kustomize build . | kubectl apply -f -

fclean:
	kubectl delete --all -n cadvisor
