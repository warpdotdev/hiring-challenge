awk -F"|" '
  function trim(str) { gsub(/^ +| +$/, "", str); return str }
  /^[^#]/ && NF >= 8 {
    dest = trim($3)
    status = trim($4)
    duration = trim($6) + 0
    code = trim($8)
    if (status == "Completed" && dest == "Mars") {
      if (duration > max_duration) {
        max_duration = duration
        security_code = code
      }
    }
  }
  END { print security_code }
' space_missions.log