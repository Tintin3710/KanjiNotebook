import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Color {
    static var appBackground: Color {
        #if canImport(UIKit)
        return Color(uiColor: .systemGroupedBackground)
        #elseif canImport(AppKit)
        return Color(nsColor: .windowBackgroundColor)
        #else
        return Color.gray.opacity(0.1)
        #endif
    }

    static var cardSurface: Color {
        #if canImport(UIKit)
        return Color(uiColor: .systemBackground)
        #elseif canImport(AppKit)
        return Color(nsColor: .controlBackgroundColor)
        #else
        return Color.white
        #endif
    }

    static var kanjiTileSurface: Color {
        #if canImport(UIKit)
        return Color(uiColor: .systemGray6)
        #elseif canImport(AppKit)
        return Color(nsColor: .underPageBackgroundColor)
        #else
        return Color.gray.opacity(0.1)
        #endif
    }
}

struct Word {
    let jlpt: String
    let japanese: String
    let reading: String
    let meaning: String
    let kanji: KanjiInfo
    let example: Example
}

struct KanjiInfo {
    let character: String
    let onyomi: String
    let kunyomi: String
    let radical: String
}

struct Example {
    let japanese: String
    let korean: String
}

struct ContentView: View {
    @State private var isFavorite = false

    private let word = Word(
        jlpt: "N3",
        japanese: "勉強",
        reading: "べんきょう",
        meaning: "공부, 학습",
        kanji: KanjiInfo(
            character: "勉",
            onyomi: "ベン",
            kunyomi: "つと(める)",
            radical: "力 (힘 력)"
        ),
        example: Example(
            japanese: "毎日日本語を勉強しています。",
            korean: "매일 일본어를 공부하고 있습니다."
        )
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                WordHeroSection(word: word, isFavorite: $isFavorite)
                KanjiInfoCard(kanji: word.kanji)
                ExampleSentenceCard(example: word.example)
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 40)
        }
        .background(Color.appBackground.ignoresSafeArea())
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

struct WordHeroSection: View {
    let word: Word
    @Binding var isFavorite: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                JLPTBadge(level: word.jlpt)
                Spacer()
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(isFavorite ? Color.yellow : Color.secondary.opacity(0.6))
                }
                .buttonStyle(.plain)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(word.japanese)
                    .font(.system(size: 56, weight: .bold))
                    .foregroundStyle(.primary)
                    .tracking(1)

                Text(word.reading)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.secondary)
            }

            Text(word.meaning)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.primary.opacity(0.75))
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
}

struct JLPTBadge: View {
    let level: String

    var body: some View {
        Text(level)
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(Color.accentColor)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .fill(Color.accentColor.opacity(0.12))
            )
    }
}

struct KanjiInfoCard: View {
    let kanji: KanjiInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center, spacing: 20) {
                Text(kanji.character)
                    .font(.system(size: 72, weight: .semibold))
                    .frame(width: 96, height: 96)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.kanjiTileSurface)
                    )

                VStack(alignment: .leading, spacing: 10) {
                    KanjiRow(label: "음독", value: kanji.onyomi)
                    KanjiRow(label: "훈독", value: kanji.kunyomi)
                    KanjiRow(label: "부수", value: kanji.radical)
                }
                Spacer(minLength: 0)
            }
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardBackground)
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(Color.cardSurface)
            .shadow(color: Color.black.opacity(0.05), radius: 14, x: 0, y: 6)
    }
}

struct KanjiRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.secondary)
                .frame(width: 34, alignment: .leading)

            Text(value)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(.primary)
        }
    }
}

struct ExampleSentenceCard: View {
    let example: Example

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("예문")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.8)

            Text(example.japanese)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.primary)
                .lineSpacing(4)

            Text(example.korean)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(.secondary)
                .lineSpacing(3)
                .padding(.top, 2)
        }
        .padding(22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.cardSurface)
                .shadow(color: Color.black.opacity(0.05), radius: 14, x: 0, y: 6)
        )
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
