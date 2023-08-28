#!/usr/bin/env bash
set -euxo pipefail
declare -a PROJECTS=("merged" "java-maven" "kotlin-maven" "java-gradle" "kotlin-gradle")

for index in "${!PROJECTS[@]}" ; do
  yq 'explode(.) | select(di == '"${index}"')' template.pre-commit-config.yaml | tee "${PROJECTS[${index}]}"/.pre-commit-config.yaml >/dev/null
done