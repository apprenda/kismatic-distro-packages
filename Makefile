clean:
	rm -rf source/
	rm -rf build/

source:
	./scripts/getbinaries.sh
	./scripts/getdockerimages.sh

build/rpms: source
	docker build -t kismatic/fpm -f docker/Dockerfile.fpm docker/
	mkdir -p build/rpms
	./scripts/build_rpms.sh

sign/rpms: build/rpms
	./scripts/sign_rpms.sh

build/debs: source
	docker build -t kismatic/fpm -f docker/Dockerfile.fpm docker/
	mkdir -p build/debs
	./scripts/build_debs.sh

build: source build/debs

package/debs:
	docker build -t kismatic/deb -f docker/Dockerfile.deb docker/
	./scripts/package_debs.sh

package/rpms:
	docker build -t kismatic/rpm -f docker/Dockerfile.rpm docker/
	./scripts/package_rpms.sh

package: package/debs

all: clean source build package
