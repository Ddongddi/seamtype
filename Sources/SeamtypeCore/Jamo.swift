/// Hangul jamo tables and the 2-set (두벌식) QWERTY layout.
///
/// All jamo are represented as Hangul Compatibility Jamo (U+3131…U+3163),
/// which is also what gets emitted for stray, uncombined jamo.
public enum Jamo {
    static let choseong: [Character] = Array("ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ")
    static let jungseong: [Character] = Array("ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ")
    /// Index 0 is "no final consonant".
    static let jongseong: [Character?] = [nil] + Array("ㄱㄲㄳㄴㄵㄶㄷㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅄㅅㅆㅇㅈㅊㅋㅌㅍㅎ").map { $0 }

    static let choIndex = Dictionary(uniqueKeysWithValues: choseong.enumerated().map { ($1, $0) })
    static let jungIndex = Dictionary(uniqueKeysWithValues: jungseong.enumerated().map { ($1, $0) })
    static let jongIndex: [Character: Int] = {
        var map: [Character: Int] = [:]
        for (i, j) in jongseong.enumerated() { if let j { map[j] = i } }
        return map
    }()

    static let vowelCombos: [String: Character] = [
        "ㅗㅏ": "ㅘ", "ㅗㅐ": "ㅙ", "ㅗㅣ": "ㅚ",
        "ㅜㅓ": "ㅝ", "ㅜㅔ": "ㅞ", "ㅜㅣ": "ㅟ",
        "ㅡㅣ": "ㅢ",
    ]

    static let finalCombos: [String: Character] = [
        "ㄱㅅ": "ㄳ", "ㄴㅈ": "ㄵ", "ㄴㅎ": "ㄶ",
        "ㄹㄱ": "ㄺ", "ㄹㅁ": "ㄻ", "ㄹㅂ": "ㄼ", "ㄹㅅ": "ㄽ", "ㄹㅌ": "ㄾ", "ㄹㅍ": "ㄿ", "ㄹㅎ": "ㅀ",
        "ㅂㅅ": "ㅄ",
    ]

    /// Inverse of `finalCombos`: compound final → (stays as final, moves to next syllable).
    static let finalSplits: [Character: (Character, Character)] = {
        var map: [Character: (Character, Character)] = [:]
        for (pair, combined) in finalCombos {
            let parts = Array(pair)
            map[combined] = (parts[0], parts[1])
        }
        return map
    }()

    static func isConsonant(_ j: Character) -> Bool { choIndex[j] != nil || jongIndex[j] != nil }
    static func isVowel(_ j: Character) -> Bool { jungIndex[j] != nil }

    static func syllable(cho: Character, jung: Character, jong: Character?) -> Character {
        let c = choIndex[cho]!, v = jungIndex[jung]!
        let f = jong.flatMap { jongIndex[$0] } ?? 0
        return Character(Unicode.Scalar(0xAC00 + (c * 21 + v) * 28 + f)!)
    }
}

public enum DubeolsikLayout {
    private static let lower: [Character: Character] = [
        "q": "ㅂ", "w": "ㅈ", "e": "ㄷ", "r": "ㄱ", "t": "ㅅ", "y": "ㅛ", "u": "ㅕ", "i": "ㅑ", "o": "ㅐ", "p": "ㅔ",
        "a": "ㅁ", "s": "ㄴ", "d": "ㅇ", "f": "ㄹ", "g": "ㅎ", "h": "ㅗ", "j": "ㅓ", "k": "ㅏ", "l": "ㅣ",
        "z": "ㅋ", "x": "ㅌ", "c": "ㅊ", "v": "ㅍ", "b": "ㅠ", "n": "ㅜ", "m": "ㅡ",
    ]
    private static let shifted: [Character: Character] = [
        "Q": "ㅃ", "W": "ㅉ", "E": "ㄸ", "R": "ㄲ", "T": "ㅆ", "O": "ㅒ", "P": "ㅖ",
    ]

    /// Keys whose shifted form produces a different jamo. Shift on any other
    /// letter is a signal the user is typing English.
    public static func isKoreanShiftKey(_ key: Character) -> Bool { shifted[key] != nil }

    /// The jamo a key produces, or nil for non-letters.
    /// Uppercase letters without a shifted jamo fall back to the lowercase jamo,
    /// mirroring how the macOS 2-set keyboard behaves.
    public static func jamo(for key: Character) -> Character? {
        if let j = shifted[key] { return j }
        guard key.isASCII, let lowered = key.lowercased().first else { return nil }
        return lower[lowered]
    }

    /// The keys that type `text` (`안녕` → `dkssud`), Latin letters as they are; nil when it has
    /// anything else (spaces, punctuation, kana, which could come from more than one romaji). A text field that
    /// Seamtype itself types into gets Hangul for Korean-looking keys, and this undoes it.
    public static func keys(typing text: String) -> String? {
        var keys = ""
        for character in text {
            if character.isASCII, character.isLetter {
                keys.append(character)
            } else if let jamos = Jamo.decompose(character) {
                for jamo in jamos {
                    guard let key = self.key[jamo] else { return nil }
                    keys.append(key)
                }
            } else {
                return nil
            }
        }
        return keys
    }

    private static let key: [Character: Character] = {
        var map: [Character: Character] = [:]
        for (key, jamo) in lower { map[jamo] = key }
        for (key, jamo) in shifted { map[jamo] = key }
        return map
    }()
}

extension Jamo {
    /// A syllable or compatibility jamo as the single jamo typed for it, compounds split
    /// (`괜` → ㄱ ㅗ ㅐ ㄴ); nil for anything else.
    static func decompose(_ character: Character) -> [Character]? {
        guard let scalar = character.unicodeScalars.first, character.unicodeScalars.count == 1 else { return nil }
        func split(_ jamo: Character) -> [Character] {
            if let parts = vowelSplits[jamo] { return parts }
            if let (first, second) = finalSplits[jamo] { return [first, second] }
            return [jamo]
        }
        switch scalar.value {
        case 0xAC00...0xD7A3:
            let index = Int(scalar.value - 0xAC00)
            let cho = choseong[index / (21 * 28)], jung = jungseong[index / 28 % 21]
            return [cho] + split(jung) + (jongseong[index % 28].map(split) ?? [])
        case 0x3131...0x3163:
            return split(character)
        default:
            return nil
        }
    }

    private static let vowelSplits: [Character: [Character]] = {
        var map: [Character: [Character]] = [:]
        for (pair, combined) in vowelCombos { map[combined] = Array(pair) }
        return map
    }()
}
