#07/2022
#conda install
python -m pip install funannotate
python -m pip install git+https://github.com/nextgenusfs/funannotate.git
funannotate setup -d $HOME/funannotate_db

echo "export FUNANNOTATE_DB=$HOME/funannotate_db" > /home/cdumigan/miniconda3/envs/funannotate/etc/conda/activate.d/funannotate.sh
echo "unset FUNANNOTATE_DB" > /home/cdumigan/miniconda3/envs/funannotate/etc/conda/deactivate.d/funannotate.sh

#clean Assembly
funannotate clean -i /home/cdumigan/PM34/canu_PM34/PM34.contigs.fasta.PolcaCorrected.fa -o polca_canu_cleaned

#sorting/renaming FASTA headers
funannotate sort -i /home/cdumigan/PM34/funannotate_PM34/polca_canu_funannotate/polca_canu_cleaned -o polca_canu_cleaned_sorted

#RepeatMasking Assembly
funannotate mask -i /home/cdumigan/PM34/funannotate_PM34/polca_canu_funannotate/polca_canu_cleaned_sorted -o polca_canu_cleaned_sorted_masked

#simplist funannotate predict - error, not valid file
funannotate predict -i /home/cdumigan/PM34/funannotate_PM34/polca_canu_funannotate/polca_canu_cleaned_sorted_masked -o polca_canu_funannotate_predict -s "Berkeleyomyces rouxiae" --augustus_species fusarium_graminearum


Run InterProScan (manual install):
funannotate iprscan -i polca_flye_assembly_funannotate -c 2

#SBT file creation
funannotate annotate -i /home/cdumigan/PM34/funannotate_PM34/polca_canu_funannotate/polca_canu_funannotate_predict --cpus 2 --sbt /home/cdumigan/PM34/PM34_polca_flye.sbt

#local run of iprscan
funannotate iprscan -i polca_flye_funannotate -m local --iprscan_path /home/cdumigan/my_interproscan/interproscan-5.57-90.0 --cpus 12
funannotate iprscan -i polca_canu_funannotate_predict -m local -o polca_flye_funannotate_iprscan --iprscan_path /home/cdumigan/my_interproscan/interproscan-5.57-90.0 --cpus 12
#Run antiSMASH:
funannotate remote -i polca_canu_funannotate_predict -m antismash -e cdumigan94@gmail.com

#Annotate Canu Genome:
funannotate annotate -i /home/cdumigan/PM34/funannotate_PM34/polca_canu_funannotate/polca_canu_funannotate_predict \
--iprscan polca_canu_funannotate_iprscan_moved \
--eggnog polca_canu_emapper.emapper.annotations \
--antismash /home/cdumigan/PM34/funannotate_PM34/polca_canu_funannotate/Berkeleyomyces_rouxiae_antismash/Berkeleyomyces_rouxiae.gbk \
--cpus 2 --sbt /home/cdumigan/PM34/PM34_polca_flye.sbt
