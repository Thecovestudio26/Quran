import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]
    @Query private var progresses: [SurahProgress]

    @State private var prompt = randomPrompt()
    @State private var editorEntry: JournalEntry?

    private var todayAyah: Ayah { ayahOfTheDay() }

    private var streak: Int {
        let calendar = Calendar.current
        let days = Set(entries.map { calendar.startOfDay(for: $0.date) })
        var count = 0
        var cursor = calendar.startOfDay(for: Date())
        if !days.contains(cursor) {
            guard let yesterday = calendar.date(byAdding: .day, value: -1, to: cursor) else { return 0 }
            cursor = yesterday
        }
        while days.contains(cursor) {
            count += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: cursor) else { break }
            cursor = previous
        }
        return count
    }

    private var entriesThisMonth: Int {
        let calendar = Calendar.current
        let now = Date()
        return entries.filter {
            calendar.isDate($0.date, equalTo: now, toGranularity: .month)
        }.count
    }

    private var globalReadPercent: Double {
        guard !progresses.isEmpty else { return 0 }
        return progresses.reduce(0.0) { $0 + $1.percentRead } / Double(SURAHS.count)
    }

    private var surahsInProgress: Int {
        progresses.filter { $0.percentRead > 0 && $0.percentRead < 100 }.count
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header
                ayahCard
                statsGrid
                quickActions
            }
            .padding(24)
        }
        .background(Color(.systemGroupedBackground))
        .sheet(item: $editorEntry) { entry in
            NavigationStack {
                JournalEditorView(entry: entry, isNew: true)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(greeting())
                .font(.largeTitle.bold())
            Text(formattedDate())
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Date hégirienne (approx.) : \(hijriDateString())")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var ayahCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Verset du jour", systemImage: "sparkles")
                    .font(.headline)
                    .foregroundStyle(Color.green)
                Spacer()
                Text("Sourate \(todayAyah.ref)")
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.green, in: Capsule())
            }
            Text(todayAyah.arabic)
                .font(.title3)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineSpacing(6)
            Text(todayAyah.french)
                .font(.body)
                .italic()
                .foregroundStyle(.primary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.green.opacity(0.08))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.green.opacity(0.35), lineWidth: 1)
        )
    }

    private var statsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            StatCard(value: "\(streak)", label: "jours de suite", icon: "flame.fill", color: .orange)
            StatCard(value: "\(entriesThisMonth)", label: "entrées ce mois", icon: "pencil.and.list.clipboard", color: .green)
            StatCard(value: "\(surahsInProgress)", label: "sourates en cours", icon: "book.fill", color: .blue)
            StatCard(value: String(format: "%.0f %%", globalReadPercent), label: "du Coran lu", icon: "chart.pie.fill", color: .purple)
        }
    }

    private var quickActions: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Réflexion du jour")
                .font(.headline)
            Text("\(prompt)")
                .font(.body)
                .italic()
                .foregroundStyle(.secondary)
            Button {
                editorEntry = JournalEntry(isDailyReflection: true)
            } label: {
                Label("Écrire ma réflexion", systemImage: "square.and.pencil")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.green)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private func greeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<5: return "Bonne nuit"
        case 5..<12: return "Bonjour"
        case 12..<18: return "Bonne après-midi"
        default: return "Bonsoir"
        }
    }

    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = .full
        return formatter.string(from: Date())
    }
}

struct StatCard: View {
    let value: String
    let label: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            Text(value)
                .font(.title.bold())
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
