#Nanopore Guppy GPU basecalling on Windows 10
#Download Guppy-GPU for Windows 10 from ONT Communtity website

#Cuda-11 Download
#If you don’t already have, you will get a prompt to install virtual studio -do this as it is required for Cuda-11

#https://developer.nvidia.com/cuda-11.0-download-archive

#First we need to create a folder on out local disk for the Fast5 files that the Nanopore generates.
mkdir C:\my_folder\reads

#Then we need to make an output folder for the basecalled reads
mkdir C:\output_folder\basecall

#Windows Command Prompt Script to run the GPU version of Guppy GPU with Superior Basecalling algorithm
"C:\Program Files\OxfordNanopore\ont-guppy\bin\guppy_basecaller.exe" ^
-c dna_r9.4.1_450bps_sup.cfg ^
--input_path C:\my_folder\reads ^
--save_path C:\output_folder\basecall ^
--device auto
