#!/bin/bash -l
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o index-stdout-%j.txt
#SBATCH -e index-stderr-%j.txt
#SBATCH -J index

~/bin/bwa-0.7.12/bwa index ~/reference/heteroclitus-3.0.2_genomic.fna.gz

