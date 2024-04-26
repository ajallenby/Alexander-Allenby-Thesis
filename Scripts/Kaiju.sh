#!/bin/bash
#SBATCH --job-name=SAM_Kaiju
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1        
#SBATCH --cpus-per-task=4          
#SBATCH --nodes=1                   
#SBATCH --time=48:05:00             
#SBATCH --partition=k2-himem
#SBATCH --mem-per-cpu=64G
#SBATCH --output=/users/40305431/logs/SAM_Kaiju_%j

#CONDA ENV = Taxonomy
cd path/to/wDir
mkdir -p Kaiju_nr_euk/SAM
kaiju -a greedy -e 5 -m 11 -s 75 -z 25 -t ../kaiju_nr_euk_db/nodes.dmp -f ../kaiju_nr_euk_db/kaiju_db_nr_euk.fmi -i Kaiju_ready_sequences/SAM/SAM_R1_paired.fq -j Kaiju_ready_sequences/SAM/SAM_R2_paired.fq -o Kaiju_nr_euk/SAM/SAM_kaiju.out
echo "Complete"
