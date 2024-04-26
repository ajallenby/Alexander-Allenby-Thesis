#!/bin/bash
#SBATCH --job-name=SAM_trim
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=4          
#SBATCH --nodes=1                   
#SBATCH --time=08:05:00             
#SBATCH --partition=k2-medpri
#SBATCH --mem-per-cpu=32G
#SBATCH --output=/users/40305431/logs/SAM_trim_%j

#CONDA ENV = QualityControl
cd path/to/wDir

mkdir -p Trimmed_sequences/
mkdir -p Trimmed_sequences/SAM

trimmomatic PE -phred33 \
 -trimlog Trimmed_sequences/SAM/SAM_trimlog.txt \
 Raw_sequences/SAM/SAM_R1.fq \
 Raw_sequences/SAM/SAM_R2.fq \
 Trimmed_sequences/SAM/SAM_R1_paired.fq \
 Trimmed_sequences/SAM/SAM_R1_unpaired.fq \
 Trimmed_sequences/SAM/SAM_R2_paired.fq \
 Trimmed_sequences/SAM/SAM_R2_unpaired.fq \
 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:60