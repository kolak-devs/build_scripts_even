#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/ProjectInfinity-X/manifest -b 16 --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone --depth=1 https://github.com/kolak-devs/even-manifests.git .repo/local_manifests -b sixteen-qpr2 
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
/opt/crave/resync.sh 
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=ismasrull 
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh

# Lunch
lunch infinity_even-bp4a-user

# Build
m bacon

# Copy imgs to a separate folder for easy download
mkdir -p my_output
cp out/target/product/even/*.img my_output/
cp out/target/product/even/*.zip my_output/
