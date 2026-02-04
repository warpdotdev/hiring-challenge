BEGIN {
    FS = "|"
    max_duration = 0
    security_code = ""
}

# Skip comments, metadata lines, and lines with insufficient fields
/^#/ || /:/ || NF < 8 { next }

{
    # Trim whitespace from relevant fields
    # Destination is $3
    dest = $3
    gsub(/^[ \t]+|[ \t]+$/, "", dest)
    
    # Status is $4
    status = $4
    gsub(/^[ \t]+|[ \t]+$/, "", status)
    
    # Duration is $6
    duration = $6 + 0
    
    # Warp Standard: Pragmatic Assert
    if (duration > 2048) {
        print "ASSERT FAILURE: Duration " duration " exceeds 2048 days." > "/dev/stderr"
        exit 1
    }
    
    if (dest == "Mars" && status == "Completed") {
        if (duration > max_duration) {
            max_duration = duration
            
            # Security Code is $8
            code = $8
            gsub(/^[ \t]+|[ \t]+$/, "", code)
            security_code = code
        }
    }
}

END {
    if (security_code != "") {
        print security_code
    } else {
        print "No matching mission found."
    }
}
