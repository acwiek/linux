set -e
cd ~/git/linux

export BUILD_DIR=build
export K_VERSION=$(make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=$BUILD_DIR -s kernelrelease)
#make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 O=$BUILD_DIR -C . M=drivers/char/tpm EXTRA_CFLAGS="-g -DDEBUG=1 -finstrument-functions"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 O=$BUILD_DIR -C . M=drivers/char/tpm EXTRA_CFLAGS="-g -DDEBUG=1"

export MOD_SRC=build/drivers/char/tpm
export MOD_TMP_DST=/home/pi
export MOD_DST=/lib/modules/$K_VERSION/kernel/drivers/char/tpm

scp $MOD_SRC/tpm.ko $RASPI_IP:$MOD_TMP_DST/
scp $MOD_SRC/tpm_tis_core.ko $RASPI_IP:$MOD_TMP_DST
scp $MOD_SRC/tpm_tis_spi.ko $RASPI_IP:$MOD_TMP_DST

ssh $RASPI_IP sudo mv tpm.ko $MOD_DST;
ssh $RASPI_IP sudo mv tpm_tis_core.ko $MOD_DST;
ssh $RASPI_IP sudo mv tpm_tis_spi.ko $MOD_DST;
ssh $RASPI_IP sudo reboot 
