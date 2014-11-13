
# Initializing variables

MODULES=frost/codekidX/lib/modules
USER=codekidX
VERSION=1.81
DATE=date '+%Y%m%d'

# Start Compilation
echo "Giving executing permissions to clean script"
chmod +x clean.sh
.clean.sh

echo "Exporting ARCH as arm"
export ARCH=arm
echo "Done"
echo "Initializing cross compile"

export CROSS_COMPILE=/home/ashish/toolchain/gcc-arm-none-eabi-4_7-2013q1/bin/arm-none-eabi-

echo "Done"

make frost_baffin_defconfig
echo "done"

read -p "Press Enter to build Kernel ..."
make CONFIG_DEBUG_SECTION_MISMATCH=y -j2

Kernel="arch/arm/boot/zImage"
if [ -f $Kernel ]
	then
echo -e "Copying modules"
echo "==============================================="
mkdir frost/codekidX/lib/modules
find -name '*.ko' -exec cp {} $MODULES \;
echo -e ""
echo -e "Copying kernel"
echo "==============================================="
cp $Kernel frost/kernel
echo -e ""
echo -e "Zipping"
echo "==============================================="
cd frost
zip -r $USER-frost-$DATE-$VERSION.zip
echo -e ""
echo -e "Removing unwanted stuffs .."
echo "==============================================="
rm -rf kernel/zImage
rm -rf codekidX
echo -e ""
echo -e "Copy kernel to HOME"
echo "==============================================="
cp $USER-frost-$DATE-$VERSION.zip ../../out
cd ..
echo -e ""
echo -e "=============================================="
echo -e "      FROST KERNEL COMPILATION SUCCESSFUL     "
echo -e "=============================================="
		
fi