#!/bin/bash
set -ex

source ${COMMON_DIR}/utilities.sh

# Install gdrcopy
gdrcopy_metadata=$(get_component_config "gdrcopy")
GDRCOPY_VERSION=$(jq -r '.version' <<< $gdrcopy_metadata)
GDRCOPY_SHA256=$(jq -r '.sha256' <<< $gdrcopy_metadata)
GDRCOPY_DISTRIBUTION=$(jq -r '.distribution' <<< $gdrcopy_metadata)


tdnf install -y <pcakage-url>  gdrcopy-2.5-1.azl3.x86_64.rpm
tdnf install -y <pcakage-url>  gdrcopy-kmod-6.6.51.1-5.azl3-560.35.03-2.5-1.azl3.x86_64.rpm
tdnf install -y <pcakage-url>  prebuilt/gdrcopy-devel-2.5-1.azl3.noarch.rpm

$COMMON_DIR/write_component_version.sh "GDRCOPY" ${GDRCOPY_VERSION}
