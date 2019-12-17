build-latest:
	set -e; \
	docker build \
	-f Dockerfile.prod \
	--build-arg RUBY_VERSION="2.6.5" \
	--build-arg PG_MAJOR="11" \
	--build-arg NODE_MAJOR="11" \
	--build-arg YARN_VERSION="1.19.1" \
	--build-arg BUNDLER_VERSION="2.1.0" \
	. \
	-t quay.io/lewagon/rails-k8s-demo:latest;

push-latest:
	docker push quay.io/lewagon/rails-k8s-demo:latest

build-push-latest: build-latest push-latest

# DO_POSTGRES_URL needs to be set to the connection string in the shell
upgrade-dev:
	helm upgrade rails-k8s-demo charts/rails-k8s-demo --install \
	--atomic --cleanup-on-fail --timeout=3m0s \
	--set-string dbConnectionString=$(DO_POSTGRES_URL)

build-push-latest-upgrade-dev: build-push-latest upgrade-dev
