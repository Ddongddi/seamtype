# How it decides, and accuracy

[← README](../README.en.md) · [한국어](how-it-works.md) · English

## The order

Locally, in this order. A keystroke's preview takes at most ~3 ms and a word's final decision
~7 ms, even 70 letters into a phrase.

1. **Your corrections** (made twice, see [learning](usage.en.md#undo-after-commit-and-learning)) always win
   (`lexicon.json`).
2. **Mixed words** are split, in an app set to Strict too.
   - English + particle, when the end is a Korean particle or ending and reading it that way beats
     reading the whole token as Hangul or as English. The more common the English word (or an
     acronym or name typed in capitals) and the less the whole reads as a Korean word, the likelier
     the split: `githubdp` → `github에`, `UIrkxdmsrjs` → `UI같은건`, `formdptj` → `form에서` (래그 is
     no word). `gosemfdmf` stays `핸들을`.
   - A single English letter + particle, as in a variable name: `xdp` → `x에`, `Xfmf` → `X를`. Not
     `도`/`나` after a lowercase letter, which are common English endings (`heh`, `tsk`); a capital
     gives `X도`.
   - English + Korean word, when the front is a known English word (or a name typed with capitals)
     and the back is in the Korean word list. When the whole token spells nothing like English, any
     Hangul of common syllables splits too. `hellodnjfem` → `hello월드`, `githubtjqj` → `github서버`
   - Korean, then an English word: `dhsmfdmsgoogledptj` → `오늘은google에서`. The Korean goes in
     and the rest keeps composing.
   - With Japanese on:
     - English + one case particle, compared the same way with reading the whole as kana:
       `githubde` → `githubで`, `APIwo` → `APIを`, `redde` → `redで`. What reads naturally as
       Japanese stays kana (`sitede` → `してで`).
     - Japanese after Korean: `dlfurrireki` → `이력りれき` (Space for `履歴`)
     - a Korean particle or word after Japanese: `rirekifmf` → `りれき를`,
       `kyouhaehtlfkrdms` → `きょうは도시락은`. The Japanese part is committed on the spot, so with
       live conversion it goes in as `履歴를`, `今日は도시락은`.
     - These split only when the Korean side breaks, so ordinary Japanese phrases stay whole.
3. **Rules:** shift on a letter with no shifted jamo (`Hello`, `API`) is English.
4. **Heuristic:** the keys are scored per keystroke in all three languages, plus a nudge toward the
   previous word's language.
   - English: character trigrams, and a floor for words in the SCOWL list, by how common they are
   - Korean: 2-set syllable frequencies, and a floor for words seen in Korean text
   - Japanese: romaji → kana trigrams, with English words inside the phrase split out
   - The nudge is weaker when the keys are a word of another language and not of the previous one,
     which is someone switching language.
   - A known English word needs a clear Japanese win before it turns into kana.

Kanji come from the conversion engine of macOS's Japanese input (libmecabra), with the top
candidate re-picked by a character trigram model of written Japanese. So variant kanji like `髙`
(`たか`, `たかはし` → `髙橋`), English spellings of names (`とぅいっち` → `Twitch`) and completions
of a partial reading (`ゆーちゅ` → `YouTube`, after the top candidate) come up as in the system's
input. Seamtype remembers what you pick for each reading and puts it first next time. The engine is
private to macOS, so where it can't be loaded the app's own
[AzooKey](https://github.com/azooKey/AzooKeyKanaKanjiConverter) dictionary converter stands in.

## Held-out results

2,011 English words, 1,987 Korean words and 2,000 Japanese phrases from held-out sentences,
never used to build the models (`tools/prepare.sh`):

| | Japanese off (en/ko) | Japanese on (en/ko/ja) |
| --- | --- | --- |
| Accuracy | 99.80% | 99.48% |

That set counts every word once and seldom puts it after the other language. But real text is
mostly its most frequent words, and switching language mid-sentence is the point, so the 10,000
most frequent English and Korean words are also scored after each kind of word
(`tools/eval_context.py`, Japanese on). Wrong among the top 1,000 / top 10,000:

| | after nothing | after the same language | after the other | after Japanese |
| --- | --- | --- | --- | --- |
| Korean words | 9 / 42 | 2 / 16 | 16 / 159 | 9 / 46 |
| English words | 2 / 47 | 0 / 21 | 8 / 71 | 2 / 86 |

Before the SCOWL and Korean word lists and the switch-aware nudge, that was 94 / 785 in all; now
it is 48 / 488. These lists were used while tuning those rules, so they're a guide, not a
held-out score. Many remaining misses are genuinely ambiguous keys: `so`/내, `go`/해, `did`/양.

Kanji conversion, top candidate exactly matching the original text (held-out Tatoeba):

| | macOS engine | + reranking | correct one in the list | AzooKey + reranking |
| --- | --- | --- | --- | --- |
| 2–3 word phrases | 74.5% | **81.0%** | 96.2% | 81.0% |
| whole sentences | 71.2% | **74.0%** | 91.5% | 67.2% |

Exact match counts kana/kanji style differences (ひとまとめ vs 一まとめ) as misses.

