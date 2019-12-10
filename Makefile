build-latest :
	set -e; \
	docker build \
	-f Dockerfile.prod \
	--build-arg RUBY_VERSION="2.6.5" \
	--build-arg PG_MAJOR="11" \
	--build-arg NODE_MAJOR="11" \
	--build-arg YARN_VERSION="1.19.1" \
	--build-arg BUNDLER_VERSION="2.0.2" \
	. \
	-t quay.io/lewagon/rails-k8s-demo:latest; \
	docker push quay.io/lewagon/rails-k8s-demo:latest;

upgrade-from-local:
	helm upgrade rails-k8s-demo charts/rails-k8s-demo --install \
	--atomic --cleanup-on-fail

# TODO: rename to build-latest-update-local ?
build-upgrade-from-local: build-latest upgrade-from-local
