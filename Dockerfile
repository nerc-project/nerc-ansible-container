# Builder Image

FROM python:3.10-slim-bullseye as builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libffi-dev && \
    apt-get clean -y

RUN mkdir -p /srv/docker-ansible

COPY requirements.txt /srv/docker-ansible/requirements.txt

RUN python3 -m venv /srv/docker-ansible/env && \
  /srv/docker-ansible/env/bin/pip install -r /srv/docker-ansible/requirements.txt

# Final Image

FROM python:3.10-slim-bullseye

MAINTAINER New England Research Cloud (NERC) "https://nerc.mghpcc.org"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ssh \
      git \
    && apt-get clean -y

COPY --from=builder /srv/docker-ansible /srv/docker-ansible

COPY lint.sh /srv/docker-ansible/env/bin/lint.sh

ENTRYPOINT []

CMD ["/srv/docker-ansible/env/bin/ansible-playbook"]
