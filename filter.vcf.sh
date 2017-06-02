#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=rsniderm@ucdavis.edu
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o filt-stdout-%j.txt
#SBATCH -e filt-stderr-%j.txt
#SBATCH -J filt

# mod 2017-01-11

cd ~/fish/variants/

~/bin/vcftools/bin/vcftools --gzvcf ~/fish/variants/concat.all.vcf.gz \
--recode --recode-INFO-all --maf 0.05 \
--minQ 20 --minGQ 30 \
--min-alleles 2 --max-alleles 2 \
--maxDP 8000 --minDP 30 \
--max-missing 0.7 \
--remove-indels --stdout | bgzip > all.filtered.vcf.gz

tabix -p vcf all.filtered.vcf.gz
