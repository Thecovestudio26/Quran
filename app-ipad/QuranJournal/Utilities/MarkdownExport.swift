import Foundation

private func dateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "fr_FR")
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}

func markdownExport(entries: [JournalEntry]) -> String {
    var output = "# Journal du Coran\n\nExport du \(dateFormatter().string(from: Date()))\n\n"
    for entry in entries {
        output += "## \(entry.title.isEmpty ? "Sans titre" : entry.title)\n"
        output += "- \(dateFormatter().string(from: entry.date)) — humeur : \(entry.moodEnum.emoji) \(entry.moodEnum.rawValue)\n"
        if !entry.surahRef.isEmpty {
            output += "- Sourate : \(entry.surahRef)\n"
        }
        if !entry.tags.isEmpty {
            output += "- Étiquettes : \(entry.tags.map { "#\($0)" }.joined(separator: " "))\n"
        }
        output += "\n\(entry.body)\n\n---\n\n"
    }
    return output
}

func htmlExport(entries: [JournalEntry]) -> String {
    let esc: (String) -> String = { text in
        text
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
    }
    var body = ""
    body += "<h1 style='font-family:Helvetica,Arial,sans-serif;color:#14532d;'>Journal du Coran</h1>"
    body += "<p style='color:#6b7280;font-family:Helvetica,Arial,sans-serif;'>Export du \(esc(dateFormatter().string(from: Date())))</p><hr>"
    for entry in entries {
        body += "<h2 style='font-family:Helvetica,Arial,sans-serif;color:#14532d;margin-bottom:2pt;'>\(esc(entry.title.isEmpty ? "Sans titre" : entry.title))</h2>"
        body += "<p style='color:#6b7280;font-size:11pt;margin-top:0;'>\(esc(dateFormatter().string(from: entry.date))) — \(esc(entry.moodEnum.emoji)) \(esc(entry.moodEnum.rawValue))"
        if !entry.surahRef.isEmpty {
            body += " — sourate \(esc(entry.surahRef))"
        }
        body += "</p>"
        body += "<p style='font-family:Georgia,serif;'>\(esc(entry.body).replacingOccurrences(of: "\n", with: "<br>"))</p><hr>"
    }
    return "<html><body style='padding:10pt;'>\(body)</body></html>"
}
