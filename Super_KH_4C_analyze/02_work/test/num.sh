ls 4c_blast_* | nl -w 02 -nrz -s "_" > name.dat

cat name.dat | while read l
do 
touch $l
p=`echo ${l#_*}`
mv $p $l
done
