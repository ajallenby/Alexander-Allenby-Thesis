#!/bin/bash
#SBATCH --job-name=SAM_MetaWrapBinReassembly
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=8          
#SBATCH --nodes=1                   
#SBATCH --time=48:05:00             
#SBATCH --partition=k2-himem
#SBATCH --mem-per-cpu=64G
#SBATCH --output=/users/40305431/logs/SAM_MetaWrapBinReassembly_%j

#CONDA ENV = metawrapenv
cd path/to/wDir

mkdir -p MetaWrapBinReassembly/SAM

metawrap reassemble_bins \
 -o MetaWrapBinReassembly/SAM/70_15 \
 -1 MetaWrap_ready_sequences/SAM/SAM_paired_1.fastq \
 -2 MetaWrap_ready_sequences/SAM/SAM_paired_2.fastq \
 -t 32 -m 512 -c 70 -x 15 \
 -b DereplicatedGenomes_70_15/SAM*