#!/bin/bash

if [ -z "$1" ]; then
    echo "Viga: logifaili nimi puudub."
    echo "Kasutus: $0 <logifail>"
    exit 1
fi

LOGFILE="$1"

# Kas fail eksisteerib?
if [ ! -f "$LOGFILE" ]; then
    echo "Viga: Faili '$LOGFILE' ei leitud."
    exit 1
fi

# Koguarv ridu
TOTAL=$(wc -l < "$LOGFILE")
echo "Logiridade koguarv: $TOTAL"

# ERROR ridade arv
ERROR_COUNT=$(grep -c "ERROR" "$LOGFILE")
echo "ERROR ridade arv: $ERROR_COUNT"

# WARNING ridade arv
WARNING_COUNT=$(grep -c "WARNING" "$LOGFILE")
echo "WARNING ridade arv: $WARNING_COUNT"

# Kõik ERROR read
if [ "$ERRORS" -gt 0 ]; then
    grep "ERROR" "$LOGFILE"
else
    echo "(ERROR ridu ei leitud)"
fi
 
