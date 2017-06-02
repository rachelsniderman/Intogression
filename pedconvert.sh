#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsniderman@ucdavis.edu
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o toplink-stdout-%j.txt
#SBATCH -e toplink-stderr-%j.txt
#SBATCH -J toplink

# mod 2017-03-9

module load vcftools/0.1.13

cd ~/fish/variants

zcat ~/fish/variants/all.filtered.vcf.gz |\
vcftools --vcf - \
--plink --out all \
--chrom-map ~/fish/scripts/all.plink-chrom-map.txt

#think markers for ld
~/bin/plink --file all --indep 50 5 2 \
--allow-extra-chr \
-out all.plink.ld

# output thinned ped

~/bin/plink --file all --extract all.plink.ld.prune.in --recode --allow-extra-chr \
--out all.thin
