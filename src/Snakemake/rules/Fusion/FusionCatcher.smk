

rule FusionCatcher:
    input:
        ref = "/data/ref_data/fusioncatcher/human_v98/"
        fastq1 = "fastq/RNA/{sample}_R1.fastq.gz"
        fastq2 = "fastq/RNA/{sample}_R2.fastq.gz"
    output:
        fusions = "fusioncatcher_{sample}/final-list_candidate-fusion-genes.hg19.txt"
    params:
        output_dir = "fusioncatcher_{sample}/"
        params = "-p 20 --visualization-sam"
    singularity:
        "/projects/wp4/nobackup/workspace/somatic_dev/singularity/fusioncatcher_1.2.0.simg"
    shell:
        "/opt/fusioncatcher/v1.20/bin/fusioncatcher.py -d {input.ref} -i {input.fastq1},{input.fastq2} -o {params.output_dir} {params.params}"
