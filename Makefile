PROM_OPERATOR_NAMESPACE?=airflow
KUBECTL=kubectl

NAMESPACE=airflow
KUBECTL_OPT=# -n $(NAMESPACE)

SRC_DIR=src

all: \
	init \
	flannel \
	airflow \
	cadvisor \
	celery \
	flower \
	grafana \
	metrics-server \
	mysql \
	prometheus \
	prometheus-operator \
	prometheus-adapter \
	redis

init:
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC_DIR)/airflow.ns.yaml
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC_DIR)/custom-metrics.ns.yaml
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC_DIR)/cadvisor.ns.yaml
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC_DIR)/gce.sc.yaml

flannel:
	kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

airflow: mysql redis
	make -C src/airflow

cadvisor:
	make -C src/cAdvisor

celery: mysql redis
	make -C src/celery

flower: airflow mysql redis celery
	make -C src/flower

grafana: prometheus
	make -C src/grafana

metrics-server: prometheus-operator prometheus-adapter prometheus
	make -C src/metrics-server

mysql:
	make -C src/mysql

prometheus:
	make -C src/prometheus

prometheus-operator:
	make -C src/prometheus-operator
	@echo "Waiting for the Prometheus operators to create the TPRs/CRDs"
	while [[ $$(kubectl get prometheus; echo $$?) == 1 ]]; do sleep 1; done

prometheus-adapter:
	make -C src/prometheus-adapter

redis:
	make -C src/redis

clean:
	make -C src/prometheus-adapter clean
	@# for dir in prometheus-adapter;
	@# do
	@# 	make -C src/$${dir} clean
	@# done;

fclean: clean
	for dir in airflow cadvisor celery flower grafana metrics-server mysql prometheus prometheus-operator prometheus-adapter redis;
	do
		make -C src/$${dir} fclean
	done;
	for dir in airflow cadvisor custom-metrics;
	do
		kubectl delete -f src/$${dir}
	done;

re: fclean all

tests: all
	echo "TODO"
