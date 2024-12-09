# Introduction

This system kernel demonstrates the integration of low level assembly language with higher-level C programming. It provides a foundation for understanding how operating systems work at a fundamental level, using basic kernel features to showcase concepts such as bootloading, system initialization, memory management, and hardware-software interaction.

The kernel is Multiboot compliant, making it compatible with popular bootloaders like GRUB, and can be tested in a virtualized QEMU environment. The project employs GCC and NASM for compilation and uses `make` for automated builds. The result is a kernel that bridges the gap between assembly and C code, demonstrating the cooperation between the two languages in low level system programming.

### Task1 & 2

### 1. Kernel Loader
The kernel loader is the entry point, implemented in assembly language. Its role is to initialize the system environment, set up memory regions for use by the kernel and transfer control to the main kernel functions written in C.

### 2. Arithmetic Operations in C
This kernel demonstrates basic arithmetic functionality through C function integrated with assembly:
- **`sum_of_three`**: Adds three integers and returns the result.

### 3. Multiboot Compliance
The kernel adheres to the Multiboot specification:
- Compatible with GRUB and other Multiboot compliant bootloaders.
- Enables seamless loading of the kernel and boot-time configuration.

### 4. Bootable ISO Creation
The prgram generates a bootable ISO image of the kernel using `genisoimage`, making it easy to test on virtual machines or hardware.

### 5. QEMU Virtualization
The kernel is designed to run in a QEMU virtual environment:
- Ensures safe testing without affecting the host system.
- Simulates hardware behavior to test kernel features like memory and CPU interaction.


### File Descriptions

- **`Makefile`**: Automates the build process, ISO creation, and cleanup tasks.
- **`loader.s`**: Written in NASM assembly, handles early system initialization.
- **`link.ld`**: Configures memory sections such as `.text`, `.data`, and `.bss` for the final kernel binary.
- **`kernel.c`**: Contains C function (`sum_of_three`) for kernel functionality.

---

### How to build and run
To compile and run the project, you will need to
Open a terminal and navigate to the directory ws2:
```
cd os
cd os/os-worksheets
cd ws2
```
after that we run Make command
```
Make
```
This command performs the following steps:

* Compiling C Files: Compiles the C source (kernel.c) into object files.

``` make
%.o: %.c
	$(CC) $(CFLAGS) $< -o $@
```
* Assembling Assembly Code: Translates assembly code (loader.s) into object files.
``` make
%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@
```

* Linking: Combines object files into a single executable kernel binary (kernel.elf).

* ISO Image Creation: Packages the kernel binary into a bootable ISO (os.iso).
``` code
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
```

### Running the Kernel
To test the kernel, execute:
```
make run
```
This will launch QEMU, Boot the kernel from the generated ISO and Provide an interactive environment to test the kernel.

### Cleaning Up
To remove all build artifacts, run:

```
make clean
```
This command deletes:

* Object files (*.o).
* The kernel binary (kernel.elf).
* The ISO image (os.iso).

the kernel Functions in C

int sum_of_three(int arg1, int arg2, int arg3) adds three integers and returns the result.

 ### Linker Script: link.ld

The linker script defines the memory layout of the kernel binary:

ENTRY(loader):
Specifies the kernel's entry point.

#### SECTIONS:

.text: Contains executable code.

.data: Stores initialized global variables.

.bss: Allocates uninitialized global variables.


### Output
```
  Booting 'os'

kernel /boot/kernel.elf
   [Multiboot-elf, <0x100000:0x11c:0x0>, <0x101000:0x0:0x1000>, shtab=0x102190,
 entry=0x10000c
 ```
#### Output Meaning

> Booting 'os'

Indicates that the bootloader is initiating the boot process for the operating system labeled "os."

> kernel /boot/kernel.elf

Specifies the path of the kernel binary (kernel.elf) that the bootloader is loading from the disk.

**kernel.elf** is the kernel executable file that has been compiled and linked during the build process.

**[Multiboot-elf, <...>, shtab=0x102190, entry=0x10000c]**
Provides detailed information about the Multiboot-compliant kernel being loaded:

**Multiboot-elf**: Confirms that the kernel adheres to the ELF format as defined by the Multiboot specification.

text section (code) begins.
0x11c: The size of the ELF header.

<0x101000:0x0:0x1000>: Details about additional memory sections, such as the .bss segment:

**entry=0x10000c**: The entry point address of the kernel. This is the location where execution begins after the bootloader transfers control to the kernel.
What Does This Output Tell Us?

The bootloader has successfully loaded the kernel into memory.
The kernel adheres to the Multiboot standard and is in the ELF format.
The kernel's entry point is at 0x10000c, where execution will start.

This output verifies that the kernel is properly structured and ready for execution, a critical step in the booting process.

