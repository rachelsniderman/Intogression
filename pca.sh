#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsniderman@ucdavis.edu
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o pca-stdout-%j.txt
#SBATCH -e pca-stderr-%j.txt
#SBATCH -J pca

# mod 2017-03-10

cd ~/fish/variants/

#pca

~/bin/plink --file all.thin \
--pca header --allow-extra-chr --out ~/fish/results/pca

