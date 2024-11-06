#!/bin/bash
set -ex

source ${COMMON_DIR}/utilities.sh

# Packages for MOFED
tdnf install -y iptables-devel \
    libdb-devel \
    libmnl-devel \
    libgudev \
    fuse-devel \
    libgudev-devel \
    pciutils-devel \
    libusb \
    openssl-devel \
    libusb-devel \
    flex \
    lsof \
    automake \
    autoconf


# TEMP
tdnf install -y bison \
    cmake

# mofed_metadata=$(get_component_config "mofed")
# MOFED_VERSION=$(jq -r '.version' <<< $mofed_metadata)
# MOFED_SHA256=$(jq -r '.sha256' <<< $mofed_metadata)
# TARBALL="MLNX_OFED_SRC-$MOFED_VERSION.tgz"
# MOFED_DOWNLOAD_URL=https://www.mellanox.com/downloads/ofed/MLNX_OFED-$MOFED_VERSION/$TARBALL
# MOFED_FOLDER=$(basename $MOFED_DOWNLOAD_URL .tgz)
# kernel_without_arch="${KERNEL%.*}"

# $COMMON_DIR/download_and_verify.sh $MOFED_DOWNLOAD_URL $MOFED_SHA256
# tar zxvf $TARBALL

# pushd $MOFED_FOLDER
# ./install.pl --all --without-openmpi
# popd

# Install Infiniband-diags and deps
tdnf install -y <pcakage-url>  libibumad-2407mlnx52-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  infiniband-diags-2407mlnx52-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  libibverbs-2407mlnx52-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  libibverbs-utils-2407mlnx52-1.azl3.2407061.x86_64.rpm

tdnf install -y <pcakage-url>  ofed-scripts-24.07-OFED.24.07.0.6.1.x86_64.rpm
tdnf install -y <pcakage-url>  mlnx-tools-24.07-0.2407061.x86_64.rpm

# Install RDMA core and devel
tdnf install -y <pcakage-url>  librdmacm-2407mlnx52-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  librdmacm-utils-2407mlnx52-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  rdma-core-2407mlnx52-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  rdma-core-devel-2407mlnx52-1.azl3.2407061.x86_64.rpm


# Install MOFED drivers and deps
tdnf install -y <pcakage-url>  mlnx-ofa_kernel-24.07-OFED.24.07.0.6.1.1.x86_64.rpm
tdnf install -y <pcakage-url>  mlnx-ofa_kernel-modules-24.07-OFED.24.07.0.6.1.1.kver.6.6.51.1_5.azl3.x86_64.rpm
tdnf install -y <pcakage-url>  mlnx-ofa_kernel-devel-24.07-OFED.24.07.0.6.1.1.kver.6.6.51.1_5.azl3.x86_64.rpm
tdnf install -y <pcakage-url>  mlnx-ofa_kernel-source-24.07-OFED.24.07.0.6.1.1.x86_64.rpm

tdnf install -y <pcakage-url>  kernel-mft-4.29.0-6.6.51.1_5.azl3.x86_64.rpm
tdnf install -y <pcakage-url>  mstflint-4.28.0-1.azl3.x86_64.rpm

tdnf install -y <pcakage-url>  fwctl-24.07-OFED.24.07.0.5.7.1_6.6.51.1_5.azl3.x86_64.rpm
tdnf install -y <pcakage-url>  ibacm-2407mlnx52-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  ibarr-0.1.3-1.azl3.2407061.x86_64.rpm

tdnf install -y <pcakage-url>  ibsim-0.12-1.2407061.azl3.x86_64.rpm
tdnf install -y <pcakage-url>  iser-24.07-OFED.24.07.0.5.7.1_6.6.51.1_5.azl3.x86_64.rpm
tdnf install -y <pcakage-url>  isert-24.07-OFED.24.07.0.5.7.1_6.6.51.1_5.azl3.x86_64.rpm

tdnf install -y <pcakage-url>  knem-1.1.4.90mlnx3-OFED.23.10.0.2.1.1.x86_64.rpm
tdnf install -y <pcakage-url>  knem-modules-1.1.4.90mlnx3-OFED.23.10.0.2.1.1.kver.6.6.51.1_5.azl3.x86_64.rpm
tdnf install -y <pcakage-url>  perftest-24.07.0-0.44.g57725f2.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  libxpmem-2.7.3-1.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  libxpmem-devel-2.7.3-1.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  mlnx-ethtool-6.9-1.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  mlnx-iproute2-6.9.0-1.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  mlnx-nfsrdma-24.07-OFED.24.07.0.5.7.1_6.6.51.1_5.azl3.x86_64.rpm

tdnf install -y <pcakage-url>  multiperf-3.0-3.0.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  srp-24.07-OFED.24.07.0.5.7.1_6.6.51.1_5.azl3.x86_64.rpm
tdnf install -y <pcakage-url>  srp_daemon-2407mlnx52-1.azl3.2407061.x86_64.rpm

tdnf install -y <pcakage-url>  ucx-1.17.0-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  ucx-cma-1.17.0-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  ucx-devel-1.17.0-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  ucx-ib-1.17.0-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  ucx-rdmacm-1.17.0-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  ucx-static-1.17.0-1.azl3.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  xpmem-2.7.3-1.2407061.x86_64.rpm
tdnf install -y <pcakage-url>  xpmem-modules-2.7.3-1.2407061.kver.6.6.51.1_5.azl3.x86_64.rpm

$COMMON_DIR/write_component_version.sh "mofed" $MOFED_VERSION

# Restarting openibd
# /etc/init.d/openibd restart

systemctl enable openibd

# exclude opensm from updates
# sed -i "$ s/$/ opensm*/" /etc/dnf/dnf.conf

# cleanup downloaded files
# rm -rf *.tgz
# rm -rf -- */
