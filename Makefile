SHELL := /bin/bash
BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
IMAGE_TAG=git-$(subst /,-,$(BRANCH))-$(shell git describe --always --dirty)
# 自动获取项目名称
REPO_NAME=$(shell basename $(shell git rev-parse --show-toplevel)|tr A-Z a-z)
# 外网仓库地址
IAMGE_REPO=d-x.cmstop.net

push:
	pnpm build
	docker build -t ${IAMGE_REPO}/${REPO_NAME}:${IMAGE_TAG} .
	docker push ${IAMGE_REPO}/${REPO_NAME}:${IMAGE_TAG}
	docker rmi ${IAMGE_REPO}/${REPO_NAME}:${IMAGE_TAG}