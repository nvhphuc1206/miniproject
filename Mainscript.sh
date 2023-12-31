#!/usr/bin/bash


########################  Trimming and filtering  ########################
## Fastp 
# 1.Variable
# Input
input1=$1
input2=$2
# Output directory and output
output_dir=$3
output1=$output_dir"/output1.fastq.gz"
output2=$output_dir"/output2.fastq.gz"
# Arguments filter
arg1=$7
arg2=$8
arg3=$9
arg4=$10
arg5=$11

# 2.Running
# Create directory to save the fastp results 
mkdir -p $output_dir
# Print the version of Fastp
conda run -n fastp fastp --version
# Run fastp with target arguments
conda run -n fastp fastp \
-i $input1 \
-I $input2 \
-o $output1 \
-O $output2 \
$arg1 \
$arg2 \
$arg3 \
$arg4 \
$arg5

echo "Complete trimming step"



########################  Re-Quality Control  ########################
## FastQC 
# 1.Variable
fastqc_output_dir=$4

# 2.Running 
bash Module1_QC.sh $output1 $output2 $fastqc_output_dir



########################  Assembly  ########################
## GetOrganelle
# 1.Variable
assembly_output_dir=$5

# 2.Running
bash Module3_Assembly.sh $output1 $output2 $assembly_output_dir



########################  Visualizing Assembly Sequence ########################
## Bandage
# 1.Variable
bandage_output_dir=$6

# 2.Running
bash Module4_Visualize_assembly.sh $assembly_output_dir/*graph.fastg $bandage_output_dir


##################   Finished   ##################
echo "Pipeline is finished"