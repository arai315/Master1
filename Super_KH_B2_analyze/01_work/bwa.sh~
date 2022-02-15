# blast result == 5C_blast_gfp.tab
n# fasta == ./fasta.d/5C.fasta
n=4c

#p=zeo

for blast in `ls *.tab`
do



p0=`echo ${blast##*_}`
echo 'p0 = '$p0
p1=`echo ${blast%%.tab}`
echo 'p1 = '$p1
p=`echo ${p0%%.tab}`
echo 'p = '$p

dir=awk_$p

cd $dir

for g in total up down
do

rm -rf $g
mkdir $g

#conda activate tools

#seqkit rename $p1\_$g.fasta > $p1\_$g\2.fasta 

conda activate bwa

bwa-mem2 mem -t 24 ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta $p1\_$g.fasta > $p\_$g.sam
bwa-mem2 mem -t 24 ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta $p1\_$g\2.fasta > $p\_$g\2.sam

conda activate tools

samtools sort -o $p\_$g.bam $p\_$g.sam
samtools sort -o $p\_$g\2.bam $p\_$g\2.sam
bedtools bamtobed -i $p\_$g.bam > $p\_$g.bed
bedtools bamtobed -i $p\_$g\2.bam > $p\_$g\2.bed

mv $p\_$g.* $g/
mv $p\_$g\2.* $g/

done

cd ../

done
# bedtools genomecov -d -3 -i $blast\_up.bed -g ~/database/Pv11_5.2_maskgapdh.genome.bed | awk '$3!=0{print}' > $blast\_up_cov
# bedtools genomecov -d -5 -i $blast\_down.bed -g ~/database/Pv11_5.2_maskgapdh.genome.bed | awk '$3!=0{print}' > $blast\_down_cov



