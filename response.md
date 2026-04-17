# Re: Mission Log Analysis — Longest Successful Mars Mission

Hello,

Per the challenge in `mission_challenge.md`, the security code for the longest successful Mars mission is:

**`XRT-421-ZQP`**

## Mission Details
- **Date:** 2065-06-05
- **Mission ID:** WGU-0200
- **Destination:** Mars
- **Status:** Completed
- **Crew Size:** 4
- **Duration:** 1629 days
- **Success Rate:** 98.82

## Methodology
Analysis was performed with `awk` against `space_missions.log`, using the following criteria:

1. Skipped front matter, system lines (SYSTEM/CONFIG/CHECKSUM/CHECKPOINT), and commented/review lines by only accepting rows beginning with a `YYYY-MM-DD` date.
2. Split on `|`, then trimmed leading/trailing whitespace from every field.
3. Normalized destination to lowercase and filtered to `mars`.
4. Required `Status == "Completed"`.
5. Defined "successful" as a Success Rate of **≥ 87** (B+ on a standard college grading scale).
6. Selected the record with the maximum Duration (days) value.

## Notes
The provided log is not a clean pipe-delimited export. It contains:
- YAML-style front matter and system/checksum banner lines
- Interspersed comments (`#`) and checkpoint markers
- Heavy inconsistent whitespace inside fields
- Occasional non-data rows that do not begin with a date

A sanitized, reliably parseable version of the dataset has been produced at `actuallyfreakingusableinterplanetaryspacemissionlog.txt` in case it's useful for future work. I'd also recommend wiring this dataset into a proper view so we can avoid one-off log scraping going forward — happy to set that up on request.

Best,
The Analyst
