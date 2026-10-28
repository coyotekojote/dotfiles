---
name: stacking-prs
description: PRをstackedにするときに、base ブランチの付け替えだけで済ませず、GitHub の Stacked PRs（gh stack 拡張）としてスタックに登録する。「stackedにして」「PRを積んで」「スタックにして」「stacked PR」「gh stack」と言われたとき、または依存する複数のPRを順に出すときに使用。
---

# Stacked PRs

base ブランチを手で付け替えただけでは GitHub のスタックにならない。必ず `gh stack` で登録する。登録すると、下のPRがマージされたときに上のPRを GitHub が自動で rebase し、base も付け替えてくれる。

## 準備

```bash
gh stack --help >/dev/null 2>&1 || gh extension install github/gh-stack
```

## 新しくスタックを作る

```bash
gh stack init <下のブランチ>      # trunk はデフォルトブランチ。別の trunk なら --base
# 実装してコミット
gh stack add <次のブランチ>       # 今のスタックの上にブランチを積む
# 実装してコミット
gh stack submit                   # 全ブランチを push し、PRを作ってスタックにつなぐ
```

既にあるブランチをまとめるなら `gh stack init branch1 branch2 branch3`（下から順）。

## 既存のPRをスタックにまとめる

```bash
gh stack link <下のPR> <中のPR> <上のPR>   # PR番号・URL・ブランチ名のどれでもよい
```

既にあるスタックの上に足すなら `gh stack link <スタック番号> <PR>`。

## 決まりごと

- 一番下のPRは trunk（通常 `main`）向きにする。依存する未マージのPRがあるなら、それを一番下に入れる。
- 上の層が依存するコードは、同じ層かそれより下の層に置く。
- マージは下から順にする。真ん中のPRをマージすると、その下のPRもまとめてマージされる。
- 同じリポジトリのブランチだけでスタックを作れる。fork をまたぐことはできない。
- 登録後は `gh pr view <n> --json baseRefName` で base の並びを確かめ、スタックのURLをユーザーに伝える。

## その他のコマンド

| コマンド | 用途 |
|---|---|
| `gh stack view` | スタックを表示する |
| `gh stack rebase` | ローカルで上の層まで順に rebase する |
| `gh stack sync` | リモートとローカルを同期する |
| `gh stack push` | スタックのブランチをまとめて push する |
| `gh stack up` / `down` / `top` / `bottom` | 層の間を移動する |
| `gh stack unstack` | スタックを解除する |

詳しくは https://docs.github.com/ja/pull-requests/get-started/about-stacked-prs を見る。
