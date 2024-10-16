#!/bin/bash
set -ex

source ${COMMON_DIR}/utilities.sh

# Setup Azure Linux NVIDIA packages repo
curl https://packages.microsoft.com/azurelinux/3.0/prod/nvidia/x86_64/config.repo > /etc/yum.repos.d/azurelinux-nvidia-prod.repo

# Install signed NVIDIA driver
nvidia_driver_metadata=$(get_component_config "nvidia")
NVIDIA_DRIVER_VERSION=$(jq -r '.driver.version' <<< $nvidia_driver_metadata)
tdnf install -y cuda-$NVIDIA_DRIVER_VERSION # Note: Nvidia driver is named cuda in Azure Linux packages repo
$COMMON_DIR/write_component_version.sh "nvidia" $NVIDIA_DRIVER_VERSION

# Temp disable NVIDIA driver updates
mkdir -p /etc/tdnf/locks.d
echo cuda >> /etc/tdnf/locks.d/nvidia.conf

# Set the CUDA driver versions
cuda_metadata=$(get_component_config "cuda")
CUDA_DRIVER_VERSION=$(jq -r '.driver.version' <<< $cuda_metadata)
CUDA_DRIVER_DISTRIBUTION=$(jq -r '.driver.distribution' <<< $cuda_metadata)
CUDA_SAMPLES_VERSION=$(jq -r '.samples.version' <<< $cuda_metadata)
CUDA_SAMPLES_SHA256=$(jq -r '.samples.sha256' <<< $cuda_metadata)

# Install Cuda
dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/${CUDA_DRIVER_DISTRIBUTION}/x86_64/cuda-${CUDA_DRIVER_DISTRIBUTION}.repo
tdnf clean expire-cache
tdnf install cuda-toolkit-${CUDA_DRIVER_VERSION} -y
echo 'export PATH=$PATH:/usr/local/cuda/bin' | tee -a /etc/bash.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64' | tee -a /etc/bash.bashrc
$COMMON_DIR/write_component_version.sh "CUDA" ${CUDA_DRIVER_VERSION}

# Download CUDA samples
TARBALL="v${CUDA_SAMPLES_VERSION}.tar.gz"
CUDA_SAMPLES_DOWNLOAD_URL=https://github.com/NVIDIA/cuda-samples/archive/refs/tags/${TARBALL}
# $COMMON_DIR/download_and_verify.sh $CUDA_SAMPLES_DOWNLOAD_URL $CUDA_SAMPLES_SHA256
cp /home/packer/azurelinux-hpc/prebuilt/${TARBALL} .
tar -xvf ${TARBALL}
pushd ./cuda-samples-${CUDA_SAMPLES_VERSION}
make -j $(nproc)
mkdir -p /usr/local/cuda-${CUDA_SAMPLES_VERSION}
mv -vT ./Samples /usr/local/cuda-${CUDA_SAMPLES_VERSION}/samples
popd

# Temporarily install NV Peer Memory
# $AZURE_LINUX_COMMON_DIR/install_nv_peer_memory.sh

# load the nvidia-peermem coming as a part of NVIDIA GPU driver
# modprobe nvidia-peermem
# verify if loaded
# lsmod | grep nvidia_peermem


# Install GDRCopy
gdrcopy_metadata=$(get_component_config "gdrcopy")
GDRCOPY_VERSION=$(jq -r '.version' <<< $gdrcopy_metadata)
GDRCOPY_SHA256=$(jq -r '.sha256' <<< $gdrcopy_metadata)
TARBALL="v${GDRCOPY_VERSION}.tar.gz"
GDRCOPY_DOWNLOAD_URL=https://github.com/NVIDIA/gdrcopy/archive/refs/tags/${TARBALL}
$COMMON_DIR/download_and_verify.sh $GDRCOPY_DOWNLOAD_URL $GDRCOPY_SHA256
tar -xvf $TARBALL

# pushd gdrcopy-${GDRCOPY_VERSION}/packages/
# CUDA=/usr/local/cuda ./build-rpm-packages.sh
# rpm -Uvh gdrcopy-kmod-${GDRCOPY_VERSION}-1dkms*.rpm
# rpm -Uvh gdrcopy-${GDRCOPY_VERSION}-1.x86_64*.rpm
# rpm -Uvh gdrcopy-devel-${GDRCOPY_VERSION}-1*.rpm
# sed -i "$ s/$/ gdrcopy*/" /etc/dnf/dnf.conf
# popd
$COMMON_DIR/write_component_version.sh "GDRCOPY" ${GDRCOPY_VERSION}

# Install nvidia fabric manager (required for ND96asr_v4)
$AZURE_LINUX_COMMON_DIR/install_nvidia_fabric_manager.sh

# cleanup downloaded files
rm -rf *.run *tar.gz *.rpm
rm -rf -- */