KUBECTL = kubectl
NAMESPACE = airflow
KUBECTL_OPT = # -n $(namespace)
SRC_FILES =	sa.yaml \
			clusterrole.yaml \
			clusterrolebinding.yaml \
			svc.yaml \
			prometheus.yaml


all: prometheus

prometheus: $(SRC_FILES)
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} apply ${KUBECTL_OPT} -f $${s}; done;

fclean:
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} delete ${KUBECTL_OPT} -f $${s}; done;
