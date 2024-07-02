time_arr=()
name_arr=()
idx="0"

lang_name=$(cat ./amd_asm/manifest)
old_time=$(date +%s%N | cut -b1-13)
echo Compiling $lang_name
as ./amd_asm/amd_asm.asm -o ./amd_asm.o
new_time=$(date +%s%N | cut -b1-13)
ms=$(expr $new_time - $old_time)
echo Took $ms ms
time_arr[$idx]=$ms
name_arr[$idx]=$lang_name
idx=$(expr $idx + 1)

ld ./amd_asm.o -o ./amd_asm/amd_asm

lang_name=$(cat ./arm_asm/manifest)
old_time=$(date +%s%N | cut -b1-13)
echo Compiling $lang_name
arm-none-eabi-as ./arm_asm/arm_asm.asm -o ./arm_asm.o
new_time=$(date +%s%N | cut -b1-13)
ms=$(expr $new_time - $old_time)
echo Took $ms ms
time_arr[$idx]=$ms
name_arr[$idx]=$lang_name
idx=$(expr $idx + 1)

arm-none-eabi-ld ./arm_asm.o -o ./arm_asm/arm_asm

lang_name=$(cat ./c/manifest)
old_time=$(date +%s%N | cut -b1-13)
echo Compiling $lang_name
gcc ./c/c.c -o ./c/c
new_time=$(date +%s%N | cut -b1-13)
ms=$(expr $new_time - $old_time)
echo Took $ms ms
time_arr[$idx]=$ms
name_arr[$idx]=$lang_name
idx=$(expr $idx + 1)

lang_name=$(cat ./cpp/manifest)
old_time=$(date +%s%N | cut -b1-13)
echo Compiling $lang_name
g++ ./cpp/cpp.cpp -o ./cpp/cpp
new_time=$(date +%s%N | cut -b1-13)
ms=$(expr $new_time - $old_time)
echo Took $ms ms
time_arr[$idx]=$ms
name_arr[$idx]=$lang_name
idx=$(expr $idx + 1)

lang_name=$(cat ./java/manifest)
old_time=$(date +%s%N | cut -b1-13)
echo Compiling $lang_name
mv ./java/java.java .
javac ./java.java
jar cfe ./java.jar HelloWorld ./HelloWorld.class

mv java.java ./java
mv java.jar ./java
rm *.class
new_time=$(date +%s%N | cut -b1-13)
ms=$(expr $new_time - $old_time)
echo Took $ms ms
time_arr[$idx]=$ms
name_arr[$idx]=$lang_name
idx=$(expr $idx + 1)

lang_name=$(cat ./cs/manifest)
old_time=$(date +%s%N | cut -b1-13)
echo Compiling $lang_name
mcs -out:./cs/cs ./cs/cs.cs
new_time=$(date +%s%N | cut -b1-13)
ms=$(expr $new_time - $old_time)
echo Took $ms ms
time_arr[$idx]=$ms
name_arr[$idx]=$lang_name
idx=$(expr $idx + 1)

lang_name=$(cat ./rust/manifest)
old_time=$(date +%s%N | cut -b1-13)
echo Compiling $lang_name
rustc ./rust/rust.rs -o ./rust/rust
new_time=$(date +%s%N | cut -b1-13)
ms=$(expr $new_time - $old_time)
echo Took $ms ms
time_arr[$idx]=$ms
name_arr[$idx]=$lang_name
idx=$(expr $idx + 1)

rm ./*.o

longest="0"
longest_name=""
longest_idx="0"

idx="0"
for i in ${time_arr[@]}; do
  
  if (( i > longest )); then
    longest=$i
    longest_name=${name_arr[$idx]}
    longest_idx=$idx
  fi

  idx=$(expr $idx + 1)
done

shortest=$longest
shortest_name=$longest_name

idx="0"
for j in ${time_arr[@]}; do
  if (( j < shortest )); then
    shortest=$j
    shortest_name=${name_arr[$idx]}
  fi

  idx=$(expr $idx + 1)
done

printf "$longest_name took the longest to compile with time of \x1b[37;41m$longest\x1b[0m ms.\n"
printf "$shortest_name took the shortest to compile with time of \x1b[37;42m$shortest\x1b[0m ms.\n"

printf "\x1b[37;44mBuild time rankings:\x1b[0m\n"

sorted=("${time_arr[@]}")
IFS=$'\n' sorted_time=($(sort -n <<<"${sorted[*]}"))
unset IFS


rank="1"
for k in ${sorted_time[@]}; do
  lang_name=""

  idx="0"
  for l in ${time_arr[@]}; do
    if (( k == l )); then
      lang_name=${name_arr[$idx]}
    fi

    idx=$(expr $idx + 1)
  done

  echo $rank. $lang_name - $k

  rank=$(expr $rank + 1)
done
