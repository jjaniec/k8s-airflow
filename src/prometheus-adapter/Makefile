
KUBECTL = kubectl
NAMESPACE = airflow
KUBECTL_OPT = # -n $(namespace)
SERVING_CERTS_SECRET = adapter-serving-certs.secret.yaml
SRC_FILES =	custom-metrics-apiserver-auth-delegator-cluster-role-binding.yaml \
			custom-metrics-apiserver-auth-reader-role-binding.yaml \
			custom-metrics-apiserver-deployment.yaml \
			custom-metrics-apiserver-resource-reader-cluster-role-binding.yaml \
			custom-metrics-apiserver-service-account.yaml \
			custom-metrics-apiserver-service.yaml \
			custom-metrics-apiservice.yaml \
			custom-metrics-cluster-role.yaml \
			custom-metrics-config-map.yaml \
			custom-metrics-resource-reader-cluster-role.yaml \
			hpa-custom-metrics-cluster-role-binding.yaml

PURPOSE=metrics

all: certs prometheus-adapter

certs: $(SERVING_CERTS_SECRET)

$(SERVING_CERTS_SECRET):
	./gencerts.sh

prometheus-adapter: $(SERVING_CERTS_SECRET) $(SRC_FILES)
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} apply ${KUBECTL_OPT} -f $${s}; done;

clean:
	rm -rf certs $(PURPOSE)-ca-config.json $(PURPOSE)-ca.crt $(PURPOSE)-ca.key apiserver-key.pem apiserver.csr apiserver.pem

fclean: clean
	@SRC_FILES="$(SRC_FILES)"
	@KUBECTL=$(KUBECTL)
	@KUBECTL_OPT="$(KUBECTL_OPT)"
	@for s in ${SRC_FILES}; do ${KUBECTL} delete ${KUBECTL_OPT} -f $${s}; done;


# PURPOSE:=custom-metrics
# SERVICE_NAME:=custom-metrics-apiserver
# ALT_NAMES:="custom-metrics-apiserver.custom-metrics","custom-metrics-apiserver.custom-metrics.svc"

# certs:
# 	@echo Generating TLS certs
# 	echo "PWD:"${PWD}
# 	docker pull cfssl/cfssl
# 	mkdir -p certs
# 	touch certs/apiserver.pem
# 	touch certs/apiserver-key.pem
# 	openssl req -x509 -sha256 -new -nodes -days 365 -newkey rsa:2048 -keyout $(PURPOSE)-ca.key -out $(PURPOSE)-ca.crt -subj "/CN=ca"
# 	echo '{"signing":{"default":{"expiry":"43800h","usages":["signing","key encipherment","'$(PURPOSE)'"]}}}' > "$(PURPOSE)-ca-config.json"
# 	# echo '{"CN":"'$(SERVICE_NAME)'","hosts":[$(ALT_NAMES)],"key":{"algo":"rsa","size":2048}}' | \
# 	# 	cfssl gencert -ca=$(PURPOSE)-ca.crt -ca-key=$(PURPOSE)-ca.key -config=$(PURPOSE)-ca-config.json - | \
# 	# 	cfssljson -bare certs/apiserver
# 	# rm $(PURPOSE)-ca-config.json
# 	echo '{"CN":"'$(SERVICE_NAME)'","hosts":[$(ALT_NAMES)],"key":{"algo":"rsa","size":2048}}' | \
# 		docker run \
# 			-v ${HOME}:${HOME} \
# 			-v ${PWD}/metrics-ca.key:/go/src/github.com/cloudflare/cfssl/metrics-ca.key \
# 			-v ${PWD}/metrics-ca.crt:/go/src/github.com/cloudflare/cfssl/metrics-ca.crt \
# 			-v ${PWD}/metrics-ca-config.json:/go/src/github.com/cloudflare/cfssl/metrics-ca-config.json \
# 			-i \
# 			cfssl/cfssl gencert -ca=metrics-ca.crt -ca-key=metrics-ca.key -config=metrics-ca-config.json - | \
# 		docker run \
# 			--entrypoint=cfssljson \
# 			-v ${HOME}:${HOME} \
# 			-v ${PWD}/certs:/go/src/github.com/cloudflare/cfssl/certs \
# 			-i \
# 			cfssl/cfssl -bare certs/apiserver
