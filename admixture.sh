#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-user=rsniderm@ucdavis.edu
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o admixture-stdout-%j.txt
#SBATCH -e admixture-stderr-%j.txt
#SBATCH -J admixture

# mod 2017-04-18

cd ~/fish/results/

sed -i 's/x//g' ~/fish/variants/all.chrom.thin.bim

for K in 2 3 4;
do ~/bin/admixture_linux-1.23/admixture --cv ~/fish/variants/all.chrom.thin.bed $K | tee log${K}.out;
done

