KUBECTL = kubectl
NAMESPACE = airflow
KUBECTL_OPT = -
SRC_FILES =	.

all: cadvisor

cadvisor:
	kustomize build $(SRC_FILES) | $(KUBECTL) apply -f $(KUBECTL_OPT)

fclean:
	kubectl delete --all -n cadvisor all
