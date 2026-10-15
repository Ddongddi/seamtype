# Settings

[← README](../README.en.md) · [한국어](settings.md) · English

## Input menu and settings window

From the input menu (the menu bar, while Seamtype is selected) you can:
- pause Seamtype in this text field (like right ⌘)
- turn word conversion on or off for the app in front, set its conversion threshold
  (Normal/Strict), whether Esc switches languages and whether the word is held after Space, or drop
  its settings. Those are greyed while conversion is off
- turn Japanese Input and Live Conversion on or off
- undo the last learned word, and open Try Typing, the remembered words or the settings window

The settings window has Languages (Japanese and its options), Keys (the language switch keys,
Return, right ⌘), per-app behavior, Try Typing (how each word was decided, with scores), the learned
words (forget one or all) and About. The kanji candidate order resets under Japanese input in
Languages. Changes apply at once.

## Settings files

The menu and the settings window both write `~/Library/Application Support/Seamtype/settings.json`.
You can edit it by hand; missing keys keep the default.

```json
{ "japanese": true, "liveConversion": true }
```

| Key | Default | What it does |
| --- | --- | --- |
| `japanese` | **off** | Detect romaji Japanese and convert it. |
| `liveConversion` | off | While you type a Japanese phrase, show its top kanji candidate (`今日はいい天気でs`); Return commits it as shown. Like macOS Live Conversion. |
| `returnConfirmsOnly` | on | Return on an underlined word only confirms it. Off, the app gets that Return too (a Japanese phrase is still only confirmed). |
| `rightCommandPause` | on | A right ⌘ tap pauses Seamtype in the text field (see [Pause](usage.en.md#pause)). |
| `fullWidthDigits` | off | Numbers after Japanese come out full-width (`１２３`, `０３－１２３４` in addresses and phone numbers), underlined, with Space offering `123` (half-width) or conversions like `三月`. |
| `fullWidthSpace` | off | Space after Japanese types a full-width space (`　`). ⇧Space types the other width (full-width while this is off). |
| `japaneseEngine` | `"apple"` | Kanji conversion: `"apple"` uses the engine of macOS's Japanese input, `"azooKey"` the AzooKey converter in the app. |

With live conversion, Space opens the candidate window at the next candidate, and Esc shows the
kana (Esc again switches language where Esc is a switch key, else commits the kana and goes to the
app). Short readings only change into kanji (`と` stays `と`, `私`
converts). The top candidate is right for about 4 in 5 short phrases and 3 in 4 whole sentences
([held-out results](how-it-works.en.md#held-out-results)), so glance before Return. Conversion takes 8–21 ms a
keystroke.

Per-app behavior lives in `apps.json` in the same folder. `"*"` is your default for every app; an
app (by bundle identifier, a key ending in `.` matches as a prefix) names only the keys that differ
from it. No app is listed unless you list it.

```json
{ "*":                     { "switchKeys": ["escape", "shiftEscape"] },
  "com.microsoft.VSCode":  { "switchKeys": ["rightOption", "shiftEscape"] },
  "com.apple.Terminal":    { "conversionThreshold": 0.97 },
  "com.example.Game":      { "enabled": false } }
```

| Key | Default | What it does |
| --- | --- | --- |
| `enabled` | `true` | `false` passes every key through (plain English). |
| `conversionThreshold` | `0.5` | Convert away from the typed letters only when at least this sure. `0.97` (Strict) keeps short shell commands from turning into Hangul in a terminal; `0.5` converts more Korean when you write prose. |
| `switchKeys` | `["rightOption", "shiftEscape"]` | The keys that switch readings ([language switch keys](usage.en.md#language-switch-keys)): `"rightOption"` (right ⌥ tapped alone), `"optionSpace"` (⌥Space), `"rightShift"` (right ⇧ tapped alone), `"escape"` (Esc), `"shiftEscape"` (⇧Esc). A key not chosen goes to the app. 0.1.9's `escapeToApp`, and `switchKey` in settings.json, are read and carried over. |
| `holdSpace` | `false` | Space puts the space inside the underline instead of ending the word. Like a word being typed, a switch key changes it and Delete deletes; the next word puts it in with its space. For terminals, which can't change a committed word, so set per app only (not in `"*"`); Return only confirms it, and text replacements don't fire. |
| `fullWidth` | `true` | `false` keeps numbers and spaces half-width in this app whatever the full-width settings say (terminals, code editors). |

After editing these files by hand, restart the input method: `pkill -x Seamtype`.

