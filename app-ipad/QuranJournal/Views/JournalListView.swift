import SwiftUI
import SwiftData

struct JournalListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]

    @State private var searchText = ""
    @State private var showEditor = false

    private var filtered: [JournalEntry] {
        if searchText.isEmpty { return entries }
        return entries.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
            || $0.body.localizedCaseInsensitiveContains(searchText)
            || $0.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        List {
            ForEach(filtered) { entry in
                NavigationLink(value: entry) {
                    JournalRow(entry: entry)
                }
            }
            .onDelete(perform: delete)
        }
        .searchable(text: $searchText, prompt: "Rechercher dans le journal")
        .navigationDestination(for: JournalEntry.self) { entry in
            JournalEditorView(entry: entry, isNew: false)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showEditor = true
                } label: {
                    Label("Nouvelle entrée", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showEditor) {
            NavigationStack {
                JournalEditorView(entry: JournalEntry(), isNew: true)
            }
        }
        .overlay {
            if filtered.isEmpty {
                ContentUnavailableView(
                    "Aucune entrée",
                    systemImage: "book.pages",
                    description: Text("Appuie sur + pour écrire ta première réflexion.")
                )
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filtered[index])
        }
    }
}

struct JournalRow: View {
    let entry: JournalEntry

    private var dateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: entry.date)
    }

    var body: some View {
        HStack(spacing: 12) {
            Text(entry.moodEnum.emoji)
                .font(.title2)
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.title.isEmpty ? "Sans titre" : entry.title)
                    .font(.headline)
                    .lineLimit(1)
                Text(entry.body.isEmpty ? "—" : entry.body)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                HStack(spacing: 8) {
                    Text(dateString)
                    if !entry.surahRef.isEmpty {
                        Label(entry.surahRef, systemImage: "book.closed")
                    }
                    ForEach(entry.tags, id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.green.opacity(0.12), in: Capsule())
                            .foregroundStyle(Color.green)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
