#!/usr/bin/make -f

S3_REPO_PREFIX = alfred

helm-lint-charts:
	cd helm/ && helm lint *

helm-dry-run-charts:
	cd helm/ && helm  install  --dry-run --debug data-hub  --namespace data-hub

push-charts-to-s3-repo: helm-lint-charts
	cd helm && rm -f *.tgz
	cd helm/*/ && helm dependency update .
	cd helm && helm package $$(ls -d */)
	cd helm && for p in $$(ls *.tgz); do helm s3 push $$p $(S3_REPO_PREFIX) --force; done
