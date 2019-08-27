KUBECTL = kubectl
NAMESPACE = airflow
KUBECTL_OPT = # -n $(namespace)
SRC_FILES =	result_backend.svc.yaml \
			deploy.yaml \
			pc.yaml


all: mysql

mysql: $(SRC_FILES)
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} apply ${KUBECTL_OPT} -f $${s}; done;

fclean:
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} delete ${KUBECTL_OPT} -f $${s}; done;
