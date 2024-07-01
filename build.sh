echo Compiling $(cat ./amd_asm/manifest)
as ./amd_asm/amd_asm.asm -o ./amd_asm.o
ld ./amd_asm.o -o ./amd_asm/amd_asm

echo Compiling $(cat ./arm_asm/manifest)
arm-none-eabi-as ./arm_asm/arm_asm.asm -o ./arm_asm.o
arm-none-eabi-ld ./arm_asm.o -o ./arm_asm/arm_asm

echo Compiling $(cat ./c/manifest)
gcc ./c/c.c -o ./c/c

echo Compiling $(cat ./cpp/manifest)
g++ ./cpp/cpp.cpp -o ./cpp/cpp


echo Compiling $(cat ./java/manifest)
mv ./java/java.java .
javac ./java.java
jar cfe ./java.jar HelloWorld ./HelloWorld.class

mv java.java ./java
mv java.jar ./java
rm *.class

echo Compiling $(cat ./cs/manifest)
mcs -out:./cs/cs ./cs/cs.cs

echo Compiling $(cat ./rust/manifest)
rustc ./rust/rust.rs -o ./rust/rust

rm ./*.o
