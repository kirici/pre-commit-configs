FROM docker.io/library/python:3.11.4-slim-bookworm AS build

RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends \
    build-essential \
    gcc \
    &>/dev/null

WORKDIR /usr/app
RUN python -m venv /usr/app/venv
ENV PATH="/usr/app/venv/bin:$PATH"
COPY requirements.txt .
RUN pip install -r requirements.txt

#-----------------------------#
FROM docker.io/library/python:3.11.4-slim-bookworm
WORKDIR /usr/app/venv
COPY --from=build /usr/app/venv ./venv
ENV PATH="/usr/app/venv/bin:$PATH"
COPY . .

ENTRYPOINT ["pre-commit"]