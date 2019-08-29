SHELL := /bin/bash

PROM_OPERATOR_NAMESPACE?=airflow
KUBECTL=kubectl

NAMESPACE=airflow
KUBECTL_OPT=# -n $(NAMESPACE)

SRC=src

SRC_SUBDIRS =	airflow \
				cadvisor \
				celery \
				flower \
				grafana \
				mysql \
				prometheus \
				prometheus-operator \
				prometheus-adapter \
				redis \
				metrics-server


all: init flannel $(SRC_SUBDIRS)

init:
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC)/airflow.ns.yaml
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC)/custom-metrics.ns.yaml
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC)/cadvisor.ns.yaml
	$(KUBECTL) apply $(KUBECTL_OPT) -f $(SRC)/gce.sc.yaml

flannel:
	kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

airflow: mysql redis
	make -C $(SRC)/airflow

cadvisor:
	make -C $(SRC)/cAdvisor

celery: mysql redis
	make -C $(SRC)/celery

flower: airflow mysql redis celery
	make -C $(SRC)/flower

grafana: prometheus
	make -C $(SRC)/grafana

metrics-server:
	make -C $(SRC)/metrics-server

mysql:
	make -C $(SRC)/mysql

prometheus: prometheus-operator
	make -C $(SRC)/prometheus

prometheus-operator:
	make -C $(SRC)/prometheus-operator
	@echo "Waiting for the Prometheus operators to create the TPRs/CRDs"
	while [[ $$(kubectl get prometheus; echo $$?) == 1 ]]; do sleep 1; done

prometheus-adapter: prometheus-operator prometheus metrics-server
	make -C $(SRC)/prometheus-adapter

redis:
	make -C $(SRC)/redis

clean:
	make -C $(SRC)/prometheus-adapter clean

# for dir in prometheus-adapter;
# do
# 	make -C src/$${dir} clean
# done;

fclean:
	@SRC_SUBDIRS="$(SRC_SUBDIRS)"
	@SRC=$(SRC)
	for d in ${SRC_SUBDIRS}; do echo $${d}; make -C ${SRC}/$${d} fclean; done;

	$(KUBECTL) delete all --all -n custom-metrics
	$(KUBECTL) delete $(KUBECTL_OPT) -f $(SRC)/custom-metrics.ns.yaml

	$(KUBECTL) delete all --all -n airflow
	$(KUBECTL) delete $(KUBECTL_OPT) -f $(SRC)/airflow.ns.yaml

	$(KUBECTL) delete all --all -n cadvisor
	$(KUBECTL) delete $(KUBECTL_OPT) -f $(SRC)/cadvisor.ns.yaml

	$(KUBECTL) delete $(KUBECTL_OPT) -f $(SRC)/gce.sc.yaml

re: fclean all

tests: all
	echo "TODO"
