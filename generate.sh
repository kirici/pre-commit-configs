#!/usr/bin/env bash

yq 'explode(.) | select(di == 1)' template.pre-commit-config.yaml | tee .pre-commit-config.yaml >/dev/null
