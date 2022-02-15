# blast result == 6E_blast.tab
# fasta == ./fasta.d/6E.fasta

n=B2



for blast in `ls *.tab`
do



p0=`echo ${blast##*_}`
p=`echo ${p0%%.tab}`

mkdir -p awk_$p

rm ./awk_$p/$blast\1
cat ./$blast | while read line
do
  name=`echo ${line} | cut -d ' ' -f 2`
  total=`echo ${line} | cut -d ' ' -f 10`
  start=`echo ${line} | cut -d ' ' -f 11`
  end=`echo ${line} | cut -d ' ' -f 12`
 
if [ $start -gt $end ]; then
 echo "${name} ${total} ${end} ${start}" >> ./awk_$p/$blast\1
else
 echo "${name} ${total} ${start} ${end}" >> ./awk_$p/$blast\1
fi 

done

rm ./awk_$p/$blast\2

cat ./awk_$p/$blast\1 | while read line
do 
 name=`echo ${line} | cut -d ' ' -f 1`
  total=`echo ${line} | cut -d ' ' -f 2`
  start=`echo ${line} | cut -d ' ' -f 3`
  end=`echo ${line} | cut -d ' ' -f 4`

start2=`expr ${start} - 499`
end2=`expr ${end} + 499`

if [ ${start2} -lt 0 -a ${end2} -gt ${total} ]; then
 echo ${name} 1 ${start} ${end} ${total} ${total} >> ./awk_$p/$blast\2

elif [ ${start2} -lt 0 ]; then
 echo ${name} 1 ${start} ${end} ${end2}  ${total} >> ./awk_$p/$blast\2

elif [ ${end2} -gt ${total} ]; then
 echo ${name} ${start2} ${start} ${end} ${total} ${total} >> ./awk_$p/$blast\2

else
 echo ${name} ${start2} ${start} ${end} ${end2} ${total} >> ./awk_$p/$blast\2

fi

done



rm ./awk_$p/$blast\.fasta
rm ./awk_$p/$blast\_up.fasta
rm ./awk_$p/$blast\_down.fasta

cat ./awk_$p/$blast\2 | while read line
do
 name=`echo $line | cut -d ' ' -f 1`
 start1=`echo $line | cut -d ' ' -f 2`
 start2=`echo $line | cut -d ' ' -f 3`
 end1=`echo $line | cut -d ' ' -f 4`
 end2=`echo $line | cut -d ' ' -f 5`
 total=`echo $line | cut -d ' ' -f 6`


if [ ${start2} -gt 100 ]; then
seqkit grep -j 24 -nrp "$name" ./$n.fasta | seqkit subseq -j 24 -r ${start1}:${start2} >> ./awk_$p/$blast\.fasta
seqkit grep -j 24 -nrp "$name" ./$n.fasta | seqkit subseq -j 24 -r ${start1}:${start2} >> ./awk_$p/$blast\_up.fasta
fi

totalend=`echo $((end2-end1))`

if [ ${totalend} -gt 100 ]; then
seqkit grep -j 24 -nrp "$name" ./$n.fasta | seqkit subseq -j 24 -r ${end1}:${end2} >> ./awk_$p/$blast\.fasta
seqkit grep -j 24 -nrp "$name" ./$n.fasta | seqkit subseq -j 24 -r ${end1}:${end2} >> ./awk_$p/$blast\_down.fasta
fi

done


done

<<EOF

for i in $blast\.fasta $blast\_up.fasta $blast\_down.fasta
do
seqkit rename $i > $i\2
done

EOF



# bwa-mem2 mem ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta $blast\_up.fasta > $blast\_up.sam
# bwa-mem2 mem ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta $blast\_down.fasta > $blast\_down.sam

# conda activate tools
# samtools sort -o $blast\_up.bam $blast\_up.sam
# bedtools bamtobed -i $blast\_up.bam > $blast\_up.bed

# samtools sort -o $blast\_down.bam $blast\_down.sam
# bedtools bamtobed -i $blast\_down.bam > $blast\_down.bed


# bedtools genomecov -d -3 -i $blast\_up.bed -g ~/database/Pv11_5.2_maskgapdh.genome.bed | awk '$3!=0{print}' > $blast\_up_cov
# bedtools genomecov -d -5 -i $blast\_down.bed -g ~/database/Pv11_5.2_maskgapdh.genome.bed | awk '$3!=0{print}' > $blast\_down_cov





# echo "endedn"



