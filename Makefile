PROM_OPERATOR_NAMESPACE?=airflow
KUBECTL=kubectl

SRC_DIR=src

all: deploy flannel

flannel:
	kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

deploy:
	$(KUBECTL) apply -f $(SRC_DIR)/ns.yaml
	$(KUBECTL) apply -f $(SRC_DIR)/gce.sc.yaml

	$(KUBECTL) apply -R -f $(SRC_DIR)/mysql
	$(KUBECTL) apply -R -f $(SRC_DIR)/redis
	$(KUBECTL) apply -R -f $(SRC_DIR)/airflow
	$(KUBECTL) apply -R -f $(SRC_DIR)/flower
	$(KUBECTL) apply -R -f $(SRC_DIR)/celery

	$(KUBECTL) apply -R -f src/prometheus_operator
	$(KUBECTL) apply -R -f src/prometheus
	$(KUBECTL) apply -R -f src/grafana

fclean:
	kubectl delete all --all -n airflow

re: fclean all

tests: deploy
	echo "TODO"
