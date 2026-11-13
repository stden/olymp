#!bin/sh
for f in gen_rand gen_tree gen_line gen_mags gen_mags_zero \
 armor_ak_3k armor_ak_4k armor_ik_chk; do
  rm $f || rm $f.exe
done
rm ??
rm ??.a
