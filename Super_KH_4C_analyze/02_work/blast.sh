<< EOF
seqkit fq2fa ../02_qc/4c.fastq > 4c.fasta

conda activate tools
makeblastdb -in ./4c.fasta -dbtype nucl
EOF

conda activate tools

for p in `ls ../donor_vector/`
do
blastn -db ./fasta.d/4c.fasta \
-query ../donor_vector/$p \
-evalue 1.0E-30 \
-word_size 11 \
-num_threads 24 \
-outfmt "6 qseqid sseqid pident nident mismatch gapopen qlen qstart qend slen sstart send evalue" > 4c_blast_${p%%.fa}.tab
done

cat 4c_blast_expression-unit.tab | awk '($9-$8>=2300 && $9==2360){print}' > 4c_blast_expression-unit-2.tab
