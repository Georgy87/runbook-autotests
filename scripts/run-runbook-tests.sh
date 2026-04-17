#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INTELLIJ_MAVEN="/Applications/IntelliJ IDEA.app/Contents/plugins/maven/lib/maven3/bin/mvn"

if [[ -x "$INTELLIJ_MAVEN" ]]; then
    MVN="$INTELLIJ_MAVEN"
elif command -v mvn >/dev/null 2>&1; then
    MVN="mvn"
else
    echo "Maven not found. Install mvn or use IntelliJ IDEA bundled Maven." >&2
    exit 1
fi

cd "$ROOT_DIR"

exec "$MVN" test \
    -Dtest=OperationReportVersionLookupTest,OperationReportFieldsConfigurationTest
