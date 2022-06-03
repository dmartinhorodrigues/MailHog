VERSION=1.2.1

all: fmt combined

combined:
	go install .

release: tag release-deps
	gox -ldflags "-X main.version=${VERSION}" -output="build/{{.Dir}}_{{.OS}}_{{.Arch}}" .

fmt:
	go fmt ./...

release-deps:
	go get github.com/mitchellh/gox

pull:
	git pull
	cd ./vendor/github.com/mailhog/data; git pull
	cd ./vendor/github.com/mailhog/http; git pull
	cd ./vendor/github.com/mailhog/MailHog-Server; git pull
	cd ./vendor/github.com/mailhog/MailHog-UI; git pull
	cd ./vendor/github.com/mailhog/smtp; git pull
	cd ./vendor/github.com/mailhog/storage; git pull

tag:
	git tag -a -m 'v${VERSION}' v${VERSION} && git push origin v${VERSION}
	cd ./vendor/github.com/mailhog/data; git tag -a -m 'v${VERSION}' v${VERSION} && git push origin v${VERSION}
	cd ./vendor/github.com/mailhog/http; git tag -a -m 'v${VERSION}' v${VERSION} && git push origin v${VERSION}
	cd ./vendor/github.com/mailhog/MailHog-Server; git tag -a -m 'v${VERSION}' v${VERSION} && git push origin v${VERSION}
	cd ./vendor/github.com/mailhog/MailHog-UI; git tag -a -m 'v${VERSION}' v${VERSION} && git push origin v${VERSION}
	cd ./vendor/github.com/mailhog/smtp; git tag -a -m 'v${VERSION}' v${VERSION} && git push origin v${VERSION}
	cd ./vendor/github.com/mailhog/storage; git tag -a -m 'v${VERSION}' v${VERSION} && git push origin v${VERSION}

.PHONY: all combined release fmt release-deps pull tag
