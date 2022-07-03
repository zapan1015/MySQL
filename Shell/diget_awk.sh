#!/usr/bin/awk -f
 
BEGIN {
    OFS="\t";
};
NR>3 {
    {
        # Assign the query fingerprint to a variable
        query="";
        for(i=5;i<NF;++i){
            query=query $i "";
        }
        query=query $NF;
 
        gsub("T","",$2);
    }
    {
        # Convert fingerprint to MD5 checksum
        hash="";
        cmd="echo -n \047"query"\047 | md5sum";
        checksum=((cmd | getlineline) > 0 ? line : "FAILED");
        close(cmd);
        sub(/ .*/,"",checksum);
    }
    print $2,toupper(checksum),$4
}
