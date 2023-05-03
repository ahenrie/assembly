nasm -gdwarf -f elf64  printString.asm -l printString.lst
nasm -gdwarf -f elf64  inputString.asm -l inputString.lst
nasm -gdwarf -f elf64  YorN.asm -l YorN.lst
nasm -gdwarf -f elf64 generate_number.asm -l generate_number.lst
nasm -gdwarf -f elf64 final.asm -l final.lst
ld -g -o final final.o YorN.o printString.o inputString.o generate_number.o
