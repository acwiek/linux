set -e

export KERNEL=kernel7
# output build directories
export BUILD_DIR=build
export INSTALL_PATH=install_tmp
# temp directory for new content of the /boot and /root partion 
export BOOT_PART_TMP=$BUILD_DIR/$INSTALL_PATH/boot

# make modules_install will create build/install_tmp/root/lib directory during
# install. we dont need to specify $BUILD_DIR prefix
export ROOT_PART_TMP=$INSTALL_PATH/root

# prepare output directory
mkdir -p $BOOT_PART_TMP
mkdir -p $BOOT_PART_TMP/overlays

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 O=$BUILD_DIR bcm2709_defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 O=$BUILD_DIR scripts prepare modules_prepare
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 O=$BUILD_DIR zImage modules dtbs
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 O=$BUILD_DIR modules_install INSTALL_MOD_PATH=$ROOT_PART_TMP 

# export K_VERSION variable
export K_VERSION=$(make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=$BUILD_DIR -s kernelrelease)

cp build/arch/arm/boot/zImage $BOOT_PART_TMP/$KERNEL.img
# cp build/.config $BOOT_PART_TMP/config-$K_VERSION
# cp build/./Module.symvers  $BOOT_PART_TMP/symvers-$K_VERSION
# maybe replace with installing deb package as starting point

cp build/arch/arm/boot/dts/*.dtb $BOOT_PART_TMP
cp build/arch/arm/boot/dts/overlays/*.dtb $BOOT_PART_TMP/overlays


tar -zcvf install.tar.gz $BUILD_DIR/$INSTALL_PATH

