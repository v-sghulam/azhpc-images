#!/bin/bash
set -ex

source ${COMMON_DIR}/utilities.sh

tdnf -y install pmix pmix-tools 
tdnf -y install hwloc-devel libevent-devel munge-devel

