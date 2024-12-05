/* The C function */
int sum_of_three(int arg1, int arg2, int arg3)
{
return arg1 + arg2 + arg3;
}

int multiply_two(int arg1, int arg2)
{
    return arg1 * arg2;
}

/* Function to divide two integers */
int divide_two(int dividend, int divisor)
{
    if (divisor == 0) {
        return -1; // Return -1 for division by zero to indicate an error
    }
    return dividend / divisor;
}
/*farme buffer function

 char *fb = (char *) 0x000B8000;
    fb[0] = 'A';       // Write character 'A'
    fb[1] = 0x28;      // Write attribute (green foreground, dark grey background)


 void fb_write_cell(unsigned int i, char c, unsigned char fg, unsigned char bg) {
    fb[i] = c;
    fb[i + 1] = ((fg & 0x0F) << 4) | (bg & 0x0F);
}*/


