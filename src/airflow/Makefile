KUBECTL = kubectl
NAMESPACE = airflow
KUBECTL_OPT = # -n $(namespace)
SRC_FILES =	airflow-auth.secret.yaml \
			airflow-celery-env.cm.yaml \
			airflow-celery-env.secret.yaml \
			cfg.cm.yaml \
			clusterrole.yaml \
			clusterrolebinding.yaml \
			deploy.yaml \
			git-sync.secret.yaml \
			pc.yaml \
			sa.yaml \
			svc.yaml

all: airflow

airflow: $(SRC_FILES)
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} apply ${KUBECTL_OPT} -f $${s}; done;

fclean: clean
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} delete ${KUBECTL_OPT} -f $${s}; done;
