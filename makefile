
all: main

main: main.o  myasm.o
	gcc -g -m32 -Wall main.o myasm.o -o main

main.o: main.c
	gcc -g -m32 -Wall -c main.c -o main.o

myasm.o: myasm.s
	nasm -g -f elf -w+all  myasm.s -o myasm.o

.PHONY:
	clean

clean:
	rm -f ./*.o main