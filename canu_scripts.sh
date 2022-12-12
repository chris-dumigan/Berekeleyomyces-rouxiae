#https://github.com/marbl/canu

conda create --name canu
conda install -c conda-forge -c bioconda -c defaults canu

- /home/cdumigan/PM34/pass/combined.fastq.gz


#assembly of low coverage ONT with canu
conda activate canu
canu \
 -p PM34 -d /home/cdumigan/PM34/canu_PM34 \
 genomeSize=30m \
 correctedErrorRate=0.105 \
 -nanopore /home/cdumigan/PM34/pass/combined.fastq.gz

#bps in file script
cat PM34_Nano_combined.fastq | paste - - - - | cut -f 2 | tr -d '\n' | wc -c 


#polca error correction of canu_PM34
conda create -n masurca
conda activate masurca
conda install -c bioconda masurca
conda activate masurca
masurca -h

polca.sh -a /home/cdumigan/PM34/canu_PM34/PM34.contigs.fasta  -r '/home/cdumigan/PM34/short_reads/3_1.fq.gz /home/cdumigan/PM34/short_reads/3_2.fq.gz' -t 16 -m 1G

#Assess BUSCO of PolcaCorrected canu_PM34
conda create -name busco
conda activate busco
conda install -c bioconda busco
conda activate busco

busco -i /home/cdumigan/PM34/canu_PM34/PM34.contigs.fasta.PolcaCorrected.fa \
-l /home/cdumigan/PM34/busco_datasets/sordariomycetes_odb10 -o polca_canu_PM34_busco -m genome -f
