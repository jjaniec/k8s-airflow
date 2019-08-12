all: cadvisor service_monitor

service_monitor:
	kubectl apply -f ./service_monitor.yaml

ns:
	kubectl apply -f ./ns.yaml

cadvisor: ns
	kustomize build . | kubectl apply -f -

fclean:
	kubectl delete --all -n cadvisor all
