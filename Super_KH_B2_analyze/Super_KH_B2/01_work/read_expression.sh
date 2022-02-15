rm B2_read_containing_expression_unit.fasta
cat B2_blast_expression-unit-2.name | while read line
do
    seqkit grep -j 24 -nrp "$line" B2.fasta >> B2_read_containing_expression_unit.fasta
done
