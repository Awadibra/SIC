#format is target-name: target dependencies
#	actions

# All Targets
all: sic

# Tool invocations
# Executable "sic" depends on the files sic.o.
sic: sic.o
		gcc -g -Wall -o sic sic.o

# Depends on the source
sic.o: sic.s
		nasm -g -f elf64 -w+all -o sic.o sic.s

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o sic
