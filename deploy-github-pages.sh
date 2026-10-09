#!/usr/bin/env bash
# Publish this folder to GitHub Pages as repo "valerie-workout".
# Needs: `gh auth login` done first (gh is not logged in on the box yet).
set -euo pipefail
cd "$(dirname "$0")"
gh auth status >/dev/null
OWNER=$(gh api user -q .login)
[ -d .git ] || { git init -q -b main; }
touch .nojekyll
git add index.html .nojekyll
git -c user.name="$OWNER" -c user.email="$OWNER@users.noreply.github.com" commit -qm "Workout app" || true
gh repo view "$OWNER/valerie-workout" >/dev/null 2>&1 || gh repo create valerie-workout --public --source=. --remote=origin
git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$OWNER/valerie-workout.git"
git push -u origin main
gh api -X POST "repos/$OWNER/valerie-workout/pages" -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 || true
URL="https://$OWNER.github.io/valerie-workout/"
echo "Waiting for $URL ..."
for i in $(seq 1 30); do code=$(curl -s -o /dev/null -w "%{http_code}" "$URL"); [ "$code" = 200 ] && { echo "LIVE: $URL"; exit 0; }; sleep 10; done
echo "Pages not live yet; check repo Settings > Pages. URL will be $URL"
