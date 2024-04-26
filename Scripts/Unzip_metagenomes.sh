#!/bin/bash
#SBATCH --job-name=Unzip_metagenomes
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=4          
#SBATCH --nodes=1                   
#SBATCH --time=03:00:00             
#SBATCH --partition=k2-hipri
#SBATCH --mem-per-cpu=8G
#SBATCH --output=/users/40305431/logs/Unzip_metagenomes_%j

#CONDA ENV = base(any)
cd path/to/wDir

#Check delivery
md5sum path/to/RawData.tar > md5onArrival.txt
tar -xvf path/to/RawData.tar

#make directories
mkdir -p Raw_sequences
mkdir -p Raw_sequences/SAM

#gunzip
gunzip -c path/to/SAM_2.fq.gz > Raw_sequences/SAM/SAM_R2.fq
gunzip -c path/to/SAM_1.fq.gz > Raw_sequences/SAM/SAM_R1.fq
