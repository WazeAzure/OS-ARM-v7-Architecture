# Compiler & Linker
CC 				= arm-none-eabi-gcc
ASM 			= arm-none-eabi-as
LD 				= arm-none-eabi-ld

# Directory
SOURCE_FOLDER 	= src
OUTPUT_FOLDER 	= bin
ISO_NAME 		= osarm

# Flags
WARNING_FLAG 	= -Wall -Wextra -Werror

STRIP_CFLAG   	= -nostdlib -fno-stack-protector -nostartfiles -nodefaultlibs -ffreestanding
CFLAGS			= ${WARNING_FLAG} ${STRIP_CFLAG} -c

run: all
	qemu-system-arm -M vexpress-a15 -cpu cortex-a15 -cdrom  bin/${ISO_NAME}.iso -serial mon:stdio

all: build
build: iso
	@mkdir -p $(OUTPUT_FOLDER)/iso/boot/grub
	@cp $(OUTPUT_FOLDER)/kernel.elf     $(OUTPUT_FOLDER)/iso/boot/
	@cp other/grub.cfg   $(OUTPUT_FOLDER)/iso/boot/grub/
	@grub-mkrescue -o bin/${ISO_NAME}.iso bin/iso

kernel: 
	${ASM} -march=armv7-a -mcpu=cortex-a15 ${SOURCE_FOLDER}/_start.arm -o ${OUTPUT_FOLDER}/_start.o
	${CC} ${CFLAGS} ${SOURCE_FOLDER}/start.c -o ${OUTPUT_FOLDER}/start.o
	${LD} -T linker.ld ${OUTPUT_FOLDER}/*.o -o ${OUTPUT_FOLDER}/kernel.elf
	rm -f *.o

iso: kernel
