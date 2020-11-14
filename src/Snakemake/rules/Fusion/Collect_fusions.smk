

rule Collect_fusions:
    input:
        bed = config["bed"]["bedfile"],
        arriba = "Arriba_results/{sample}.fusions.tsv",
        starfusion = "Results/RNA/{sample}/Fusions/star-fusion.fusion_predictions.abridged.tsv",
        fusioncatcher = "Results/RNA/{sample}/Fusions/FusionCatcher_final-list_candidate-fusion-genes.hg19.txt"
    output:
        fusions = "Results/RNA/{sample}/Fusions/Fusions.tsv"
    singularity:
        config["singularity"]["python"]
    shell:
        "python3.6 src/Fusion_genes.py {input.bed} {input.arriba} {input.starfusion} {input.fusioncatcher} {output.fusions}"
