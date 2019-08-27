KUBECTL = kubectl
NAMESPACE = custom-metrics
KUBECTL_OPT = # -n $(namespace)
SRC_FILES =	aggregated-metrics-reader.yaml \
			auth-delegator.yaml \
			auth-reader.yaml \
			metrics-apiservice.yaml \
			metrics-server-deployment.yaml \
			metrics-server-service.yaml \
			resource-reader.yaml


all: metrics-server

metrics-server: $(SRC_FILES)
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} apply ${KUBECTL_OPT} -f $${s}; done;

fclean:
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} delete ${KUBECTL_OPT} -f $${s}; done;
