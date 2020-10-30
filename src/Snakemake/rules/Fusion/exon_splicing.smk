

rule exon_skipping :
    input:
        bed = config["bed"]["bedfile"],
        junctions = ["STAR/" + s + "SJ.out.tab" for s in config["RNA_Samples"]]
    output:
        exon_skipped = "Results/RNA/Exon_skipping/exon_skipping.txt"
    run:
        import subprocess
        subprocess.call("python src/exon_splicing.py " + input.bed + " " + " ".join(input.junctions), shell=True)
