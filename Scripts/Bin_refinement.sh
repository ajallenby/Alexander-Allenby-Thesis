#!/bin/bash
#SBATCH --job-name=SAM_MetaWrapBinRefinement
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=8          
#SBATCH --nodes=1                   
#SBATCH --time=48:05:00             
#SBATCH --partition=k2-himem
#SBATCH --mem-per-cpu=64G
#SBATCH --output=/users/40305431/logs/SAM_MetaWrapBinRefinement_%j

#CONDA ENV = metawrapenv
cd path/to/wDir

mkdir -p MetaWrapBinRefinement/SAM/70_15
metawrap bin_refinement -o MetaWrapBinRefinement/SAM/70_15/ -t 32 -m 512 -A MetaWrapBinning/SAM/metabat2_bins/ -B MetaWrapBinning/SAM/maxbin2_bins/ -C MetaWrapBinning/SAM/concoct_bins/ -c 70 -x 15

