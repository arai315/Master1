
conda activate tools
bedtools genomecov -d -3 -i pIZPvGAPDHpro-AcGFP1-Kanx2_up_expression_x0.bed -g ~/database/Pv11_5.2_maskgapdh.genome.bed | awk '$3!=0{print}' > pIZPvGAPDHpro-AcGFP1-Kanx2_up_expression_x0.cov
bedtools genomecov -d -5 -i pIZPvGAPDHpro-AcGFP1-Kanx2_down_expression_x0.bed -g ~/database/Pv11_5.2_maskgapdh.genome.bed | awk '$3!=0{print}' >  pIZPvGAPDHpro-AcGFP1-Kanx2_down_expression_x0.cov

