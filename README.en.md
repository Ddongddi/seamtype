<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/media/logo-dark.svg">
    <img src="docs/media/logo-light.svg" width="150" alt="Seamtype: A, 아, あ">
  </picture>
</p>

<h1 align="center">Seamtype</h1>

<p align="center"><b>흐름대로 써진다 · 流れるままに · Type as it flows</b></p>

<p align="center"><a href="https://nyttastudio.com/seamtype/">Website (Korean)</a> · <a href="README.md">한국어</a> · English</p>

Type everything on the English (QWERTY) layout and stop pressing the language-switch key.
Seamtype is a macOS input method that decides **per word** whether you meant English,
Korean (2-set / 두벌식) or — if you turn it on — Japanese (romaji), and commits the right one.

```
Stay hungry, stay foolishsms wkqtmdml akfdlek.   →  Stay hungry, stay foolish는 잡스의 말이다.
wagahaihanekodearu␣sms thtpzldml thtjfdlek.      →  吾輩は猫である는 소세키의 소설이다.
Hello, worldhasaishonopuroguramudesu␣.           →  Hello, worldは最初のプログラムです。
```

<p align="center">
  <img src="docs/media/demo.gif" width="720" alt="Choosing Seamtype once from the input menu, then typing on QWERTY into Safari without switching the input source again: Stay hungry, stay foolish는 잡스의 말이다. / 吾輩は猫である는 소세키의 소설이다. / Hello, worldは最初のプログラムです。">
</p>

## Features

- **Decided per word**: the keys are scored as English, Korean and Japanese on every keystroke, with an
  underlined preview while you type. 99.80% accurate (en/ko) and 99.48% (en/ko/ja) on held-out data.
- **Mixed words just work**: `githubdp` → `github에`, `hellodnjfem` → `hello월드`, `githubde` → `githubで`.
- **Japanese kanji conversion**: the engine of macOS's Japanese input plus reranking, with the top candidate
  right for 81% of short phrases. Live conversion too.
- **One key when it's wrong**: a language switch key (by default right ⌥ tapped alone, and ⇧Esc) switches
  the reading, even right after a word is committed. Correct the same thing twice and it's remembered.
- **Per app**: Strict in a terminal, off in a game, and vim reports its mode so normal-mode keys go straight
  through.
- **Stays on this Mac**: every decision is made locally, and keystrokes never leave the input method.

## Why

I live in Japan and mix Korean, English and Japanese every day. With three input sources, I was
forever pressing the switch key, or typing a word in the wrong language. Then
[Meltype](https://github.com/yksr-melt/Meltype), which mixes Japanese and English without switching,
inspired me to build one input method for all three.

## Install

1. Download [`Seamtype.pkg`](https://github.com/aimdevlee/seamtype/releases/latest/download/Seamtype.pkg),
   open it and follow the steps. It runs on Apple silicon and Intel and is notarized by Apple.
2. Pick **Seamtype** in the input menu in the menu bar. The installer registers the input source for you.
3. To mix in Japanese, turn on **Japanese Input** in the input menu. **It is off by default.**

> [!TIP]
> If Seamtype isn't in the input menu, add it in **System Settings → Keyboard → Input Sources →
> Edit… → + → Korean → Seamtype**. If it isn't listed there either, log out and back in once.

Seamtype takes ~50 MB of memory (plus the ~35 MB Japanese dictionary when Japanese is on) and
~47 MB on disk, with nothing else running.

<details>
<summary>Updating</summary>

When a new version is out, the input menu shows **Update to Seamtype …** and **About** in the
settings window lists what changed and installs it (**Check Now** checks by hand). It downloads the installer, checks its
signature and opens it, so you only enter your password. Checks happen once a day and when the
settings window opens; they ask GitHub only for the latest version number, and nothing you type
is sent. Turn them off with **Check for updates automatically** in About.

To update by hand, download the new `Seamtype.pkg` and install it the same way. It replaces the app and
keeps your settings and learned words, with no logout or restart. For a clean reinstall, tick
**Reset settings and learned words** under **Customize** in the installer.

</details>

<details>
<summary>Uninstalling</summary>

In the settings window, click **About → Uninstall Seamtype → Uninstall…**. It removes Seamtype
from both Input Methods folders (macOS asks for your password if you used the pkg) and switches to
another input source. Settings and learned words go only if you tick that in the confirmation.

If Seamtype still shows in the input source list in System Settings after uninstalling, log
out and back in once. If you reinstall and it isn't in the input menu, remove it from that list
with − and add it again with +.

In Terminal (`--delete-data` only to drop settings and learned words too):

```sh
"/Library/Input Methods/Seamtype.app/Contents/MacOS/Seamtype" --uninstall --delete-data
```

</details>

## Basic keys

While a word is being typed it is underlined and shows the language Seamtype expects.

| Key | What it does |
| --- | --- |
| **Space** | commit the word, then a space. A Japanese phrase converts to kanji |
| **Right ⌥ tapped alone**, **⇧Esc** | switch reading: English → English+particle → Korean → Japanese. Works right after a commit too |
| **Return** | commit only (press again for a newline or to send) |
| **Delete** | Korean: the syllable being typed jamo by jamo. Japanese: one kana at a time |
| **Right ⌘ tapped alone** | pause / resume in this text field (where every key is a command, like lazygit or htop) |

Every key, the keys while converting, text replacements and vim are in [Usage](docs/usage.en.md).

## Docs

| Doc | What's in it |
| --- | --- |
| [Usage](docs/usage.en.md) | every key, choosing the language switch keys, undo after commit and learning, text replacements, pause, vim |
| [Settings](docs/settings.en.md) | the input menu and settings window, `settings.json`, per-app `apps.json` |
| [How it decides, and accuracy](docs/how-it-works.en.md) | splitting mixed words, the heuristic, kanji conversion, held-out results |
| [Develop](docs/development.en.md) | build, test and install commands, source layout |

## Known limits

- Never tested end to end in every app. Secure fields (passwords) bypass input methods; a masked
  field that still reaches it (KakaoTalk's login, App Store's password sheet) gets the keys as
  typed, with no word decided.
- Undo after commit needs apps that report their caret and text; in a terminal, set
  `"holdSpace": true` to keep the word underlined after Space instead.
- Where Esc is a switch key, Esc right after a word (e.g. to close a popup) changes that word first.
  It isn't learned unless repeated; leave Esc out for such apps in the per-app settings.
- Japanese: only the first clause is resized with ←/→ (Return commits it and moves on to the
  rest). Rare words still need the candidate list.

## License and data

Seamtype is MIT licensed ([LICENSE](LICENSE)). The app carries the licenses of everything compiled
or copied into it in `Contents/Resources/ThirdPartyNotices.txt`, collected by
`scripts/build-app.sh`.

- Kanji conversion: the Japanese engine that ships with macOS, loaded at runtime (not bundled).
- AzooKey Kana-Kanji Converter (the stand-in): MIT; its dictionary: Apache-2.0.
- Tatoeba sentences (kana and written-Japanese models, Korean syllable and word counts;
  evaluation): CC-BY 2.0 FR, https://tatoeba.org.
- English words and how common they are: [SCOWL](http://wordlist.aspell.net) (permissive,
  notice in the app). macOS's `/usr/share/dict/words` trains the letter trigrams at runtime.
- English/Korean frequency lists:
  [hermitdave/FrequencyWords](https://github.com/hermitdave/FrequencyWords), CC-BY-SA 4.0. Used
  for evaluation; the Korean list also ships as `korean_vocabulary.txt` (for splitting an English
  word from a Korean one), under the same license, with its notice in the app.
