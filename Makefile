SHELL = /bin/sh

#================================================================
# Usage
#================================================================
# make deps       # install Python deps (requirements.txt) + Galaxy deps (requirements.yml)
# make install    # create & prepare Docker containers (node1, node2)
# make run        # run playbooks/site.yml against inventories/dev
# make plan       # dry-run (check mode)
# make clean      # remove containers

#=======================================================================
# Variables
#=======================================================================
.EXPORT_ALL_VARIABLES:

# Load colours/messages and any shared vars
include src/make/variables.mk

#=======================================================================
# Targets
#=======================================================================
all: deps install

deps:
	@[ ! -f requirements.txt ] || pip install -r requirements.txt
	@[ ! -f requirements.yml ] || ansible-galaxy install -r requirements.yml

install:
	@echo "${INFO}\nCalled makefile target 'install'. Completed sandbox setup.\n${COLOUR_OFF}"
	@echo "${INFO}Create & prepare Docker nodes (node1, node2) using Ubuntu.${COLOUR_OFF}"
	@bash src/sh/create_docker_containers.sh

run:
	@echo "${INFO}\nCalled makefile target 'run'. Launch Ansible playbook.${COLOUR_OFF}\n"
	@ansible-playbook -i inventories/dev/inventory.ini playbooks/site.yml

plan:
	@echo "${INFO}\nCalled makefile target 'plan'. Dry-run (check mode).${COLOUR_OFF}\n"
	@ansible-playbook -i inventories/dev/inventory.ini playbooks/site.yml --check

clean:
	@echo "${INFO}\nCalled makefile target 'clean'. Restoring the repository to its initial state.${COLOUR_OFF}\n"
	@bash src/sh/destroy_docker_containers.sh || true

.PHONY: all deps install run plan clean
