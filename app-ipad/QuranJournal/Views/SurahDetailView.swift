import SwiftUI
import SwiftData

struct SurahDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let surah: Surah
    @State private var progress: SurahProgress?

    init(surah: Surah, progress: SurahProgress?) {
        self.surah = surah
        self._progress = State(initialValue: progress)
    }

    private func ensureProgress() -> SurahProgress {
        if let progress { return progress }
        let new = SurahProgress(surahNumber: surah.number)
        modelContext.insert(new)
        progress = new
        return new
    }

    var body: some View {
        Form {
            Section {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(surah.nameFr)
                            .font(.title2.bold())
                        Text("\(surah.ayahCount) versets")
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text(surah.nameAr)
                        .font(.largeTitle)
                        .foregroundStyle(Color.green)
                }
            }

            Section("Lecture") {
                HStack {
                    Text("Progression de lecture")
                    Spacer()
                    Text("\(Int(progress?.percentRead ?? 0)) %")
                        .foregroundStyle(.secondary)
                }
                Slider(
                    value: Binding(
                        get: { progress?.percentRead ?? 0 },
                        set: { ensureProgress().percentRead = $0 }
                    ),
                    in: 0...100,
                    step: 1
                )
                .tint(.green)
                Button("Marquer comme lu") {
                    let p = ensureProgress()
                    p.percentRead = 100
                    p.lastRead = Date()
                }
            }

            Section("Mémorisation") {
                HStack {
                    Text("Progression de mémorisation")
                    Spacer()
                    Text("\(Int(progress?.percentMemorized ?? 0)) %")
                        .foregroundStyle(.secondary)
                }
                Slider(
                    value: Binding(
                        get: { progress?.percentMemorized ?? 0 },
                        set: { ensureProgress().percentMemorized = $0 }
                    ),
                    in: 0...100,
                    step: 1
                )
                .tint(.orange)
                if let lastRead = progress?.lastRead {
                    Text("Dernière lecture : \(lastRead.formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Section {
                Button("Réinitialiser", role: .destructive) {
                    if let progress {
                        progress.percentRead = 0
                        progress.percentMemorized = 0
                        progress.lastRead = nil
                    }
                }
            }
        }
        .navigationTitle("Sourate \(surah.number)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Terminé") {
                    try? modelContext.save()
                    dismiss()
                }
            }
        }
    }
}
