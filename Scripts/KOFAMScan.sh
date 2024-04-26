#!/bin/bash
#SBATCH --job-name=KOFAMScan
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=8          
#SBATCH --nodes=1                   
#SBATCH --time=24:00:00             
#SBATCH --partition=k2-medpri
#SBATCH --mem-per-cpu=8G
#SBATCH --output=/users/40305431/logs/KOFAMScan_%j


#CONDA ENV = MAGTools
cd path/to/wDir

#download DB
wget https://www.genome.jp/ftp/db/kofam/profiles.tar.gz
wget https://www.genome.jp/ftp/db/kofam/ko_list.gz
gunzip ko_list.gz
tar -xzf profiles.tar.gz
echo "profile: /mnt/scratch2/users/40305431/KOFAM/profiles" > /mnt/scratch2/users/40305431/miniconda3/envs/MAGTools/bin/config.yml
echo "ko_list: /mnt/scratch2/users/40305431/KOFAM/ko_list" >> /mnt/scratch2/users/40305431/miniconda3/envs/MAGTools/bin/config.yml


#run KOFAMScan
cd MetaWrapBins_70_15/

mkdir KOFAMScan
for file in All_Bins_70_15_proteins/*_proteins.faa ; do
binName=$(basename $file _proteins.faa)
echo $binName

if [ -s KOFAMScan/${binName}_mapper.tsv ]; then
echo "Mapper already run"
else
exec_annotation --cpu 8 -f mapper -o KOFAMScan/${binName}_mapper.tsv $file
fi

if [ -s KOFAMScan/${binName}.txt ]; then
echo "Detail already run"
else
exec_annotation --cpu 8 -o KOFAMScan/${binName}.txt $file
fi
done