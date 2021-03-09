
rule imbalance :
    input:
        bams = " ".join(["STAR2/" + s + "Aligned.sortedByCoord.out.bam" for s in config["RNA_Samples"]]),
    output:
        imbalance_all = "Results/RNA/Imbalance/imbalance_all_gene.txt",
        imbalance = "Results/RNA/Imbalance/imbalance_called_gene.txt",
    logs:
        "logs/Fusions/imbalance.log"
    container:
        config["singularity"].get("python", config["singularity"].get("default", ""))
    shell:
        "(python src/Imbalance.py {input.bams}) &> {log}"
