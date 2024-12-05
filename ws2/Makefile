# Object files
OBJECTS = loader.o kmain.o #sum_of_three.o multiply_two.o divide_two.o

# Compiler and assembler settings
CC = gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
         -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
LDFLAGS = -T link.ld -melf_i386
AS = nasm
ASFLAGS = -f elf

# Default target
all: kernel.elf

# Kernel ELF binary
kernel.elf: $(OBJECTS)
	ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

# ISO creation
os.iso: kernel.elf
	cp kernel.elf iso/boot/kernel.elf
	genisoimage -R \
	            -b boot/grub/stage2_eltorito \
	            -no-emul-boot \
	            -boot-load-size 4 \
	            -A os \
	            -input-charset utf8 \
	            -quiet \
	            -boot-info-table \
	            -o os.iso \
	            iso

# Run the OS in QEMU
run: os.iso
	qemu-system-i386 -nographic -boot d -cdrom os.iso -m 32

# Compile C source files into object files
%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

# Assemble assembly source files into object files
%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

# Clean the build directory
clean:
	rm -rf *.o kernel.elf os.iso
