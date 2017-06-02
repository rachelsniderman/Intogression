#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsniderman@ucdavis.edu
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o toplink-stdout-%j.txt
#SBATCH -e toplink-stderr-%j.txt
#SBATCH -J toplink
cd ~/fish/variants/

~/bin/plink --file all.chrom.thin --extract all.chrom.plink.ld.prune.in --make-bed --allow-extra-chr \
--out all.chrom.thin
