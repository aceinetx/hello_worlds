all:
	as ./amd_asm/amd_asm.asm -o ./amd_asm.o
	ld ./amd_asm.o -o ./amd_asm/amd_asm

	gcc ./c/c.c -o ./c/c
	g++ ./cpp/cpp.cpp -o ./cpp/cpp

	mv ./java/java.java .
	javac ./java.java
	jar cfe ./java.jar HelloWorld ./HelloWorld.class

	mv java.java ./java
	mv java.jar ./java
	rm *.class

	mcs -out:./cs/cs ./cs/cs.cs

	rustc ./rust/rust.rs -o ./rust/rust

	rm ./*.o
