

echo "Giving executing permissions to clean script"
chmod +x frost/clean.sh

echo "Exporting ARCH as arm"
export ARCH=arm
echo "Done"
echo "Initializing cross compile"

export CROSS_COMPILE=~/toolchain/gcc-arm-none-eabi-4_7-2013q1/bin/arm-none-eabi-

echo "Done"

make frost_baffin_defconfig
echo "done"

echo -p "Press Enter to build Kernel ..."
make CONFIG_DEBUG_SECTION_MISMATCH=y -j2
