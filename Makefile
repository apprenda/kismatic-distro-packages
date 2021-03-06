ifeq ($(origin VERSION), undefined)
	VERSION := $(shell git describe --tags --always)
endif

all: clean build package

clean:
	rm -rf source/
	rm -rf build/
	rm -rf gpg/

source:
	./scripts/getbinaries.sh
	./scripts/getdockerimages.sh

build/rpms: source
	mkdir -p build/rpms
	./scripts/build_rpms.sh

sign/rpms: build/rpms gpg/import
	/root/rpm-sign.exp build/rpms/*.rpm

gpg/import:
	gpg --import $(KEYS_PATH)/public.key
	gpg --import $(KEYS_PATH)/private.key
	mkdir -p gpg/import

build/debs: source
	mkdir -p build/debs
	./scripts/build_debs.sh

build: source build/rpms sign/rpms build/debs

backup/debs:
	aws s3api create-bucket --bucket kismatic-packages-deb-backup-$(VERSION) --region us-east-1
	aws --region "us-east-1" s3 sync "s3://$(DEB_REPO)" "s3://kismatic-packages-deb-backup-$(VERSION)"

backup/rpms:
	aws s3api create-bucket --bucket kismatic-packages-rpm-backup-$(VERSION) --region us-east-1
	aws --region "us-east-1" s3 sync "s3://$(RPM_REPO)" "s3://kismatic-packages-rpm-backup-$(VERSION)"

package/debs: gpg/import
	cp /root/publish_debs.sh scripts/publish_debs.sh
	./scripts/publish_debs.sh -s build/debs/ -t $(DEB_REPO)

package/rpms:
	cp /root/publish_rpms.sh scripts/publish_rpms.sh
	./scripts/publish_rpms.sh -s build/rpms/ -t $(RPM_REPO)

package: package/debs package/rpms

docker-images:
	docker build -t apprenda/kismatic-fpm -f docker/Dockerfile.fpm docker/
	docker tag apprenda/kismatic-fpm apprenda/kismatic-fpm:v0.1

docker-push: docker-images
	docker push apprenda/kismatic-fpm:v0.1