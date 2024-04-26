#!/bin/bash
#SBATCH --job-name=ConsolidateBins
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=4          
#SBATCH --nodes=1                   
#SBATCH --time=12:00:00             
#SBATCH --partition=k2-medpri
#SBATCH --mem-per-cpu=8G
#SBATCH --output=/users/40305431/logs/ConsolidateBins_%j


#CONDA ENV = base(any)
cd path/to/wDir

#makeDir
mkdir -p MetaWrapBins_70_15/All_Bins_70_15

#Copy each samples MAGs to a single folder
cd MetaWrapBinRefinement/SAM/70_15/
for file in * ; do
cp $file ../../../MetaWrapBins_70_15/All_Bins_70_15/SAM_${file}
done
cd ../../../


