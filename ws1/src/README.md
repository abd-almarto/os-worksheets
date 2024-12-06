# Work sheet 1 

### Task 1

## Overview

This project showcases the integration of C and assembly language to perform a simple arithmetic operation: adding two integers and printing the result. The assembly language module is designed to be called from a C driver program, illustrating how low-level operations can be executed within a high-level language framework.

### Purpose

The primary purpose of this project is to demonstrate:
- The interoperability between C and assembly language.
- Basic I/O operations in assembly.
- The use of calling conventions in mixed-language programming.

## Files

 **`driver.c`**: The C driver program that invokes the assembly function.

 **`task1.asm`**: The assembly language code that performs the addition operation and handles I/O.

 **`asm_io.asm`**: Assembly routines for input/output operations.

 **`asm_io.inc`**: Assembly macros for debugging and memory operations.

## Code Explanation

### `driver.c`

Here is the content of `driver.c`:

```c
int attribute((cdecl)) asm_main(void);

int main() {
    int ret_status;
    ret_status = asm_main();
    return ret_status;
}
```
## Explanation:
- Function Declaration:
```c
int attribute((cdecl)) asm_main(void);
```
This line declares the assembly function asm_main using the cdecl calling convention, allowing the C program to call it correctly.

- Main Function:
```c
int main() { ... }
```
- This is the entry point of the C program.
- int ret_status; declares a variable to hold the return status of asm_main.

- ret_status = asm_main(); calls the assembly function and stores its return value.

- return ret_status; returns the status code to the operating system.


## `task1.asm`
### Explanation:
#### Data Section:

This section is used to declare initialized data.

- integer1 dd 18 defines a double word (32 bits) with an initial value of 18.

- integer2 dd 60 defines another double word with an initial value of 60.
```
section .data
    integer1 dd 18       ; First integer
    integer2 dd 60       ; Second integer
```

#### BSS Section:
```
section .bss
    result resd 1        ; Reserve space for the result
```
- This section is used for declaring variables that are not initialized.

- result resd 1 reserves space for one double word to store the result of the addition.

#### Text Section:
```
section .text
    global asm_main
```

- This section contains the executable code.
global asm_main makes the asm_main function accessible from the C program.

#### Function Implementation:
```
asm_main:
    pusha                ; Save all general-purpose registers

    mov eax, [integer1]  ; Load the value of integer1 into eax
    add eax, [integer2]  ; Add the value of integer2 to eax
    mov [result], eax    ; Store the result in the 'result' variable

    push eax             ; Push the result onto the stack to pass it to print_int
    call print_int       ; Call the print_int function to print the result
    add esp, 4           ; Clean up the stack (4 bytes for the pushed value)

    popa                 ; Restore all general-purpose registers

    mov eax, 0           ; Return 0 as the exit status
    ret                  ; Return from asm_main
```
- asm_main: marks the beginning of the assembly function.
- pusha: Saves all general-purpose registers to the stack.
- mov eax, [integer1]: Loads the value of integer1 into the eax register.
- add eax, [integer2]: Adds the value of integer2 to eax.
- mov [result], eax: Stores the result of the addition in the result variable.
- push eax: Pushes the result onto the stack for the I/O function.
- call print_int: Calls the print_int function (from asm_io.inc) to display the result.
- add esp, 4: Cleans up the stack by removing the pushed value.
- popa: Restores all general-purpose registers from the stack.
- mov eax, 0: Prepares to return 0 as the exit status.
- ret: Returns control to the caller.

### `asm_io.asm` 

### Functionality:
- I/O Functions: Provides routines for reading integers, printing integers, reading characters, and printing characters.

- Format Definitions: Defines string formats for output.

- Register and Memory Dumping: Functions to display the state of registers and memory for debugging purposes.

### `asm_io.inc` 

This file is a debugging toolset for assembly language programs. It helps to:

- Inspect the state of the CPU registers.
- View the content of specific memory locations.
- Check the state of math-related flags or computations.
- Analyze the stack contents.
- Use pre-defined input/output utilities to interact with the user during program execution.

### Compilation and Execution
To compile and run the project, you will need to
Open a terminal and navigate to the directory ws1:
```
cd os
cd os/os-worksheets
cd ws1
cd src

```

 
After that run the following commands:
##### Assemble the Assembly Code:
* nasm -f elf task1.asm -o task1.o
* nasm -f elf asm_io.asm -o asm_io.o

##### Compile the C Code:
In the same terminal, compile the C driver by runing the following commands:
* gcc -m32 -c driver.c -o driver.o
* gcc -m32 task1.o asm_io.o driver.o -o task1

##### Run the Executable:
Execute the program with the following comman

```
./task1
```
### Example output 
```
78
```


## Task 2


This assembly program performs several tasks involving user input, loops, array operations, and summation.

---

## **Features**
1. **User Input and Validation**:
   - Prompts the user to enter a number between 50 and 100.
   - If the input is outside this range, an error message is displayed.

   ```asm
     promptNumTimes db "Enter the number of times to print the welcome message (between 50 and 100): ", 0

    errorMessage db "Error: Number must be between 50 and 100", 10, 0

    welcomeMsg db "Welcome!", 0

    ```

2. **Message Printing**:
   - Prints a "Welcome!" message a specified number of times based on the user's input.

   ```asm
  
     welcomeMsg db "Welcome!", 0

    ```

3. **Array Initialization and Summation**:
   - Initializes an array of 100 elements with values from 1 to 100.
   - Calculates and prints the sum of all elements in the array.

4. **User-Defined Range Summation**:
   - Prompts the user to enter a start and end range (1-100).
   - Validates the range and calculates the sum of the array elements within this range.
   - Displays the result or an error message if the range is invalid.

---

## **Code Breakdown**

### **Included File**
- `"asm_io.inc"`: Provides assembly macros and routines for input/output operations like `print_string`, `read_int`, and `print_int`.

### **Data Section**
Defines string messages and uninitialized variables:
- **Messages**:
  - `promptNumTimes`: Prompt to ask how many times to print the "Welcome!" message.
  - `errorMessage`: Error message if the input is invalid.
  - `welcomeMsg`: The "Welcome!" message.
  - Additional messages for array summation and range operations.

- **Variables**:
  - `numTimes`: Stores user input for the number of times to print the welcome message.
  - `array`: Stores 100 integers initialized to values from 1 to 100.
  - `sum`: Stores results of array and range summations.
  - `rangeStart` and `rangeEnd`: Stores the start and end indices for the range.

### **BSS Section**
Declares uninitialized variables:
- `numTimes`, `array`, `sum`, `rangeStart`, and `rangeEnd`.

### **Program Steps**

#### 1. **Print Welcome Messages**
- Prompts the user to input the number of times to print "Welcome!".
- Validates the input to ensure it's between 50 and 100.
- Prints "Welcome!" the specified number of times using a loop.

#### 2. **Array Initialization and Summation**
- Initializes an array of 100 elements with values from 1 to 100.
- Sums all elements in the array.
- Prints the sum.

#### 3. **Summing a User-Defined Range**
- Prompts the user to input the start and end indices for the range (1-100).
- Validates that:
  - The start is less than or equal to the end.
  - Both values are within the 1-100 range.
- Sums the array elements within the specified range.
- Prints the sum or an error message if the range is invalid.

---

## **Error Handling**
- **Input Validation for Welcome Message**:
  - Prints `errorMessage` if the user enters a number outside the range 50-100.
  
- **Range Validation**:
  - Prints `rangeErrorMsg` if the start index is greater than the end index or if either index is out of the range 1-100.

---

## **Assembly Details**

### **Key Instructions**
- **Loops**:
  - `loop`: Used for decrementing `ecx` and repeating operations until `ecx` reaches 0.
  
- **Function Calls**:
  - `call print_string`: Prints a string.
  - `call read_int`: Reads an integer input.
  - `call print_int`: Prints an integer.
  - `call print_nl`: Prints a newline.

- **Array Operations**:
  - Array indexing is achieved using `array + edi*4`, where `edi` is the index.

---

## **How to Run**
To compile and run the project, you will need to
Open a terminal and navigate to the directory ws1:
```
cd os
cd os/os-worksheets
cd ws1
cd src

```

 
After that run the following commands:

1. Assemble the code using NASM:
   
   - nasm -f elf task2.asm -o task2.o
    
2.   Assemble asm_io.asm

     - nasm -f elf asm_io.asm -o asm_io.o

3. Link the object files to create the executable for task2
   - gcc -m32 driver.o task2.o asm_io.o -o task2
##### Run the Executable:
Execute the program with the following comman

```
./task2
```
    
    
## Example output 
```
Enter the number of times to print the welcome message (between 50 and 100): 58
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
Welcome!
The sum of the array is: 5050
Enter the start of the range (1-100): 42
Enter the end of the range (1-100): 88
The sum of the range is: 3055
```


## Task3

### Makefile

This `Makefile` is designed to automate the compilation and linking process for the two tasks (`task1` and `task2`) and a shared driver program. It ensures that the necessary object files and executables are created efficiently and provides a cleanup mechanism.

#### Purpose
This Makefile is designed to simplify the build process for projects combining assembly and C. By automating the compilation, linking, and cleanup steps, it saves time and reduces errors compared to manual compilation.



---

## **Targets in the Makefile**

### Default Target: `all`
The `all` target compiles all object files and links them to create the `task1` and `task2` executables. It ensures that everything required to run the project is built.

---

### Compilation Rules
- **`task1.o`**: Compiles `task1.asm` into an object file using the NASM assembler in ELF format.
- **`task2.o`**: Compiles `task2.asm` into an object file using the NASM assembler in ELF format.
- **`asm_io.o`**: Compiles `asm_io.asm`, which contains helper routines for input/output operations, into an object file using NASM.
- **`driver.o`**: Compiles `driver.c`, a C program used to interact with the assembly code, into an object file using GCC in 32-bit mode.

---

### Linking Rules
- **`task1`**: Links the compiled object files (`task1.o`, `asm_io.o`, and `driver.o`) to produce the executable `task1`.
- **`task2`**: Links the compiled object files (`task2.o`, `asm_io.o`, and `driver.o`) to produce the executable `task2`.

---

###  Cleanup Target
The `clean` target removes all generated object files (`.o`) and executables (`task1`, `task2`). This is useful for resetting the build environment.

---

### **How to run**
You will need to
Open a terminal and navigate to the directory ws1:
```
cd os
cd os/os-worksheets
cd ws1
cd src

```
1. **Build All Targets**

   Run the following command to compile and link everything:
   ```bash
   make all
   ```
### Output ###
```
nasm -f elf task1.asm -o task1.o
nasm -f elf task2.asm -o task2.o
nasm -f elf asm_io.asm -o asm_io.o
gcc -m32 -c driver.c -o driver.o
gcc -m32 task1.o asm_io.o driver.o -o task1
gcc -m32 task2.o asm_io.o driver.o -o task2
```
2. **Clean** Build Artifacts To delete all compiled files and executables:

```
make clean 

```
3. **Make tasks indivisually**
```
make task1

output:
nasm -f elf task1.asm -o task1.o
nasm -f elf asm_io.asm -o asm_io.o
gcc -m32 -c driver.c -o driver.o
gcc -m32 task1.o asm_io.o driver.o -o task1
```

```
make task2

output: 
nasm -f elf task2.asm -o task2.o
gcc -m32 task2.o asm_io.o driver.o -o task2
```
