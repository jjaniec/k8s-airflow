PROM_OPERATOR_NAMESPACE?=airflow
KUBECTL=kubectl

NAMESPACE=airflow
KUBECTL_OPT=# -n $(NAMESPACE)

SRC_DIR=src

all: deploy

init:
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC_DIR)/airflow.ns.yaml
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC_DIR)/custom-metrics.ns.yaml
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC_DIR)/gce.sc.yaml

flannel:
	kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

airflow:
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f $(SRC_DIR)/mysql
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f $(SRC_DIR)/redis
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f $(SRC_DIR)/airflow
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f $(SRC_DIR)/flower
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f $(SRC_DIR)/celery

metrics: custom-metrics-api-certs-cm
	$(KUBECTL) apply $(KUBECTL_OPT) -f src/metrics-server/
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f src/prometheus_operator
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f src/prometheus
	@echo "Waiting for the Prometheus operators to create the TPRs/CRDs"
	# while [[ $(kubectl get prometheus; echo $?) == 1 ]]; do sleep 1; done
	$(KUBECTL) apply $(KUBECTL_OPT) -f src/prometheus-adapter
	$(KUBECTL) apply $(KUBECTL_OPT) -R -f src/grafana

custom-metrics-api-certs-cm:
	make -C src/prometheus-adapter
	# kubectl create secret generic -n custom-metrics --from-file src/prometheus-adapter/serving.key --from-file src/prometheus-adapter/serving.crt -o yaml --dry-run cm-adapter-serving-certs > src/prometheus-adapter/adapter-serving-certs.cm.yaml

cadvisor:
	make -C ./src/cadvisor all

# src/prometheus-adapter/serving.key:
# 	openssl req -x509 -sha256 -new -nodes -days 365 -newkey rsa:2048 -keyout src/prometheus-adapter/serving.key -out src/prometheus-adapter/serving.crt -subj "/CN=ca"

deploy: init flannel airflow metrics cadvisor
	$(KUBECTL) apply $(KUBECTL_OPT) -f src/ingress.yaml

clean:
	make -C src/prometheus-adapter clean

fclean: clean
	kubectl delete all --all -n airflow
	kubectl delete all --all -n custom-metrics
	make -C src/cadvisor fclean
	# rm -rf src/prometheus-adapter/serving.key src/prometheus-adapter/serving.crt

re: fclean all

tests: deploy
	echo "TODO"
