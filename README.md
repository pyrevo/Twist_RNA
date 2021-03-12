# Twist_RNA
Arriba Star index files (Needs 8 cores and 45Gb memory): <br>
mkdir /path/to/references <br>
singularity exec -B /path/to/references:/references docker://uhrigs/arriba:2.1.0 download_references.sh GRCh37+RefSeq <br>

