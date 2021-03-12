# Twist_RNA
Arriba Star reference files (Needs 8 cores and 45Gb memory): <br>
mkdir /path/to/references <br>
singularity exec -B /path/to/references:/references docker://uhrigs/arriba:2.1.0 download_references.sh GRCh37+RefSeq <br><br>

Star-fusion reference files: <br>
Download from: https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/__genome_libs_StarFv1.9/ <br><br>

FusionCatcher: <br>
See instructions on github or follow commands in: <br>
https://github.com/ndaniel/fusioncatcher/blob/master/data/download-human-db.sh <br>

