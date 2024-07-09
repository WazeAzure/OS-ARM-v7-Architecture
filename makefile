all:
	arm-none-eabi-as -march=armv7-a -mcpu=cortex-a15 _start.arm -o _start.o
	arm-none-eabi-gcc -ffreestanding -Wall -Wextra -Werror -c start.c -o start.o
	arm-none-eabi-ld -T linker.ld _start.o start.o -o kernel.elf
	# qemu-system-arm -M vexpress-a15 -cpu cortex-a15 -kernel kernel.elf -nographic