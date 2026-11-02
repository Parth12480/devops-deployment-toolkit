#!/usr/bin/env bash
set -euo pipefail
: "${PGHOST:?Set PGHOST}"
: "${PGUSER:?Set PGUSER}"
: "${PGDATABASE:?Set PGDATABASE}"
BACKUP_DIR="${BACKUP_DIR:-./backups}"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$BACKUP_DIR"
umask 077
pg_dump --format=custom --no-owner --file="$BACKUP_DIR/$PGDATABASE-$STAMP.dump"
echo "Database backup created: $BACKUP_DIR/$PGDATABASE-$STAMP.dump"
