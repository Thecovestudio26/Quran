import SwiftUI
import SwiftData

struct SettingsView: View {
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]

    @State private var showShare = false
    @State private var shareItems: [Any] = []
    @State private var printHTML = ""
    @State private var showPrint = false

    var body: some View {
        Form {
            Section("Mon journal") {
                Button {
                    shareItems = [markdownExport(entries: entries)]
                    showShare = true
                } label: {
                    Label("Exporter en Markdown / partager", systemImage: "square.and.arrow.up")
                }

                Button {
                    printHTML = htmlExport(entries: entries)
                    showPrint = true
                } label: {
                    Label("Imprimer mon journal", systemImage: "printer")
                }
                .background(PrintController(html: printHTML, trigger: $showPrint))
            }

            Section("Données") {
                LabeledContent("Entrées enregistrées", value: "\(entries.count)")
            }

            Section("À propos") {
                Text("Journal du Coran — app iPad pour le journaling spirituel : verset du jour, journal, suivi des 114 sourates, planning.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Text("Traduction française des versets : Muhammad Hamidullah (via Tanzil), reproduite ici à titre indicatif pour un usage personnel et non commercial. Données locales uniquement : rien n'est envoyé sur Internet.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .sheet(isPresented: $showShare) {
            ShareSheet(items: shareItems)
        }
    }
}
