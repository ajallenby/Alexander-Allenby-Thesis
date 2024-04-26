#!/bin/bash
#SBATCH --job-name=DereplicateBins
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=6         
#SBATCH --nodes=1                   
#SBATCH --time=12:00:00             
#SBATCH --partition=k2-medpri
#SBATCH --mem-per-cpu=16G
#SBATCH --output=/users/40305431/logs/DereplicateBins_%j


#CONDA ENV = MAGTools
cd path/to/wDir

#Make result folders
mkdir DereplicatedGenomes_70_15
#run dRep
dRep dereplicate DereplicatedGenomes_70_15 -sa 0.95 -g MetaWrapBins_70_15/All_Bins_70_15/*.fa
