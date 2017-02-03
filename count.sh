#!/bin/bash -l
#SBATCH -D /home/rsniderm/fish/scripts/slurm-log/
#SBATCH -o countalligned-stdout-%j.txt
#SBATCH -e countalligned-stderr-%j.txt
#SBATCH -J countaligned

touch ~/fish/results/alignedStats.csv

cd ~/fish/alligned
for file in $(ls | cut -f 1 -d ".")

do {
	MAPPED=$(samtools view -F 0x4 ${file}.bam | cut -f 1 |sort | uniq | wc -l)
	UNMAPPED=$(samtools view -f 0x4 ${file}.bam | cut -f 1 |sort | uniq | wc -l)
	TOTAL=$(samtools view ${file}.bam | cut -f 1 |sort | uniq | wc -l)
	echo ${file},${MAPPED},${UNMAPPED},${TOTAL}

} >> ~/fish/results/alignedStats.csv
done
