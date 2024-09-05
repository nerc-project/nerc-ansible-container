#!/bin/bash
set -e
/srv/docker-ansible/env/bin/ansible-lint --exclude ${HOME}/.ansible/roles/ $@
