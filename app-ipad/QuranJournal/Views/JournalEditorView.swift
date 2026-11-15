import SwiftUI
import SwiftData

struct JournalEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var entry: JournalEntry
    let isNew: Bool

    @State private var tagsText: String = ""

    var body: some View {
        Form {
            Section("Date") {
                DatePicker("Date", selection: $entry.date)
            }

            Section("Écriture") {
                TextField("Titre", text: $entry.title)
                    .font(.headline)
                TextEditor(text: $entry.body)
                    .frame(minHeight: 220)
            }

            Section("Humeur") {
                Picker("Humeur", selection: Binding(get: { selectedMood }, set: { entry.mood = $0.rawValue })) {
                    ForEach(Mood.allCases) { mood in
                        Text("\(mood.emoji) \(mood.rawValue)").tag(mood)
                    }
                }
                .pickerStyle(.inline)
            }

            Section("Détails") {
                TextField("Référence de sourate (ex. 2:255)", text: $entry.surahRef)
                TextField("Étiquettes, séparées par des virgules", text: $tagsText)
                Toggle("Réflexion quotidienne", isOn: $entry.isDailyReflection)
            }
        }
        .navigationTitle(isNew ? "Nouvelle entrée" : "Modifier l'entrée")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Annuler") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Enregistrer") {
                    entry.tags = tagsText
                        .split(separator: ",")
                        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                        .filter { !$0.isEmpty }
                    if isNew {
                        modelContext.insert(entry)
                    }
                    try? modelContext.save()
                    dismiss()
                }
                .bold()
            }
        }
        .onAppear {
            tagsText = entry.tags.joined(separator: ", ")
        }
    }
}
