project_name :=  rails-k8s-demo
image_name := quay.io/lewagon/$(project_name)
latest_sha := $(shell git rev-parse --verify --short HEAD)
rails_master_key := ""
db_connection_string := ""

ci-deploy:
	echo "Upgrading/installing release to specified Digital Ocean cluster"
	helm upgrade $(project_name) helm --install \
	--atomic --cleanup-on-fail \
	--set-string image.tag=$(latest_sha) \
	--set-string dbConnectionString=$(db_connection_string)

build-sha-cached:
	set -e; \
	DOCKER_BUILDKIT=1 \
	docker build \
	-f Dockerfile.prod \
	--build-arg RUBY_VERSION="2.6.5" \
	--build-arg PG_MAJOR="11" \
	--build-arg NODE_MAJOR="11" \
	--build-arg YARN_VERSION="1.22.4" \
	--build-arg BUNDLER_VERSION="2.1.0" \
	--cache-from $(image_name):latest \
	. \
	-t $(image_name):$(latest_sha);

build-latest:
	set -e; \
	DOCKER_BUILDKIT=1 \
	docker build \
	-f Dockerfile.prod \
	--build-arg RUBY_VERSION="2.6.5" \
	--build-arg PG_MAJOR="11" \
	--build-arg NODE_MAJOR="11" \
	--build-arg YARN_VERSION="1.22.4" \
	--build-arg BUNDLER_VERSION="2.1.0" \
	. \
	-t $(image_name):latest;

push-latest:
	docker push $(image_name):latest

push-sha:
	docker push $(image_name):$(latest_sha)

build-push-latest: build-latest push-latest

build-ci: build-sha-cached push-sha

# DO_POSTGRES_URL needs to be set to the connection string in the shell
upgrade-dev:
	helm upgrade $(project_name) helm --install \
	--atomic --cleanup-on-fail --timeout=3m0s \
	--set-string dbConnectionString=$(DO_POSTGRES_URL)

build-push-latest-upgrade-dev: build-push-latest upgrade-dev
