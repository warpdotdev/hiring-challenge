#!/usr/bin/env bash

awk -F'|' '
/^[[:space:]]*#/ {next}
index($0, "|")==0 {next}
{
  dest=$3; status=$4; duration=$6; code=$8;
  gsub(/^[[:space:]]+|[[:space:]]+$/, "", dest);
  gsub(/^[[:space:]]+|[[:space:]]+$/, "", status);
  gsub(/^[[:space:]]+|[[:space:]]+$/, "", duration);
  gsub(/^[[:space:]]+|[[:space:]]+$/, "", code);
  if (dest=="Mars" && status=="Completed" && duration+0>maxdur) {
    maxdur=duration+0;
    maxcode=code;
  }
}
END {print maxcode}
' space_missions.log
