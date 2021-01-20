
rule MET_exon_skipping:
    input:
        junction="STAR2/{sample}SJ.out.tab",
    output:
        results="Results/RNA/{sample}/Fusions/{sample}_MET_exon_skipping.txt",
    log:
        "logs/Fusion/MET_exon_skipping.log"
    singularity:
        config["singularity"]["python"]
    shell:
        "(python3.6 src/MET_exon_skipping.py {input.junction} {output.results}) &> {log}"
