
install-local: 
	helm install --create-namespace -n nidhogg nidhogg ./nidhogg --values ./env/local/nidhogg.yaml --set nidhogg.yggdrasil.targetRevision=$(shell git rev-parse --abbrev-ref HEAD)

uninstall-local: 
	helm uninstall -n nidhogg nidhogg
