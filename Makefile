PROM_OPERATOR_NAMESPACE?=airflow

SRC_DIR=src

deploy:
	kubectl apply -f $(SRC_DIR)/namespace.yaml
	kubectl apply -R -f $(SRC_DIR)/mysql
	kubectl apply -R -f $(SRC_DIR)/redis
	kubectl apply -R -f $(SRC_DIR)/airflow
	kubectl apply -R -f $(SRC_DIR)/flower
	kubectl apply -R -f $(SRC_DIR)/celery

	cat $(SRC_DIR)/prometheus-operator/bundle.yaml | sed 's/namespace: default/namespace: $(PROM_OPERATOR_NAMESPACE)/g' | kubectl apply -f -

