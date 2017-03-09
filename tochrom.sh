#!/bin/bash -l
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o tochrom-stdout-%j.txt
#SBATCH -e tochrom-stderr-%j.txt
#SBATCH -J tochrom

cd ~/fish/variants/


R CMD BATCH ~/fish/scripts/tochrom.R

zcat ~/fish/variants/all.filtered.vcf.gz | grep '^#' > header.all.txt
grep '^chr*' ~/fish/variants/all.chrom.vcf | cat header.all.txt - |\
~/bin/vcftools/perl/vcf-sort -c | awk -v OFS="\t" '$1=$1'| \
~/bin/vcftools/bin/vcftools --vcf - --recode --recode-INFO-all --stdout |\
bgzip > ~/fish/variants/all.chrom.vcf.gz


tabix -f -p vcf ~/admixture_mapping/variants/all.chrom.vcf.gz
