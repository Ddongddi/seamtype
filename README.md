<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/media/logo-dark.svg">
    <img src="docs/media/logo-light.svg" width="150" alt="Seamtype: A, 아, あ">
  </picture>
</p>

<h1 align="center">Seamtype</h1>

<p align="center"><b>흐름대로 써진다 · 流れるままに · Type as it flows</b></p>

<p align="center"><a href="https://nyttastudio.com/seamtype/">웹사이트</a> · 한국어 · <a href="README.en.md">English</a></p>

모든 글을 영문(QWERTY) 자판으로 치세요. 한/영 키는 이제 누르지 않아도 됩니다.
Seamtype은 macOS 입력기로, **단어마다** 영어인지 한국어(두벌식)인지, 켜 두었다면 일본어(로마자)인지
판단해서 맞는 글자로 입력합니다.

```
Stay hungry, stay foolishsms wkqtmdml akfdlek.   →  Stay hungry, stay foolish는 잡스의 말이다.
wagahaihanekodearu␣sms thtpzldml thtjfdlek.      →  吾輩は猫である는 소세키의 소설이다.
Hello, worldhasaishonopuroguramudesu␣.           →  Hello, worldは最初のプログラムです。
```

<p align="center">
  <img src="docs/media/demo.gif" width="720" alt="입력 메뉴에서 Seamtype을 한 번 고른 뒤, 입력 소스를 다시 바꾸지 않고 Safari에 QWERTY로 치는 모습: Stay hungry, stay foolish는 잡스의 말이다. / 吾輩は猫である는 소세키의 소설이다. / Hello, worldは最初のプログラムです。">
</p>

## 특징

- **단어마다 판단**: 영어·한국어·일본어를 키마다 점수로 비교해, 치는 동안 밑줄 친 미리 보기로 보여 줍니다.
  학습에 쓰지 않은 데이터에서 정확도 99.80%(영/한), 99.48%(영/한/일).
- **섞인 단어도 그대로**: `githubdp` → `github에`, `hellodnjfem` → `hello월드`, `githubde` → `githubで`.
- **일본어 한자 변환**: macOS 일본어 입력기와 같은 엔진에 순서 재조정을 더해, 짧은 구절의 맨 앞 후보가 81% 맞습니다.
  라이브 변환도 됩니다.
- **틀리면 키 하나로**: 언어 바꾸기 키(기본 오른쪽 ⌥ 단독, ⇧Esc)로 읽기를 바꾸고, 확정한 직후에도 고칩니다.
  같은 것을 두 번 고치면 기억합니다.
- **앱마다 다르게**: 터미널은 엄격하게, 게임은 끄기처럼 앱별로 정하고, vim은 모드를 알아서 노멀 모드 키를 바로 넘깁니다.
- **이 Mac 안에서만**: 판단은 모두 로컬에서 하고, 입력한 키는 입력기 밖으로 나가지 않습니다.

## 만든 이유

일본에 살면서 한국어·영어·일본어를 매일 섞어 씁니다. 입력 소스가 셋이다 보니 전환 키를 누르는 일도, 엉뚱한
언어로 쳐 버리는 일도 잦았습니다. 그러다 일본어와 영어를 전환 없이 섞어 치는
[Meltype](https://github.com/yksr-melt/Meltype)에서 영감을 받아, 세 언어를 한 번에 다루는 입력기를 만들었습니다.

## 설치

1. [`Seamtype.pkg`](https://github.com/aimdevlee/seamtype/releases/latest/download/Seamtype.pkg)를 받아 열고
   안내대로 설치하세요. Apple Silicon과 Intel 모두에서 돌아가고, Apple 공증을 받았습니다.
2. 메뉴 막대의 입력 메뉴에서 **Seamtype**을 고르세요. 설치 프로그램이 입력 소스 등록까지 해 둡니다.
3. 일본어도 섞어 쓰려면 입력 메뉴에서 **일본어 입력**을 켜세요. **기본으로 꺼져 있습니다.**

> [!TIP]
> 입력 메뉴에 Seamtype이 없으면 **시스템 설정 → 키보드 → 입력 소스 → 편집… → + → 한국어 → Seamtype**을
> 추가하세요. 그래도 없으면 한 번 로그아웃했다가 다시 로그인하세요.

메모리는 ~50 MB(일본어를 켜면 일본어 사전 ~35 MB 추가), 앱 크기는 ~47 MB이고, 따로 실행되는 프로그램은
없습니다.

<details>
<summary>업데이트</summary>

새 버전이 나오면 입력 메뉴에 **Seamtype … 로 업데이트…**가 생기고, 설정 창의 **정보**에서 바뀐 것을 보고
설치할 수 있습니다(**지금 확인**으로 직접 확인도 됩니다). 설치 파일을 받아 서명을 확인한 뒤 설치 프로그램을 열어 주므로
암호만 넣으면 됩니다. 확인은 하루 한 번과 설정 창을 열 때 하며, GitHub에 최신 버전 번호만 물어볼 뿐 입력한
내용은 보내지 않습니다. 정보의 **업데이트 자동 확인**으로 끌 수 있습니다.

직접 업데이트할 때도 새 `Seamtype.pkg`를 받아 그대로 설치하면 됩니다. 앱만 바꾸고 설정과 학습한 단어는
남기며, 로그아웃이나 재시동은 필요 없습니다. 깨끗이 다시 설치하려면 설치 프로그램의 **사용자화**에서
**설정과 학습한 단어 초기화**를 체크하세요.

</details>

<details>
<summary>제거</summary>

설정 창의 **정보 → Seamtype 제거 → 제거…**를 누르세요. 두 Input Methods 폴더의 Seamtype을 모두 지우고
(pkg로 설치했다면 macOS가 암호를 묻습니다), 다른 입력 소스로 바꿉니다. 설정과 학습한 단어는 확인 창에서
체크했을 때만 지웁니다.

제거한 뒤 시스템 설정의 입력 소스 목록에 Seamtype이 남아 보이면, 한 번 로그아웃했다가 다시 로그인하면
사라집니다. 제거한 뒤 다시 설치했는데 입력 메뉴에 없으면 그 목록에서 Seamtype을 −로 뺐다가 +로 다시
추가하세요.

터미널에서는 이렇게 지웁니다(`--delete-data`는 설정과 학습한 단어까지 지울 때만):

```sh
"/Library/Input Methods/Seamtype.app/Contents/MacOS/Seamtype" --uninstall --delete-data
```

</details>

## 기본 키

치고 있는 단어에는 밑줄이 그어지고, Seamtype이 예상한 언어로 보입니다.

| 키 | 하는 일 |
| --- | --- |
| **Space** | 단어를 확정하고 띄어쓰기. 일본어 구절은 한자로 변환 |
| **오른쪽 ⌥ 단독**, **⇧Esc** | 읽기 바꾸기: 영어 → 영어+조사 → 한국어 → 일본어. 확정한 직후에도 됩니다 |
| **Return** | 확정만 (줄바꿈·전송은 한 번 더 누르기) |
| **Delete** | 한국어는 치고 있는 글자를 자모 하나씩, 일본어는 가나 한 글자씩 |
| **오른쪽 ⌘ 단독** | 이 입력창에서 일시정지 / 다시 켜기 (lazygit, htop처럼 키가 곧 명령인 곳) |

모든 키와 변환 중 키, 텍스트 대치, vim은 [쓰는 법](docs/usage.md)에 있습니다.

## 문서

| 문서 | 내용 |
| --- | --- |
| [쓰는 법](docs/usage.md) | 모든 키, 언어 바꾸기 키 고르기, 확정한 뒤에 고치기와 학습, 텍스트 대치, 일시정지, vim |
| [설정](docs/settings.md) | 입력 메뉴와 설정 창, `settings.json`, 앱별 `apps.json` |
| [판단 방식과 정확도](docs/how-it-works.md) | 섞인 단어를 나누는 법, 휴리스틱, 한자 변환, 평가 결과 |
| [개발](docs/development.md) | 빌드·테스트·설치 명령, 소스 구성 |

## 알려진 한계

- 모든 앱에서 처음부터 끝까지 시험해 보지는 않았습니다. 보안 입력란(비밀번호)은 입력기를 거치지 않고,
  입력기를 거치는 가려진 칸(카카오톡 로그인, 앱스토어 비밀번호 창)에는 단어를 판단하지 않고 친 그대로
  들어갑니다.
- 확정한 뒤에 고치기는 커서 위치와 글자를 알려 주는 앱에서만 됩니다. 터미널에서는 `"holdSpace": true`로
  Space 뒤에도 단어를 밑줄 상태로 두세요.
- Esc를 언어 바꾸기 키로 고른 앱에서는, 단어 바로 뒤에 누른 Esc(예: 팝업 닫기)가 먼저 그 단어를
  바꿉니다. 반복하지 않으면 학습하지는 않습니다. 그런 앱에서는 앱별 설정에서 Esc를 빼세요.
- 일본어: ←/→로는 첫 문절만 크기를 바꿀 수 있습니다(Return으로 확정하면 나머지로 넘어갑니다). 드문
  단어는 여전히 후보 목록에서 골라야 합니다.

## 라이선스와 데이터

Seamtype은 MIT 라이선스입니다([LICENSE](LICENSE)). 앱에 컴파일되거나 복사된 모든 것의 라이선스는
`Contents/Resources/ThirdPartyNotices.txt`에 들어 있고, `scripts/build-app.sh`가 모읍니다.

- 한자 변환: macOS에 들어 있는 일본어 변환 엔진을 실행할 때 불러 씁니다(앱에 포함하지 않음).
- AzooKey Kana-Kanji Converter(대신 쓰는 변환기): MIT, 사전: Apache-2.0.
- Tatoeba 문장(가나·일본어 문어 모델, 한국어 음절·단어 빈도, 평가): CC-BY 2.0 FR, https://tatoeba.org.
- 영어 단어와 빈도: [SCOWL](http://wordlist.aspell.net) (자유 라이선스, 고지는 앱에 포함).
  macOS의 `/usr/share/dict/words`로 실행할 때 글자 3-그램을 학습합니다.
- 영어·한국어 빈도 목록:
  [hermitdave/FrequencyWords](https://github.com/hermitdave/FrequencyWords), CC-BY-SA 4.0.
  평가에 쓰고, 한국어 목록은 영어 + 한국어 단어 나누기용 `korean_vocabulary.txt`로도 같은 라이선스로
  앱에 들어갑니다(고지는 앱에 포함).
