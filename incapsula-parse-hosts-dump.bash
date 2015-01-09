#!/usr/bin/env bash

wc -l incapsula-host-dump.txt

rm -f incapsula-hosts.txt

nice cat incapsula-host-dump.txt | tr '[A-Z]' '[a-z]' | sort -u \
     > incapsula-hosts.txt

wc -l incapsula-hosts.txt

exit 0
