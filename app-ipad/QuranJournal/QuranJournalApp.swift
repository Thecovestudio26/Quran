import SwiftUI
import SwiftData

@main
struct QuranJournalApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([JournalEntry.self, SurahProgress.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Impossible d'ouvrir la base locale du journal: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(sharedModelContainer)
    }
}
