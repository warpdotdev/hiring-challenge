# Review: solve.awk

## Summary

This is a clean, correct, and idiomatic AWK solution to the Warp Hiring Challenge. It finds the security code of the longest completed Mars mission in a single pass over a 105K-line pipe-delimited log file.

**Result:** `XRT-421-ZQP` (1,629 days) — verified correct.

---

## Strengths

### Correctness
- The compound filter `!/^#/ && $3 ~ /Mars/ && $4 ~ /Completed/` correctly handles all three requirements in a single pattern: skip comments, match Mars destination, match Completed status.
- Whitespace stripping via `gsub(/ /, "", $6)` handles the inconsistent spacing around pipe delimiters — a common trap in this challenge.
- The `$6 + 0` coercion idiom safely converts the cleaned string to a number for comparison.

### Efficiency
- Single-pass O(n) scan with constant memory. No intermediate storage, no sorting, no multi-pass logic. This is the optimal approach for a max-finding problem over a sequential file.
- AWK's line-at-a-time processing model is well-suited here — the tool matches the problem.

### Readability
- Well-structured header comments document the approach, data format, and usage.
- The `BEGIN`/pattern/`END` structure follows standard AWK conventions.
- Variable names (`max`, `dur`, `code`) are concise but clear in context.

---

## Observations

### Regex matching is loose by design
- `$3 ~ /Mars/` would match a hypothetical destination like "MarsBase" or "Mars Colony". For this dataset, that's fine — "Mars" is the only Mars-related destination. In a production context, anchored matching (`$3 ~ /^ *Mars *$/`) or exact equality after trimming would be more defensive.
- Same applies to `$4 ~ /Completed/` — it would match "Not Completed" if such a status existed.

### No tie-breaking logic
- If two completed Mars missions share the same maximum duration, the script keeps the *first* one encountered (file order). The challenge doesn't specify tie-breaking rules, so this is acceptable.

### Silent on empty results
- If no completed Mars missions exist in the file, the script prints `Answer:` with an empty code and `0 days`. Adding a guard in the `END` block (e.g., `if (max == 0) print "No matching missions found"`) would make it more robust, but is unnecessary for this challenge.

---

## Verdict

This is exactly the kind of solution the challenge is looking for: concise, correct, and demonstrating comfort with Unix text-processing tools. No unnecessary complexity. The AWK one-liner philosophy is respected — the entire solution is 8 lines of logic.

The question becomes: what happens when the problem outgrows a single static file?
