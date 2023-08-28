#!/usr/bin/env bash

yq 'explode(.) | select(di == 1)' template.pre-commit-config.yaml | tee java-maven/.pre-commit-config.yaml >/dev/null
yq 'explode(.) | select(di == 2)' template.pre-commit-config.yaml | tee kotlin-maven/.pre-commit-config.yaml >/dev/null
# yq 'explode(.) | select(di == 3)' template.pre-commit-config.yaml | tee java-gradle/.pre-commit-config.yaml >/dev/null
# yq 'explode(.) | select(di == 4)' template.pre-commit-config.yaml | tee kotlin-gradle/.pre-commit-config.yaml >/dev/null