#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=rsniderm@ucdavis.edu
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log
#SBATCH -o cat.var-stdout-%j.txt
#SBATCH -e cat.var-stderr-%j.txt
#SBATCH -J cat.var

# mod 2017-01-11

vcf-concat $(ls -1 ~/fish/variants/output/*.vcf | perl -pe 's/\n/ /g') |\
bgzip -c > ~/fish/variants/concat.all.vcf.gz

tabix -f -p vcf ~/fish/variants/concat.all.vcf.gz
