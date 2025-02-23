# Copyright 2015 The Prometheus Authors
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Needs to be defined before including Makefile.common to auto-generate targets
DOCKER_ARCHS ?= amd64 armv7 arm64 ppc64le s390x
DOCKER_IMAGE_NAME ?= zfs-exporter

.PHONY: all
all:: test build

.PHONY: test
test:: vet precheck style lint unused common-test

include Makefile.common

PROMTOOL_DOCKER_IMAGE ?= $(shell docker pull -q quay.io/prometheus/prometheus:latest || echo quay.io/prometheus/prometheus:latest)
PROMTOOL ?= docker run -i --rm -w "$(PWD)" -v "$(PWD):$(PWD)" --entrypoint promtool $(PROMTOOL_DOCKER_IMAGE)
