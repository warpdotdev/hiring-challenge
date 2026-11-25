# Space Mission Log Analysis — Solution

## Answer

**Security Code:** `XRT-421-ZQP`

Mission WGU-0200 | Mars | Completed | 1,629 days | 98.82% success rate | 2065-06-05

---

## AI Agent Prompt

> Analyze the file `space_missions.log` in this directory. It's a pipe-delimited (`|`) log file with ~105K lines. Fields are: Date | Mission ID | Destination | Status | Crew Size | Duration (days) | Success Rate | Security Code.
>
> Skip comment lines (starting with `#`) and metadata lines (starting with `SYSTEM`, `CONFIG`, `CHECKSUM`, or blank).
>
> Fields have inconsistent whitespace around the `|` delimiters — strip leading/trailing spaces when comparing values.
>
> Find the **longest** mission where Destination is "Mars" and Status is "Completed". Return its Security Code (format: ABC-123-XYZ).
>
> Use a single `awk` command to solve this.

---

## Command

```bash
awk -F'|' '!/^#|^SYSTEM|^CONFIG|^CHECKSUM|^$/ {
  dest=$3; gsub(/^[ \t]+|[ \t]+$/, "", dest);
  status=$4; gsub(/^[ \t]+|[ \t]+$/, "", status);
  dur=$6; gsub(/^[ \t]+|[ \t]+$/, "", dur);
  code=$8; gsub(/^[ \t]+|[ \t]+$/, "", code);
  if (dest=="Mars" && status=="Completed" && dur+0 > max+0) { max=dur+0; answer=code }
} END { print answer }' space_missions.log
```

## Approach

1. **Understand the data** — The log file contains ~105K lines with 8 pipe-delimited fields, plus comment/metadata lines to skip and inconsistent whitespace around delimiters.
2. **Filter** — Skip non-data lines (`#`, `SYSTEM`, `CONFIG`, `CHECKSUM`, blank). Match only rows where Destination is `Mars` and Status is `Completed`.
3. **Find the max** — Track the highest Duration value across matching rows and capture the corresponding Security Code.
4. **Handle whitespace** — Use `gsub` to trim leading/trailing spaces from each field before comparison, since spacing is inconsistent.