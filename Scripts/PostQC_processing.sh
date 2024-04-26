#!/bin/bash
#SBATCH --job-name=PostQC_Processing
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=1          
#SBATCH --nodes=1                   
#SBATCH --time=12:00:00             
#SBATCH --partition=k2-medpri
#SBATCH --mem-per-cpu=32G
#SBATCH --output=/users/40305431/logs/PostQC_Processing_%j

#CONDA ENV = base(any)
cd path/to/wDir/Trimmed_sequences/

#rename reads
echo "renaming reads..."
for file in */*.fq ; do
name=${file%%/*}
cat $file | tr " " "_" | sed "s/:N:.*//" | sed "s/^@/>${name}:/" > tmp
cat tmp > $file
rm tmp
done
#combine unpaired reads
echo "Compining unpaired reads..."

for file in * ; do
name=${file%%/*}
cat ${file}/*_unpaired.fq > ${file}/${file}_combined_unpaired.fq
done

#Make reads Kaiju ready
echo "Making reads Kaiju ready..."

cd ..
mkdir -p Kaiju_ready_sequences

#Forward reads
for file in Trimmed_sequences/*/*R1_paired.fq ; do
outFile=${file/Trimmed_sequences/Kaiju_ready_sequences}
outDir=$(dirname $outFile)
mkdir -p $outDir
cat $file | sed "s/_1$/ 1/" > $outFile
done

#Reverse reads
for file in Trimmed_sequences/*/*R2_paired.fq ; do
outFile=${file/Trimmed_sequences/Kaiju_ready_sequences}
outDir=$(dirname $outFile)
mkdir -p $outDir
cat $file | sed "s/_2$/ 2/" > $outFile
done

#Make reads MetaWrapReady
echo "Making reads MetaWrap ready..."

mkdir -p MetaWrap_ready_sequences
#Forward reads
for file in Trimmed_sequences/*/*R1_paired.fq ; do
outFileIntermediate=${file/Trimmed_sequences/MetaWrap_ready_sequences}
outFile=${outFileIntermediate/R1_paired.fq/paired_1.fastq}
outDir=$(dirname $outFile)
mkdir -p $outDir
cat $file | sed "s/_1$//" > $outFile
done

#Reverse reads
for file in Trimmed_sequences/*/*R2_paired.fq ; do
outFileIntermediate=${file/Trimmed_sequences/MetaWrap_ready_sequences}
outFile=${outFileIntermediate/R2_paired.fq/paired_2.fastq}
outDir=$(dirname $outFile)
mkdir -p $outDir
cat $file | sed "s/_2$//" > $outFile
done





