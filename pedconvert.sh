#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsniderman@ucdavis.edu
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o toplink-stdout-%j.txt
#SBATCH -e toplink-stderr-%j.txt
#SBATCH -J toplink

# mod 2017-03-9

cd ~/fish/variants

zcat ~/fish/variants/all.filtered.vcf.gz  |\
~/bin/vcftools/bin/vcftools --vcf - \
--plink --out all.filtered

#think markers for ld
~/bin/plink --file all.filtered --indep 50 5 2 \
--allow-extra-chr \
-out all.filtered.plink.ld

# output thinned ped

~/bin/plink --file all.filtered --extract all.filtered.plink.ld.prune.in --recode --allow-extra-chr \
--out all.filter.thin
