#!/bin/bash

###############################################################################

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

###############################################################################

java="/usr/local/packages/jdk-8u151/bin/java"

gatk="/usr/local/packages/gatk-4.0.4.0/gatk"

###############################################################################

echo "Starting..."

sample=$1
country=$2

#where do you want results to go (i'd suggest scratch)
out_d=$3

###############################################################################

data_d=/local/projects-t3/p_falciparum/samples/$country/$sample
aux=/local/projects-t3/p_falciparum/auxiliary_files
work_d=$out_d/$country/$sample

mkdir -p $work_d
#cd $work_d

###############################################################################

#if [ $array_num -eq 1 ]
#  then
#    ln -s ../alignments_v24/*recalibrated.bam ../alignments_v24.merged/all_recalibrated.bam
#    bedtools genomecov -ibam ../alignments_v24.merged/all_recalibrated.bam -g $ref > ../alignments_v24.merged/all_recalibrated.coverage
#  else
#    samtools merge -f ../alignments_v24.merged/all_recalibrated.bam ../alignments_v24/*recalibrated.bam
#    bedtools genomecov -ibam ../alignments_v24.merged/all_recalibrated.bam -g $ref > ../alignments_v24.merged/all_recalibrated.coverage
#fi

###############################################################################

cd $data_d/snpcalls_v24/

echo "Starting snp calling..."
#Make gvcf files for each individual sample

$gatk --java-options "-Xmx8G" HaplotypeCaller \
  -R $aux/reference.fa \
  -I $data_d/snpcalls_v24/bam.list \
  -ERC GVCF \
  -O $work_d/diploid.g.vcf

###############################################################################

echo "END SCRIPT"
