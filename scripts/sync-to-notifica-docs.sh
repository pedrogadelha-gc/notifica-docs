#!/usr/bin/env bash
# Sincroniza docs/ (deste repo) para o repositório pessoal
# pedrogadelha-gc/notifica-docs, que pode ser linkado direto no Mintlify
# sem depender de acesso de owner na organização.
#
# Uso: docs/scripts/sync-to-notifica-docs.sh [branch]
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SOURCE_DIR="$REPO_ROOT/docs"
TARGET_REPO="pedrogadelha-gc/notifica-docs"
TARGET_BRANCH="${1:-main}"

if [ ! -f "$SOURCE_DIR/docs.json" ]; then
  echo "docs.json não encontrado em $SOURCE_DIR — abortando." >&2
  exit 1
fi

if ! command -v gh >/dev/null; then
  echo "gh CLI não encontrado no PATH." >&2
  exit 1
fi

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

echo "Clonando $TARGET_REPO..."
gh repo clone "$TARGET_REPO" "$WORKDIR" -- -q

cd "$WORKDIR"
git checkout -B "$TARGET_BRANCH" >/dev/null 2>&1 || true
git config user.name "$(git -C "$REPO_ROOT" config user.name)"
git config user.email "$(git -C "$REPO_ROOT" config user.email)"

rsync -a --delete --exclude ".git" "$SOURCE_DIR/" "$WORKDIR/"

git add -A

if git diff --cached --quiet; then
  echo "Nada novo pra sincronizar."
  exit 0
fi

SRC_SHA="$(git -C "$REPO_ROOT" rev-parse --short HEAD)"
SRC_BRANCH="$(git -C "$REPO_ROOT" rev-parse --abbrev-ref HEAD)"
DIRTY=""
git -C "$REPO_ROOT" diff --quiet -- docs || DIRTY=" (com alterações não commitadas em docs/)"

git commit -q -m "sync: docs/ @ notifica#${SRC_SHA} (${SRC_BRANCH})${DIRTY}"
git push -q origin "$TARGET_BRANCH"

echo "Sincronizado com https://github.com/$TARGET_REPO (branch $TARGET_BRANCH)."
