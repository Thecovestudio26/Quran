import Foundation
import SwiftData

enum Mood: String, CaseIterable, Identifiable {
    case joyeux = "Joyeux"
    case calme = "Calme"
    case reconnaissant = "Reconnaissant"
    case motive = "Motivé"
    case reflechi = "Réfléchi"
    case apaise = "Apaisé"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .joyeux: return "😊"
        case .calme: return "🌿"
        case .reconnaissant: return "🤲"
        case .motive: return "🔥"
        case .reflechi: return "🕯️"
        case .apaise: return "☁️"
        }
    }
}

@Model
final class JournalEntry: Identifiable, Hashable {
    var id: UUID
    var date: Date
    var title: String
    var body: String
    var mood: String
    var tags: [String]
    var surahRef: String
    var isDailyReflection: Bool

    init(
        date: Date = Date(),
        title: String = "",
        body: String = "",
        mood: Mood = .calme,
        tags: [String] = [],
        surahRef: String = "",
        isDailyReflection: Bool = false
    ) {
        self.id = UUID()
        self.date = date
        self.title = title
        self.body = body
        self.mood = mood.rawValue
        self.tags = tags
        self.surahRef = surahRef
        self.isDailyReflection = isDailyReflection
    }

    var moodEnum: Mood {
        Mood(rawValue: mood) ?? .calme
    }

    static func == (lhs: JournalEntry, rhs: JournalEntry) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Model
final class SurahProgress {
    var surahNumber: Int
    var percentRead: Double
    var percentMemorized: Double
    var lastRead: Date?

    init(surahNumber: Int, percentRead: Double = 0, percentMemorized: Double = 0, lastRead: Date? = nil) {
        self.surahNumber = surahNumber
        self.percentRead = percentRead
        self.percentMemorized = percentMemorized
        self.lastRead = lastRead
    }
}
