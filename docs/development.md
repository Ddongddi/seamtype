# 개발

[← README](../README.md) · 한국어 · [English](development.en.md)

## 명령

```sh
swift test                     # 테스트: 조합기, 엔진, 세션, 설정, 처음부터 끝까지
scripts/install.sh             # 빌드하고 자체 점검한 뒤 ~/Library/Input Methods에 설치(개발용; pkg 사본이 있으면 멈춤)
scripts/typing-test/run.sh     # 설치된 Seamtype으로 설정 창의 입력해 보기 칸에 실제 키 입력
swift scripts/make-readme-logo.swift docs/media  # README 로고(애니메이션 SVG)
scripts/release.sh             # 릴리스용 범용(arm64 + x86_64) zip과 pkg; Developer ID가 있으면 서명·공증(앱과 pkg 모두)
tools/prepare.sh               # 정확도 (단어 목록, Tatoeba, SCOWL을 처음 한 번 내려받음)
tools/prepare.sh --models      # 먼저 Sources/SeamtypeCore/Data의 데이터를 다시 만듦(korean_vocabulary.txt 빼고)
SEAMTYPE_TIMING=1 swift run -c release seamtype-cli --decide --japanese < keys.tsv  # + 판단당 시간
swift run seamtype-cli -v "dkssud gksrmf hello"               # 영어/한국어, 점수와 함께
printf 'kyouhagoogledekensaku\t\n' | swift run seamtype-cli --decide --japanese
printf 'きょうはいいてんきですね\n' | swift run seamtype-cli --convert
```

| 경로 | 내용 |
| --- | --- |
| `Sources/SeamtypeCore` | 조합기, 엔진, 변환, `InputSession` (입력 로직 전부) |
| `Sources/Seamtype` | InputMethodKit 서버, `InputSession` 위의 얇은 컨트롤러, 후보 창, 설정 창 |
| `Sources/SeamtypeCore/Data` | 가나·일본어 문어 3-그램, 한국어 음절과 단어, 영어 단어 |
| `tools/` | 말뭉치 → 로마자, 모델 생성, 평가 데이터와 정확도 (python3, 추가 패키지 없음) |

