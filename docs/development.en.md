# Develop

[← README](../README.en.md) · [한국어](development.md) · English

## Commands

```sh
swift test                     # tests: composers, engines, sessions, settings, end to end
scripts/install.sh             # build, self-test and install into ~/Library/Input Methods (development; stops if the pkg's copy is there)
scripts/typing-test/run.sh     # real key events into the settings window's typing pane through the installed Seamtype
swift scripts/make-readme-logo.swift docs/media  # the README logo (animated SVG)
scripts/release.sh             # universal (arm64 + x86_64) zip and pkg for a release; with a Developer ID also signed and notarized (app and pkg)
tools/prepare.sh               # accuracy (downloads word lists, Tatoeba and SCOWL once)
tools/prepare.sh --models      # rebuild the data in Sources/SeamtypeCore/Data first (not korean_vocabulary.txt)
SEAMTYPE_TIMING=1 swift run -c release seamtype-cli --decide --japanese < keys.tsv  # + time per decision
swift run seamtype-cli -v "dkssud gksrmf hello"               # English/Korean, with scores
printf 'kyouhagoogledekensaku\t\n' | swift run seamtype-cli --decide --japanese
printf 'きょうはいいてんきですね\n' | swift run seamtype-cli --convert
```

| Path | What |
| --- | --- |
| `Sources/SeamtypeCore` | composers, engines, conversion, `InputSession` (all typing logic) |
| `Sources/Seamtype` | InputMethodKit server, a thin controller over `InputSession`, candidate window, settings window |
| `Sources/SeamtypeCore/Data` | kana and written-Japanese trigrams, Korean syllables and words, English words |
| `tools/` | corpus → romaji, model builders, evaluation set and accuracy (python3, no packages) |

