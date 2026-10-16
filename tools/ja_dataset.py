"""Build the Japanese sentence set from Tatoeba, with the macOS tokenizer as the reading oracle.

    curl -sL https://downloads.tatoeba.org/exports/per_language/jpn/jpn_sentences.tsv.bz2 | bunzip2 > jpn.tsv
    python3 tools/ja_dataset.py sample jpn.tsv sample.txt
    swift tools/ja_romaji.swift < sample.txt > tokens.jsonl
    python3 tools/ja_dataset.py build tokens.jsonl ja_sentences.tsv
    python3 tools/ja_dataset.py score ja_sentences.tsv conv.tsv

One output line per sentence: the romaji keys a person would type, a tab, the sentence.
Tatoeba sentences are CC BY 2.0 FR; fetched, not redistributed.
"""

import json
import random
import re
import sys
from pathlib import Path

from romaji_join import typed

# Pure Japanese sentences: kana, kanji, the punctuation people type. Nothing exotic.
PURE = re.compile(r"^[ぁ-んァ-ヶ一-龯々ー、。！？「」『』・…～]+$")
SEED = 7
LIMIT = 30000
MAX_SAMPLE = 45000


def sample(src: str, out: str) -> None:
    seen, rows = set(), []
    for line in Path(src).read_text(encoding="utf-8").splitlines():
        fields = line.split("\t")
        if len(fields) < 3:
            continue
        s = re.sub(r"\s+", " ", fields[2]).strip()
        if not (8 <= len(s) <= 60) or not PURE.match(s) or s in seen:
            continue
        seen.add(s)
        rows.append(s)
    random.Random(SEED).shuffle(rows)
    rows = rows[:MAX_SAMPLE]
    Path(out).write_text("\n".join(rows) + "\n", encoding="utf-8")
    print(f"sample: kept {len(rows)}")


def build(src: str, out: str) -> None:
    seen, kept = set(), []
    for line in Path(src).read_text(encoding="utf-8").splitlines():
        try:
            d = json.loads(line)
        except json.JSONDecodeError:
            continue
        tokens = d.get("tokens") or []
        if not tokens:
            continue
        keys = typed([t["romaji"] for t in tokens])
        if not keys.isascii() or not (4 <= len(keys) <= 100) or keys in seen:
            continue
        seen.add(keys)
        kept.append(f"{keys}\t{d['text']}")
        if len(kept) >= LIMIT:
            break
    Path(out).write_text("\n".join(kept) + "\n", encoding="utf-8")
    print(f"build: kept {len(kept)}")


def score(pairs: str, conv: str) -> None:
    keys, exp = [], []
    for line in Path(pairs).read_text(encoding="utf-8").splitlines():
        fields = line.split("\t")
        if len(fields) == 2:
            # The keys carry no punctuation, so trailing punctuation is not part of the
            # reading: strip it on both sides. Inner punctuation stays and is reported.
            keys.append(fields[0])
            exp.append(fields[1].strip().rstrip("。！？!?…"))
    inner = sum(1 for e in exp if any(ch in e for ch in "、。！？!?"))
    print(f"rows with inner punctuation (beyond exact match for either engine): {inner}")
    rows = [l for l in Path(conv).read_text(encoding="utf-8").splitlines() if "\t" in l]
    print(f"score: {len(exp)} pairs, {len(rows)} result rows")
    n = min(len(exp), len(rows))
    t1 = t8 = 0
    misses = []
    for i in range(n):
        cands = [c for c in rows[i].split("\t") if c]
        if cands and cands[0] == exp[i]:
            t1 += 1
        elif cands:
            misses.append("\t".join((keys[i], cands[0], exp[i])))
        if exp[i] in cands[:8]:
            t8 += 1
    print(f"top1 exact: {t1}/{n} = {100 * t1 / n:.2f}%")
    print(f"top8 contains: {t8}/{n} = {100 * t8 / n:.2f}%")
    out = Path("/tmp/ja_misses.tsv")
    out.write_text("\n".join(misses[:200]), encoding="utf-8")
    print(f"first {min(len(misses), 200)} misses -> {out}")


if __name__ == "__main__":
    if sys.argv[1] == "sample":
        sample(sys.argv[2], sys.argv[3])
    elif sys.argv[1] == "build":
        build(sys.argv[2], sys.argv[3])
    elif sys.argv[1] == "score":
        score(sys.argv[2], sys.argv[3])
    else:
        raise SystemExit("usage: ja_dataset.py sample|build|score ...")
