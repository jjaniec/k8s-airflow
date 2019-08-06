# k8s-airflow (Celery Executor)

![https://miro.medium.com/max/2000/1*avBjYUY6ZtfEyTkk7FI8JQ.png](https://miro.medium.com/max/2000/1*avBjYUY6ZtfEyTkk7FI8JQ.png)

### prometheus-operator

[https://github.com/coreos/prometheus-operator](https://github.com/coreos/prometheus-operator)

![https://github.com/coreos/prometheus-operator](https://github.com/coreos/prometheus-operator/raw/master/Documentation/user-guides/images/architecture.png)

### prometheus-adapter

![](https://blog.octo.com/wp-content/uploads/2018/03/s8j8e80wemhu4po9y0ofyva.png)

### airflow-exporter

[https://github.com/epoch8/airflow-exporter](https://github.com/epoch8/airflow-exporter)

### Notes

By default, scaling in of celery by the hpa will take 5 minutes, if you want to speed up the process and have a faster scaling in of the workers, see [hpa-support-for-cooldown-delay](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-cooldown-delay)

### Documentation / Useful links

- [https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/)

- [https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-metrics-apis](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-metrics-apis)

- [https://github.com/DirectXMan12/k8s-prometheus-adapter/blob/master/docs/config.md](https://github.com/DirectXMan12/k8s-prometheus-adapter/blob/master/docs/config.md)

- [https://stefanprodan.com/2018/kubernetes-horizontal-pod-autoscaler-prometheus-metrics/](https://stefanprodan.com/2018/kubernetes-horizontal-pod-autoscaler-prometheus-metrics/)
