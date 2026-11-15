import SwiftUI
import SwiftData

struct SurahsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var progresses: [SurahProgress]

    @State private var searchText = ""
    @State private var selectedSurah: Surah?

    private var filteredSurahs: [Surah] {
        if searchText.isEmpty { return SURAHS }
        return SURAHS.filter {
            $0.nameFr.localizedCaseInsensitiveContains(searchText)
            || $0.nameAr.contains(searchText)
            || String($0.number).contains(searchText)
        }
    }

    private func progress(for number: Int) -> SurahProgress? {
        progresses.first { $0.surahNumber == number }
    }

    var body: some View {
        List(filteredSurahs) { surah in
            Button {
                selectedSurah = surah
            } label: {
                SurahRow(surah: surah, progress: progress(for: surah.number))
            }
            .buttonStyle(.plain)
        }
        .searchable(text: $searchText, prompt: "Rechercher une sourate")
        .sheet(item: $selectedSurah) { surah in
            NavigationStack {
                SurahDetailView(surah: surah, progress: progress(for: surah.number))
            }
            .presentationDetents([.medium, .large])
        }
    }
}

struct SurahRow: View {
    let surah: Surah
    let progress: SurahProgress?

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.12))
                    .frame(width: 44, height: 44)
                Text("\(surah.number)")
                    .font(.headline)
                    .foregroundStyle(Color.green)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(surah.nameFr)
                    .font(.headline)
                    .lineLimit(1)
                Text("\(surah.ayahCount) versets")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                if let progress, progress.percentRead > 0 || progress.percentMemorized > 0 {
                    HStack(spacing: 8) {
                        ProgressView(value: progress.percentRead / 100)
                            .tint(.green)
                            .frame(width: 90)
                        Text("lu \(Int(progress.percentRead))%")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        if progress.percentMemorized > 0 {
                            Text("mém. \(Int(progress.percentMemorized))%")
                                .font(.caption2)
                                .foregroundStyle(.orange)
                        }
                    }
                }
            }
            Spacer()
            Text(surah.nameAr)
                .font(.title3)
                .foregroundStyle(Color.green.opacity(0.8))
        }
        .padding(.vertical, 6)
    }
}
