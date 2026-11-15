import SwiftUI
import SwiftData

struct PlannerView: View {
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]

    @State private var displayedMonth: Date
    @State private var selectedDay: Date?

    private let calendar = Calendar.current
    private let weekdaySymbols = ["Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"]

    init() {
        let now = Date()
        let start = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: now)) ?? now
        _displayedMonth = State(initialValue: start)
    }

    private var monthTitle: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return formatter.string(from: displayedMonth).capitalized
    }

    private var days: [Date?] {
        guard let range = calendar.range(of: .day, in: .month, for: displayedMonth),
              let first = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth))
        else { return [] }
        let firstWeekday = (calendar.component(.weekday, from: first) + 5) % 7 // lundi = 0
        var result: [Date?] = Array(repeating: nil, count: firstWeekday)
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: first) {
                result.append(date)
            }
        }
        while result.count % 7 != 0 { result.append(nil) }
        return result
    }

    private func entries(on day: Date) -> [JournalEntry] {
        entries.filter { calendar.isDate($0.date, inSameDayAs: day) }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                monthHeader
                calendarGrid
                dayDetail
            }
            .padding(24)
        }
        .background(Color(.systemGroupedBackground))
    }

    private var monthHeader: some View {
        HStack {
            Button {
                if let new = calendar.date(byAdding: .month, value: -1, to: displayedMonth) {
                    displayedMonth = new
                    selectedDay = nil
                }
            } label: {
                Image(systemName: "chevron.left")
            }
            Spacer()
            Text(monthTitle)
                .font(.title2.bold())
            Spacer()
            Button {
                if let new = calendar.date(byAdding: .month, value: 1, to: displayedMonth) {
                    displayedMonth = new
                    selectedDay = nil
                }
            } label: {
                Image(systemName: "chevron.right")
            }
        }
    }

    private var calendarGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
            ForEach(weekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
            ForEach(days.indices, id: \.self) { index in
                if let day = days[index] {
                    DayCell(
                        day: day,
                        isToday: calendar.isDateInToday(day),
                        isSelected: selectedDay.map { calendar.isDate($0, inSameDayAs: day) } ?? false,
                        count: entries(on: day).count
                    )
                    .onTapGesture { selectedDay = day }
                } else {
                    Color.clear.frame(height: 64)
                }
            }
        }
        .padding(16)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var dayDetail: some View {
        Group {
            if let selectedDay {
                VStack(alignment: .leading, spacing: 10) {
                    Text(selectedDay.formatted(date: .long, time: .omitted))
                        .font(.headline)
                    let dayEntries = entries(on: selectedDay)
                    if dayEntries.isEmpty {
                        Text("Aucune entrée ce jour-là.")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(dayEntries) { entry in
                            HStack {
                                Text(entry.moodEnum.emoji)
                                VStack(alignment: .leading) {
                                    Text(entry.title.isEmpty ? "Sans titre" : entry.title)
                                        .font(.subheadline.bold())
                                    Text(entry.body)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(2)
                                }
                            }
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
        }
    }
}

struct DayCell: View {
    let day: Date
    let isToday: Bool
    let isSelected: Bool
    let count: Int

    var body: some View {
        VStack(spacing: 4) {
            Text("\(Calendar.current.component(.day, from: day))")
                .font(.subheadline.bold())
                .foregroundStyle(isToday ? .white : .primary)
            if count > 0 {
                HStack(spacing: 3) {
                    ForEach(0..<min(count, 3), id: \.self) { _ in
                        Circle()
                            .fill(isToday ? .white : Color.green)
                            .frame(width: 6, height: 6)
                    }
                }
            } else {
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 64)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(isToday ? Color.orange : (isSelected ? Color.green.opacity(0.25) : Color(.tertiarySystemGroupedBackground)))
        )
    }
}
