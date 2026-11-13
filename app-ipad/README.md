# Journal du Coran — app iPad

App SwiftUI + SwiftData (iOS/iPadOS 17+). Voir le README à la racine pour l'installation.

## Architecture

```
QuranJournal/
├── QuranJournalApp.swift      # @main + ModelContainer (JournalEntry, SurahProgress)
├── Info.plist                 # orientations iPad, launch screen couleur
├── Assets.xcassets/           # AccentColor, LaunchBackground, AppIcon (PNG générés)
├── Models/
│   ├── Models.swift           # @Model JournalEntry / SurahProgress, enum Mood
│   └── QuranData.swift        # 114 sourates, versets du jour, date hégirienne
├── Views/
│   ├── RootView.swift         # NavigationSplitView (sidebar iPad)
│   ├── HomeView.swift         # accueil : verset du jour, streak, stats, réflexion
│   ├── JournalListView.swift  # liste + recherche + navigation vers l'éditeur
│   ├── JournalEditorView.swift# éditeur d'entrée (titre, texte, humeur, tags)
│   ├── SurahsView.swift       # liste des 114 sourates + progression
│   ├── SurahDetailView.swift  # sliders lecture / mémorisation
│   ├── PlannerView.swift      # calendrier mensuel avec entrées du journal
│   └── SettingsView.swift     # export Markdown, impression AirPrint, à propos
└── Utilities/
    ├── MarkdownExport.swift   # export Markdown + HTML (impression)
    ├── ShareSheet.swift       # UIActivityViewController
    └── PrintExport.swift      # UIPrintInteractionController
```

## Régénérer le projet Xcode

```bash
cd app-ipad
pip install pillow
python3 tools/generate_project.py
```

Cela recrée `QuranJournal.xcodeproj/project.pbxproj` (en listant automatiquement les
fichiers `.swift` présents) et les assets (couleurs + icônes PNG).

## Notes

- Bundle ID par défaut : `app.quranjournal.journal` (à changer dans les build settings).
- Traductions des versets : Muhammad Hamidullah via Tanzil — usage personnel non
  commercial uniquement ; à remplacer/licencier avant diffusion publique.
- Données locales uniquement (SwiftData), aucune connexion réseau.
