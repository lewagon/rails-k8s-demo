latest_sha := $(shell git rev-parse --verify --short HEAD)
rails_master_key := ""
db_connection_string := ""

ci-deploy:
	echo "Upgrading/installing release to specified Digital Ocean cluster"
	helm upgrade glovebox charts/glovebox --install \
	--atomic --cleanup-on-fail \
	--set-string image.tag=$(latest_sha) \
	--set-string railsMasterKey=$(rails_master_key)
	--set-string dbConnectionString=$(db_connection_string)

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
