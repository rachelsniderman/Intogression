#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=rsniderm@ucdavis.edu
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o var.summ-stdout-%j.txt
#SBATCH -e var.summ-stderr-%j.txt
#SBATCH -J var.summ

# mod 2017-01-11

zcat ~/fish/variants/concat.all.vcf.gz |\
vcf-annotate --fill-type |\
grep -oP "TYPE=\w+" | sort | uniq -c > ~/fish/results/snpsum.txt
