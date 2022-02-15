conda activate tools
blastn -db ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta \
-query ../4C_vector_blastn_down500.fa \
-max_target_seqs 1 \
-max_hsps 1 \
-evalue 1.0E-30 \
-outfmt 6 > 4C_vector_down_pv11maskgapdh_blastn.txt

blastn -db ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta \
-query ../4C_vector_blastn_up500.fa \
-max_target_seqs 1 \
-max_hsps 1 \
-evalue 1.0E-30 \
-outfmt 6 > 4C_vector_up_pv11maskgapdh_blastn.txt

blastn -db ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta \
-query ../4C_vector_blastn_500.fa \
-max_target_seqs 1 \
-max_hsps 1 \
-evalue 1.0E-30 \
-outfmt 6 > 4C_vector_pv11maskgapdh_blastn.txt

grep -i -f 4c_gapgfp_fulllength_blast_readnames 4C_vector_down_pv11maskgapdh_blastn.txt > 4C_fulllength_down_pv11maskgapdh_blastn.txt
grep -i -f 4c_gapgfp_fulllength_blast_readnames 4C_vector_up_pv11maskgapdh_blastn.txt > 4C_fulllength_up_pv11maskgapdh_blastn.txt
grep -i -f 4c_gapgfp_fulllength_blast_readnames 4C_vector_pv11maskgapdh_blastn.txt > 4C_fulllength_pv11maskgapdh_blastn.txt


blastn -db ~/database/pv11_5.2.masked/Pv11_5.2_maskgapdh.fasta \
-query ../4C_vector_blastn_up500.fa \
-outfmt 6 > 4C_vector_up_pv11maskgapdh_blastn2.txt
