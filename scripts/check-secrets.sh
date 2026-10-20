#!/usr/bin/env bash
# S1 check: prove that no password, key or certificate is in the repository.
# Usage: ./scripts/check-secrets.sh   (run from the repository root)
set -u
fail=0

echo "== 1. Ignored files =="
git check-ignore -v .env config/wazuh_indexer_ssl_certs/root-ca.pem 2>/dev/null || true

echo "== 2. Tracked files that look like secrets =="
if git ls-files | grep -E '\.(pem|key|crt|p12|pfx)$|(^|/)\.env$|internal_users\.yml$'; then
  echo "FAIL: secret-looking files are tracked"; fail=1
else
  echo "OK: none tracked"
fi

echo "== 3. Private keys in history =="
if git log -p --all | grep -q 'BEGIN .*PRIVATE KEY'; then
  echo "FAIL: private key found in history"; fail=1
else
  echo "OK: no private keys in history"
fi

echo "== 4. Your real password in history (input is hidden) =="
read -r -s -p "Password to search for (Enter to skip): " P; echo
if [ -n "${P}" ]; then
  n=$(git log -p --all | grep -cF -- "$P" || true)
  echo "Matches: $n"; [ "$n" -eq 0 ] || fail=1
fi
unset P

[ $fail -eq 0 ] && echo "RESULT: clean" || echo "RESULT: problems found"
exit $fail
