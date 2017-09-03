#!/bin/bash
wget --no-check-certificate -c -r -nd -np -L $1 -P $2
