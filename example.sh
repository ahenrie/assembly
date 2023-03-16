nasm -gdwarf -felf64 example.asm -l example.lst
ld -g -o example example.o
