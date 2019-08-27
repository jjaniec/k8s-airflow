KUBECTL = kubectl
NAMESPACE = airflow
KUBECTL_OPT = # -n $(namespace)
SRC_FILES =	airflow.dashboard.cm.yaml \
			dashboards.cm.yaml \
			datasources.cm.yaml \
			deploy.yaml \
			svc.yaml

all: grafana

grafana: $(SRC_FILES)
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} apply ${KUBECTL_OPT} -f $${s}; done;

fclean:
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} delete ${KUBECTL_OPT} -f $${s}; done;
