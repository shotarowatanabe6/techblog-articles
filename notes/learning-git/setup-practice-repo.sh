#!/usr/bin/env bash
# ハンズオン用の使い捨て練習リポジトリを作る。
# 壊すことが目的なので、毎回まっさらに作り直してよい。
#
# 使い方: bash notes/learning-git/setup-practice-repo.sh <作成先ディレクトリ>
#   例:   bash notes/learning-git/setup-practice-repo.sh "$SCRATCHPAD/practice"
#
# 注意: このリポジトリ(techblog-articles)を作成先に指定しないこと。
#       既存ディレクトリが指定された場合は中断する（消さない）。

set -euo pipefail

target="${1:-}"
if [ -z "$target" ]; then
  echo "usage: $0 <target-dir>" >&2
  exit 1
fi

if [ -e "$target" ]; then
  echo "error: '$target' はすでに存在する。消すかどうかは自分で判断すること。" >&2
  exit 1
fi

mkdir -p "$target"
cd "$target"

git init -q -b main
git config user.name  "practice"
git config user.email "practice@example.com"
# 検証の再現性のため、このリポジトリ限定で署名とhookを無効化しておく
git config commit.gpgsign false

printf 'line 1\n' > a.txt
git add a.txt
git commit -q -m "1つ目: a.txt を追加"

printf 'line 1\nline 2\n' > a.txt
printf 'hello\n' > b.txt
git add .
git commit -q -m "2つ目: a.txt を編集し b.txt を追加"

mkdir -p dir
printf 'nested\n' > dir/c.txt
git add dir
git commit -q -m "3つ目: サブディレクトリを追加（treeの入れ子を作る）"

echo "作成した: $target"
echo
git log --oneline --graph --decorate
