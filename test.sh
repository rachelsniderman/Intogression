#!/bin/bash -l
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o test-stdout-%j.txt
#SBATCH -e test-stderr-%j.txt
#SBATCH -J test

#move to fish directory
cd  ~/fish/

#view the contents of the directory
ls

#make a new directory and call it whatever you want
mkdir notes

#move to your new directory
cd ~/fish/notes

#view contents of this new directory
ls

