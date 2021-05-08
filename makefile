all: hello.out exit.out

hello.o:  hello.asm
		nasm -f macho64 hello.asm

hello.out:   hello.o
		ld -macosx_version_min 10.15.7 -lSystem -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -no_pie -o hello.out hello.o

exit.o:  exit.asm
		nasm -f macho64 exit.asm

exit.out:   exit.o
		ld -macosx_version_min 10.15.7 -lSystem -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -no_pie -o exit.out exit.o