# Twist_RNA
Arriba Star reference files (Needs 8 cores and 45Gb memory):
mkdir /path/to/references
singularity exec -B /path/to/references:/references docker://uhrigs/arriba:2.1.0 download_references.sh GRCh37+RefSeq


Star-fusion reference files:
Download from: https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/__genome_libs_StarFv1.9/


FusionCatcher:
See instructions on Fusioncatcher github or follow commands in:
https://github.com/ndaniel/fusioncatcher/blob/master/data/download-human-db.sh
