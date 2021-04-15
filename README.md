# Twist_RNA
Arriba Star reference files (Needs 8 cores and 45Gb memory):<br>
mkdir /path/to/references<br>
singularity exec -B /path/to/references:/references docker://uhrigs/arriba:2.1.0 download_references.sh GRCh37+RefSeq


Star-fusion reference files:<br>
Download from: https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/__genome_libs_StarFv1.9/


FusionCatcher:<br>
See instructions on Fusioncatcher github or follow commands in:<br>
https://github.com/ndaniel/fusioncatcher/blob/master/data/download-human-db.sh


Run the pipeline in Uppsala: <br>
git clone https://github.com/clinical-genomics-uppsala/Twist_RNA.git . <br>
git checkout develop <br>
module add snakemake<br>
module add slurm-drmaa<br>
module add singularity<br>
snakemake -p -j 1 --drmaa "-A wp1 -p core -n 1 -t 2:00:00 "  -s ./src/Snakemake/rules/Twist_RNA/Twist_RNA_yaml.smk<br>
snakemake -p -j 80 --drmaa "-A wp1 -p core -n {cluster.n} -t {cluster.time}" -s ./Twist_RNA.smk --use-singularity --singularity-args "--bind /data --bind /beegfs-storage --bind /scratch " --cluster-config Config/Slurm/cluster.json
