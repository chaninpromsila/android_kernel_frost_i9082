# Initializing variables

MODULES=frost/codekidX/lib/modules
USER=codekidX
DEVICE=I9082
VERSION=-lollipop-2.00-
DATE=$(date '+%Y%m%d')
Kernel="arch/arm/boot/zImage"


# Start Compilation
clear
echo "Giving executing permissions to clean script"
echo "==============================================="
echo -e ""
chmod +x clean.sh
./clean.sh
echo -e ""
echo -e ""
read -p "Cleaning done Enter to proceed ..."
echo -e "==============================================="
echo -e ""
clear
echo -e "Copying Toolchain"
echo -e "==============================================="
echo -e ""

if [ -d "toolchain" ]
	then
echo -e "Toolchain already present .."
elif [ ! -d "toolchain" ]
	then
	mkdir toolchain
    cd ..
    cp -r toolchains/* frost/toolchain
    cd frost

fi


read -p "Initialize Toolchain by pressing ENTER ..."
echo -e "==============================================="
echo -e ""

export ARCH=arm
#Toolchain
export CROSS_COMPILE=$(pwd)/toolchain/gcc-arm-none-eabi-4_7/bin/arm-none-eabi-

echo "Done"

make frost_baffin_defconfig

read -p "Press Enter to build Kernel ..."
echo "==============================================="
echo -e ""
make CONFIG_DEBUG_SECTION_MISMATCH=y -j2

if [ -f $Kernel ]
	then
echo -e "Copying modules and necessary files"
echo "==============================================="
mkdir frost/codekidX
cd frost/codekidX
mkdir lib
mkdir app
cd lib
mkdir modules
cd /home/ashish/frost
find -name '*.ko' -exec cp {} $MODULES \;
cp /home/ashish/out/VoiceSolution.ko $MODULES
<<<<<<< HEAD
cp /home/ashish/out/AeroControl.apk /home/ashish/frost/frost/codekidX/app
=======
cp /home/ashish/out/busybox frost/codekidX
>>>>>>> parent of 0be4fff... frost: mounting data by sbin/mount not busybox
echo -e ""
echo -e "Done"
echo -e ""
echo -e ""
echo -e "Copying kernel"
echo "==============================================="
cp $Kernel frost/kernel
echo -e ""
echo -e ""
echo -e "Zipping"
echo "==============================================="
cd frost
zip -r frost-$VERSION-$DATE-$USER-$DEVICE.zip .
echo -e ""
echo -e "Removing unwanted stuffs .."
echo "==============================================="
rm -rf kernel/zImage
rm -rf codekidX
echo -e ""
echo -e "Move Finished kernel to HOME"
echo "==============================================="
mv frost-$DATE-$USER-$DEVICE-$VERSION.zip ../../out
cd ..
rm -rf toolchain
make clean mrproper
git checkout drivers/misc/vc04_services/interface/vchiq_arm/vchiq_version.c
clear
echo -e ""
echo -e "=============================================="
echo -e "      FROST KERNEL COMPILATION SUCCESSFUL     "
echo -e "=============================================="
echo -e ""
echo -e "File Name:" frost-$DATE-$USER-$DEVICE-$VERSION.zip
echo -e ""
read -p "Press Enter to take you to the directory !!"
gnome-open /home/ashish/out

fi