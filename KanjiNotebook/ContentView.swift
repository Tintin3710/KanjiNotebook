import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("N2") {
                    KanjiRow(kanji: "割", reading: "わりと", meaning: "비교적")
                    KanjiRow(kanji: "値段", reading: "ねだん", meaning: "가격")
                }

                Section("N3") {
                    KanjiRow(kanji: "勉強", reading: "べんきょう", meaning: "공부")
                }
            }
            .navigationTitle("Kanji Notebook")
        }
    }
}

struct KanjiRow: View {
    let kanji: String
    let reading: String
    let meaning: String

    var body: some View {
        HStack {
            Text(kanji)
                .font(.largeTitle)

            VStack(alignment: .leading) {
                Text(reading)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(meaning)
                    .font(.headline)
            }

            Spacer()

            Text("N2")
                .font(.caption)
                .padding(6)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(6)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
