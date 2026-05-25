#!/bin/bash

awk -F' *\\| *' '$4 == "Completed" &&  $3 == "Mars"' space_missions.log | sort -t'|' -k6,6nr | head -10