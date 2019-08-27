KUBECTL = kubectl
NAMESPACE = airflow
KUBECTL_OPT = # -n $(namespace)
SRC_FILES =	sa.yaml \
			airflow.service_monitor.yaml \
			cadvisor.service_monitor.yaml \
			clusterrole.yaml \
			clusterrolebinding.yaml \
			deploy.yaml \
			svc.yaml


all: prometheus-operator

prometheus-operator: $(SRC_FILES)
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} apply ${KUBECTL_OPT} -f $${s}; done;

fclean:
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} delete ${KUBECTL_OPT} -f $${s}; done;
