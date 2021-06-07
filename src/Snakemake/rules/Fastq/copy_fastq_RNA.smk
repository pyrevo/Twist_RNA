
rule copy_fastq_RNA:
    input:
        sample_file = "samples.tsv",
    output:
        "fastq_temp/RNA/copy_done.txt",
    shell:
        "python src/copy_fastq.py {input.sample_file}"
