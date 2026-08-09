# Usage: awk -f find_longest_mars_mission.awk space_missions.log

BEGIN { FS = "|" }

function trim(value) {
  gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
  return value
}

/^[[:space:]]*#/ || NF != 8 { next }

{
  destination = trim($3)
  status = trim($4)
  duration = trim($6)

  if (destination == "Mars" && status == "Completed" && duration ~ /^[0-9]+$/) {
    days = duration + 0
    if (!found || days > longest_duration) {
      found = 1
      longest_duration = days
      security_code = trim($8)
    }
  }
}

END {
  if (found) print security_code
}
