#!/usr/bin/env bash
set -euo pipefail
: "${PGHOST:?Set PGHOST}"
: "${PGUSER:?Set PGUSER}"
: "${PGDATABASE:?Set PGDATABASE}"
DUMP_FILE="${1:?Usage: restore-postgres.sh path/to/backup.dump}"
[[ -f "$DUMP_FILE" ]] || { echo "Backup file not found: $DUMP_FILE" >&2; exit 1; }
echo "WARNING: restore into $PGDATABASE may replace existing objects."
read -r -p "Type RESTORE to continue: " CONFIRM
[[ "$CONFIRM" == "RESTORE" ]] || { echo "Cancelled."; exit 1; }
pg_restore --clean --if-exists --no-owner --dbname="$PGDATABASE" "$DUMP_FILE"
echo "Restore command completed. Validate the application next."
