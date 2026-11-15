import SwiftUI
import SwiftData

struct RootView: View {
    enum Destination: String, CaseIterable, Identifiable {
        case home = "Accueil"
        case journal = "Journal"
        case surahs = "Sourates"
        case planner = "Planning"
        case settings = "Réglages"

        var id: String { rawValue }

        var icon: String {
            switch self {
            case .home: return "house.fill"
            case .journal: return "book.pages.fill"
            case .surahs: return "book.closed.fill"
            case .planner: return "calendar"
            case .settings: return "gearshape.fill"
            }
        }
    }

    @State private var selection: Destination? = .home

    var body: some View {
        NavigationSplitView {
            List(Destination.allCases, selection: $selection) { destination in
                Label(destination.rawValue, systemImage: destination.icon)
            }
            .navigationTitle("Journal du Coran")
        } detail: {
            NavigationStack {
                Group {
                    switch selection ?? .home {
                    case .home: HomeView()
                    case .journal: JournalListView()
                    case .surahs: SurahsView()
                    case .planner: PlannerView()
                    case .settings: SettingsView()
                    }
                }
                .navigationTitle((selection ?? .home).rawValue)
            }
        }
    }
}
