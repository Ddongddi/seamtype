# Usage

[← README](../README.en.md) · [한국어](usage.md) · English

## Keys

While a word is being typed it is underlined and shows the language Seamtype expects.

| Key | English / Korean word | Japanese phrase |
| --- | --- | --- |
| letters | extend the word | extend the phrase (kana preview) |
| **[Language switch keys](#language-switch-keys)** (by default right ⌥ tapped on its own, and ⇧Esc) | switch reading: English → English+particle → Korean → Japanese | same (with live conversion, the kana first) |
| Esc | commit; the app gets the Esc (when chosen as a switch key, as above) | with live conversion, the kana first |
| Delete | English: the last letter. Korean: the syllable being typed jamo by jamo, earlier ones whole (한국 → 한구 → 한ㄱ → 한 → gone, as the system's 2-set does) | one kana at a time (かんこく → かんこ) |
| **Space** | commit, then a space | **convert to kanji** (candidate window) |
| `, . ? !` and other symbols | commit, then the key | join the phrase, full-width: 、。？！ （）＿ 「」(`[ ]`) ・(`/`) 〜(`~`) |
| `-` | commit, then `-` | ー |
| Return | commit only (press again for a newline or to send; a setting) | commit as shown, kana or live-converted kanji (no newline) |
| ⌃K / F7, ⌃J / F6 | (the app's shortcut) | katakana / hiragana (Space flips, Return commits) |
| Tab, arrows, ⌘/⌃/⌥ | commit, the app gets the key | same |
| **Right ⌘** (tapped on its own) | pause / resume Seamtype in this text field | same |

A symbol typed on its own after Japanese is full-width and stays underlined, as in a Japanese IME (`！`, `＿`, `「`): Return confirms it (no newline), Space offers its other forms (`!`, `‼︎`, `『`…), and a letter confirms it and starts a new word. Inside numbers (`3.5`, `10:30`) it stays half-width, and a bracket opened full-width closes full-width even after an English word (`日本語（English）`).

With Japanese on, numbers and symbols can be Japanese too. Typed on their own at the start of a sentence or after Korean or English they go in half-width, but a language switch key right after them turns them into their Japanese form, underlined (`123` → `１２３`, `[` → `「`, `?` → `？`). In Japanese text, a word typed straight after a number reads as a counter, and Space converts it together with the number (`3ji` → `3時`, `5fun` → `5分`). Units that aren't romaji, like `5km` or `3pm`, stay English.

While converting (candidate window open):

| Key | Effect |
| --- | --- |
| Space / ↓, ↑ | next / previous candidate |
| ←, → | shorten / lengthen the first clause (`今日は｜いいてんき`) |
| 1–9 | commit that candidate |
| Return | commit the selected candidate |
| Esc / Delete | back to the kana |
| letters, punctuation | commit, then keep typing |

Conversion goes clause by clause: a candidate that covers only the start of the reading (`今日は`
for きょうはいいてんきですね) commits that part and keeps converting the rest.

## Language switch keys

Choose the keys that switch readings in the settings window's Keys pane, keycaps you click: right ⌥
tapped alone, ⌥Space, right ⇧ tapped alone, Esc and ⇧Esc, as many as you like. By default they are
**right ⌥ tapped alone** and **⇧Esc**. A key not chosen goes to the app.

- **Right ⌥ or right ⇧ tapped alone**: apps don't react to a lone modifier, so it never closes a
  window or clears input. A tap with other modifiers isn't taken, so a key remapped as a Hyper key
  (⌃⌥⇧⌘ at once, by Raycast or Karabiner) keeps doing what it's bound to; choose another key then.
- **⌥Space**: it otherwise types a no-break space, which it no longer does once chosen.
- **Esc**: quick if you're used to it, but Chromium-based apps such as Claude's desktop app or Slack
  also see an Esc the input method took, so they may close their window or cancel the input while
  the word changes. With nothing to change, Esc goes to the app.
- **⇧Esc**: with nothing to change it does nothing and never reaches the app.

The per-app settings can choose other keys for one app: switch with Esc by default, say, and leave
Esc out where it has to reach the app, as in an editor. The input menu's "Esc Switches Language"
adds or removes only Esc for the app in front. In the Japanese candidate window and with live
conversion, Esc goes back to the kana first whatever keys are chosen.

## Undo after commit, and learning

Right after a word is committed with Space or punctuation, a language switch key switches it to its
next reading, and pressing it again keeps cycling. Deleting the space or punctuation first keeps
that chance; any other key ends it. This needs the caret still right after the word and an app that
lets Seamtype read the text there.

In an app that doesn't, such as a terminal, turn on **Hold the word after Space** for that app (the
input menu, or Apps in the settings window; `holdSpace` in `apps.json`). Space then doesn't end the
word but puts the space inside the underline too. While underlined it is the word being typed: a
language switch key changes it, Delete deletes (the space first), and starting the next word puts it
in with its space. Return only confirms it, as on any underlined word, so press it again to run a
command; the app never gets the Space key, so its text replacements don't fire.

A correction changes only that word, so a stray switch doesn't stick. Correct the same keys the same
way a second time and Seamtype remembers it; switching a word back to Seamtype's own guess forgets
it.

## Text replacements

A shortcut in System Settings → Keyboard → Text Replacements that reads as Korean or Japanese
(`주소`, `ㅈㅅ`, `よろ`) shows in that language whatever the guess, so the app replaces it on Space as
it does with the system's input. English shortcuts are decided as usual. A Japanese shortcut's
phrase is the first candidate on Space, and a shortcut entered more than once offers every phrase in turn. The app does the replacing, so apps without text
replacement (terminals, Chrome…) only get the Japanese candidate. Edits to the list apply the next
time a text field becomes active. Enter a Japanese shortcut as its hiragana reading (`よろ`, `ぐー`).

## Pause

Where every key is a command, like lazygit or htop in a terminal, tap **right ⌘** on its own. The
word in progress goes in, and in that text field keys go through as typed. Tap again, move to
another app or text field, or change a setting, to resume.

Each tap shows Seamtype's icon under the caret for a moment, like the input source indicator,
struck through when paused. The menu bar icon doesn't change, so to check later, look for the tick
in the input menu. Turn the key off under Keys in the settings window.

## vim

For neovim put [`scripts/vim/seamtype.lua`](../scripts/vim/seamtype.lua) in `~/.config/nvim/plugin/`;
for Vim (8.2 or later, `+job`) put [`scripts/vim/seamtype.vim`](../scripts/vim/seamtype.vim) in
`~/.vim/plugin/`. Vim then tells Seamtype on every mode change, so words are decided only in insert
mode, and in normal, visual and command-line mode keys go straight to vim: `s`, `dd`, `ciw` and
`:wq⏎` run key by key. Inside vim, Esc always goes to vim, so no per-app setting is needed. Once vim
quits, words are decided again at the shell.

<details>
<summary>How it works, and caveats</summary>

- The signal is `Seamtype --vim insert|normal|off --app <bundle id>`, sent on mode changes
  (entering and leaving insert mode, start, quit, focus), not on keys.
- The bundle identifier is `$__CFBundleIdentifier`, which macOS sets for every app, so nothing
  needs setting up per terminal (Ghostty, Terminal, iTerm2, VS Code…), and the signal reaches only
  that app's text field. A signal without `--app` is taken only where Esc isn't a switch key.
- Attached to tmux from a different terminal than the one that started its server, the bundle
  identifiers differ and the signal is ignored.
- If Vim doesn't see the terminal's focus changes, Seamtype can't tell when you move from its pane
  to a shell pane; press ⇧Esc there (when it's a switch key) to start deciding words again.

</details>

