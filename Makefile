PROM_OPERATOR_NAMESPACE?=airflow
KUBECTL=kubectl

NAMESPACE=airflow
KUBECTL_OPT=# -n $(NAMESPACE)

SRC_DIR=src

all: deploy flannel

flannel:
	kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

deploy:
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC_DIR)/ns.yaml
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC_DIR)/gce.sc.yaml

	$(KUBECTL) apply $(KUBECTL_OPT) -R -f $(SRC_DIR)/mysql
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f $(SRC_DIR)/redis
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f $(SRC_DIR)/airflow
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f $(SRC_DIR)/flower
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f $(SRC_DIR)/celery

	$(KUBECTL) apply $(KUBECTL_OPT) -R -f src/prometheus_operator
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f src/prometheus
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f src/grafana

fclean:
	kubectl delete all --all -n airflow

re: fclean all

tests: deploy
	echo "TODO"
