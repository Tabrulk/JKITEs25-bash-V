#!/bin/bash
# Lihtne serveri tervisekontroll: teenused, kettaruum, veebi kättesaadavus.
# Kasutus: ./teenuste_kontroll.sh
 
KETTA_LIIM=80   # hoiatus, kui kettakasutus on selle protsendi kohal
URL="http://localhost/"
 
echo "=== Serveri kontroll: $(date '+%Y-%m-%d %H:%M:%S') ==="
 
# 1. Teenuste kontroll
for teenus in apache2 mariadb; do
    if systemctl is-active --quiet "$teenus"; then
        echo "[OK]   $teenus töötab"
    else
        echo "[VIGA] $teenus EI tööta (proovi: sudo systemctl start $teenus)"
    fi
done
 
# 2. Kettaruum juurkataloogis
KASUTUS=$(df / | awk 'NR==2 {gsub("%",""); print $5}')
if [ "$KASUTUS" -ge "$KETTA_LIIM" ]; then
    echo "[HOIATUS] Ketas on ${KASUTUS}% täis"
else
    echo "[OK]   Ketas on ${KASUTUS}% täis"
fi
 
# 3. Veebiteenuse kättesaadavus (HTTP staatuskood)
KOOD=$(curl -s -o /dev/null -w '%{http_code}' --max-time 5 "$URL")
if [ "$KOOD" = "200" ] || [ "$KOOD" = "301" ] || [ "$KOOD" = "302" ]; then
    echo "[OK]   $URL vastab (HTTP $KOOD)"
else
    echo "[VIGA] $URL ei vasta korralikult (HTTP $KOOD)"
fi
