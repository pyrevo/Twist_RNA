# Twist_RNA
Arriba Star reference files (Needs 8 cores and 45Gb memory):
mkdir /path/to/references
singularity exec -B /path/to/references:/references docker://uhrigs/arriba:2.1.0 download_references.sh GRCh37+RefSeq


Star-fusion reference files:
Download from: https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/__genome_libs_StarFv1.9/


FusionCatcher:
See instructions on Fusioncatcher github or follow commands in:
https://github.com/ndaniel/fusioncatcher/blob/master/data/download-human-db.sh


Run the pipeline in Uppsala:
git clone  .
module add snakemake
module add slurm-drmaa
module add singularity
snakemake -p -j 80 --drmaa "-A wp1 -p core -n {cluster.n} -t {cluster.time}" -s ./Twist_RNA.smk --use-singularity --singularity-args "--bind /data --bind /beegfs-storage --bind /scratch " --cluster-config Config/Slurm/cluster.json
