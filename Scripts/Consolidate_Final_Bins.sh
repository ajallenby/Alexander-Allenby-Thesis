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

#add stats
head -n 1 MetaWrapBinReassembly/SAM/70_15/reassembled_bins.stats > MetaWrapBins_70_15/MetaWrapBins_70_15_stats.tsv
tail -n +2 "MetaWrapBinReassembly/SAM/70_5/reassembled_bins.stats" | sed "s/^/SAM_/" >> MetaWrapBins_70_15/MetaWrapBins_70_15_stats.tsv


#Copy each samples MAGs to a single folder
cd MetaWrapBinReassembly/SAM/70_15/
for file in * ; do
cp $file ../../../MetaWrapBins_70_15/All_Bins_70_15/SAM_${file}
done
cd ../../../


