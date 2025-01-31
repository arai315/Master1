conda activate tools
for blast in `ls *tab`
do
    p0=`echo ${blast##*_}`
    echo 'p0 = '$p0
    p1=`echo ${blast%%.tab}`
    echo 'p1 = '$p1
    p=`echo ${p0%%.tab}`
    echo 'p = '$p

    dir=awk_$p
    cd $dir
    cd up
    bedtools genomecov -d -3 -i $p\_up.bed -g ~/database/Pv11_5.2_maskgapdh.genome.bed | awk '$3!=0{print}' > $p\_up.cov
    bedtools genomecov -d -3 -i $p\_up2.bed -g ~/database/Pv11_5.2_maskgapdh.genome.bed | awk '$3!=0{print}' > $p\_up2.cov

    cd ../down
    bedtools genomecov -d -5 -i $p\_down.bed -g ~/database/Pv11_5.2_maskgapdh.genome.bed | awk '$3!=0{print}' > $p\_down_cov
    bedtools genomecov -d -5 -i $p\_down2.bed -g ~/database/Pv11_5.2_maskgapdh.genome.bed | awk '$3!=0{print}' > $p\_down2_cov

    cd ../../
done
