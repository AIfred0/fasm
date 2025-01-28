MAIN = lab4
CC = fasm
LIBS = asmlib/filesys.asm asmlib/input.asm asmlib/print.asm asmlib/math.asm asmlib/string.asm asmlib/sys.asm
LIBS_OBJ = asmlib/filesys.o asmlib/input.o asmlib/print.o asmlib/math.o asmlib/string.o asmlib/sys.o
.PHONY: default compline build run
default: build run
compline: $(LIBS)
	$(CC) asmlib/filesys.asm && $(CC) asmlib/input.asm && $(CC) asmlib/print.asm && $(CC) asmlib/math.asm && $(CC) asmlib/string.asm && $(CC) asmlib/sys.asm
build: $(MAIN).asm $(LIBS_OBJ)
	$(CC) $(MAIN).asm
	ld $(MAIN).o $(LIBS_OBJ) -o main
dump: main
	objdump -S -M intel -d main > obj.dump
	cat obj.dump
run: main
	./main