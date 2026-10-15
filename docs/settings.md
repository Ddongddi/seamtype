# 설정

[← README](../README.md) · 한국어 · [English](settings.en.md)

## 입력 메뉴와 설정 창

입력 메뉴(Seamtype을 고른 상태의 메뉴 막대)에서 할 수 있는 것:
- 이 입력창에서 일시정지(오른쪽 ⌘와 같음)
- 지금 앞에 있는 앱의 단어 변환 켜고 끄기, 그 앱의 변환 기준(보통·엄격하게), Esc로 언어 바꾸기, Space 뒤에도
  단어 유지 정하기, 그 앱을 기본 설정으로 되돌리기. 단어 변환이 꺼져 있으면 이 항목들은 흐리게 나옵니다
- 일본어 입력과 라이브 변환 켜고 끄기
- 마지막으로 학습한 단어 되돌리기, 입력해 보기, 기억한 단어, 설정 창 열기

설정 창에는 언어(일본어와 그 옵션), 키(언어 바꾸기 키, Return, 오른쪽 ⌘), 앱별 동작, 입력해 보기(단어마다
어떻게 판단했는지와 점수), 학습한 단어(하나씩 또는 전부 잊기), 정보가 있습니다. 한자 후보 순서 초기화는
언어의 일본어 입력 아래에 있습니다. 바꾼 내용은 바로
적용됩니다.

## 설정 파일

메뉴와 설정 창 모두 `~/Library/Application Support/Seamtype/settings.json`에 씁니다. 직접 고쳐도 되고,
없는 항목은 기본값을 따릅니다.

```json
{ "japanese": true, "liveConversion": true }
```

| 항목 | 기본값 | 내용 |
| --- | --- | --- |
| `japanese` | **꺼짐** | 로마자 일본어를 알아보고 변환합니다. |
| `liveConversion` | 꺼짐 | 일본어 구절을 치는 동안 가장 앞선 한자 후보를 보여 주고(`今日はいい天気でs`), Return을 누르면 보이는 대로 확정합니다. macOS의 실시간 변환과 같습니다. |
| `returnConfirmsOnly` | 켜짐 | 밑줄 친 단어에서 누른 Return은 확정만 합니다. 끄면 앱도 그 Return을 받습니다(일본어 구절은 그대로 확정만). |
| `rightCommandPause` | 켜짐 | 오른쪽 ⌘를 단독으로 눌러 일시정지합니다([일시정지](usage.md#일시정지) 참고). |
| `fullWidthDigits` | 꺼짐 | 일본어 뒤의 숫자를 전각으로 씁니다(`１２３`, 주소·전화번호의 `０３－１２３４`). 밑줄 친 채 남고 Space로 `123`(반각)이나 `三月` 같은 변환을 고릅니다. |
| `fullWidthSpace` | 꺼짐 | 일본어 뒤의 Space를 전각 공백(`　`)으로 씁니다. ⇧Space는 설정과 반대 폭의 공백을 넣습니다(꺼져 있으면 전각). |
| `japaneseEngine` | `"apple"` | 한자 변환 엔진. `"apple"`은 macOS 일본어 입력기의 엔진을, `"azooKey"`는 앱에 든 AzooKey를 씁니다. |

라이브 변환에서 Space는 다음 후보부터 후보 창을 열고, Esc는 가나를 보여 줍니다(한 번 더 누르면, Esc가 언어
바꾸기 키면 언어를 바꾸고 아니면 가나로 확정한 뒤 앱으로 갑니다). 짧은 읽기는 한자로만 바뀝니다(`と`는 그대로, `私`는 변환). 맨 앞 후보는 짧은 구절 5개 중 4개,
문장 전체 4개 중 3개꼴로 맞으니([평가 결과](how-it-works.md#평가-결과-학습에-쓰지-않은-데이터)) Return 전에 한번
확인하세요. 변환은 키마다 8–21 ms 걸립니다.

앱별 동작은 같은 폴더의 `apps.json`에 있습니다. `"*"`는 모든 앱의 기본값이고, 앱(번들 ID, `.`으로 끝나는
키는 앞부분이 같은 앱 전부)에는 기본값과 다른 항목만 적습니다. 직접 넣지 않으면 어떤 앱도 들어 있지
않습니다.

```json
{ "*":                     { "switchKeys": ["escape", "shiftEscape"] },
  "com.microsoft.VSCode":  { "switchKeys": ["rightOption", "shiftEscape"] },
  "com.apple.Terminal":    { "conversionThreshold": 0.97 },
  "com.example.Game":      { "enabled": false } }
```

| 항목 | 기본값 | 내용 |
| --- | --- | --- |
| `enabled` | `true` | `false`면 모든 키를 그대로 넘깁니다(영어만 입력). |
| `conversionThreshold` | `0.5` | 이만큼 확신할 때만 친 영문을 다른 글자로 바꿉니다. `0.97`(엄격하게)은 터미널에서 짧은 셸 명령이 한글로 바뀌지 않게 하고, `0.5`는 글을 쓸 때 한국어를 더 많이 바꿉니다. |
| `switchKeys` | `["rightOption", "shiftEscape"]` | 읽기를 바꾸는 키([언어 바꾸기 키](usage.md#언어-바꾸기-키)). `"rightOption"`(오른쪽 ⌥ 단독), `"optionSpace"`(⌥Space), `"rightShift"`(오른쪽 ⇧ 단독), `"escape"`(Esc), `"shiftEscape"`(⇧Esc). 고르지 않은 키는 앱으로 갑니다. 0.1.9의 `escapeToApp`과 settings.json의 `switchKey`는 읽어서 옮깁니다. |
| `holdSpace` | `false` | Space가 단어를 끝내지 않고 공백까지 밑줄 안에 넣습니다. 치는 중인 단어처럼 언어 바꾸기 키로 바꾸고 Delete로 지울 수 있고, 다음 단어를 치면 공백과 함께 들어갑니다. 확정한 단어를 고칠 수 없는 터미널용이라 앱별로만 정하며(`"*"`에는 두지 않습니다), Return은 확정만 하고 텍스트 대치는 동작하지 않습니다. |
| `fullWidth` | `true` | `false`면 이 앱에서는 전각 숫자·공백 설정을 따르지 않고 반각으로 씁니다(터미널, 코드 편집기용). |

파일을 직접 고친 뒤에는 입력기를 다시 시작하세요: `pkill -x Seamtype`.

