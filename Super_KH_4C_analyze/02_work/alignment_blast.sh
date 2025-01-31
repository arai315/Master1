
conda activate tools
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
    for q in 10 1.0 1.0E-10 1.0E-20 1.0E-30
    do
    blastn -db ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta \
    -query $p1\_total.fasta \
    -max_target_seqs 1 \
    -max_hsps 1 \
    -evalue $q \
    -outfmt 6 > $p\_total_alignment_$q.tab
    
    blastn -db ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta \
    -query $p1\_total2.fasta \
    -max_target_seqs 1 \
    -max_hsps 1 \
    -evalue $q \
    -outfmt 6 > $p\_total2_alignment_$q.tab

    blastn -db ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta \
    -query $p1\_total2.fasta \
    -evalue $q \
    -outfmt 6 > $p\_total_all_alignment_$q.tab

    done

    mkdir alignment_blast
    mv *_alignment.tab alignment_blast

    cd ../
done
