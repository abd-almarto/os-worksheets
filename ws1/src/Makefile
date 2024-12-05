all: task1.o task2.o asm_io.o task1 task2 driver.o

task1.o: task1.asm
	nasm -f elf task1.asm -o task1.o

task2.o: task2.asm
	nasm -f elf task2.asm -o task2.o

asm_io.o: asm_io.asm
	nasm -f elf asm_io.asm -o asm_io.o

driver.o: driver.c
	gcc -m32 -c driver.c -o driver.o

task1: task1.o asm_io.o driver.o
	gcc -m32 task1.o asm_io.o driver.o -o task1

task2: task2.o asm_io.o driver.o
	gcc -m32 task2.o asm_io.o driver.o -o task2

clean:
	rm -f task1.o task2.o asm_io.o driver.o task1