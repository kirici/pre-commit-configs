FROM docker.io/library/python:3.11.4-slim-bookworm AS build
ENV DEBIAN_FRONTEND="noninteractive"
WORKDIR /app
ARG VENV_PATH=/app/venv

RUN apt-get -qqy update && \
    apt-get -qqy install --no-install-recommends \
    git && \
    apt-get -qqy autoremove && \
    apt-get -qqy clean && \
    rm -rf /var/lib/apt/lists/*

RUN python -m venv "${VENV_PATH}"

RUN . "${VENV_PATH}"/bin/activate && \
    pip install --no-cache-dir --quiet --upgrade pip && \
    pip install --no-cache-dir --quiet pre-commit
#-----------------------------#
FROM docker.io/library/python:3.11.4-slim-bookworm
WORKDIR /app

ARG VENV_PATH=/app/venv
ENV PATH="${VENV_PATH}/bin:${PATH}"
COPY --from=build /usr/bin /usr/bin
COPY --from=build "${VENV_PATH}" "${VENV_PATH}"
ENV PYTHONPATH="${VENV}/lib/python3.11/site-packages"

ENTRYPOINT ["pre-commit"]