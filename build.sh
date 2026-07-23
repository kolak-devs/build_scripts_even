#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/crdroidandroid/android.git -b 16.0 --git-lfs --no-clone-bundle --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone --depth=1 https://github.com/kolak-devs/even-manifests.git .repo/local_manifests -b sixteen/dev
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
/opt/crave/resync.sh || repo sync
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=ismasrull 
export BUILD_HOSTNAME=crave
export WITH_GMS=true
export DEVICE_MAINTAINER=ismasrull
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh

# Lunch
brunch even user

# installclean
make installclean

# Build
mka bacon

# Copy imgs to a separate folder for easy download
mkdir -p my_output
cp out/target/product/even/*.img my_output/
cp out/target/product/even/*.zip my_output/
