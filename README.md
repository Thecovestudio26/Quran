# Journal du Coran — planner imprimable + app iPad

Deux outils pour un journaling spirituel quotidien :

```
quran-journal/
├── planner-imprimable/
│   └── planner-coran-a4.html     # planner A4 prêt à imprimer (9 pages, FR)
└── app-ipad/
    ├── QuranJournal.xcodeproj/   # projet Xcode (SwiftUI + SwiftData, iOS 17+)
    ├── QuranJournal/             # sources de l'app
    └── tools/generate_project.py # régénère le pbxproj + les icônes
```

## 1. Planner imprimable (`planner-imprimable/planner-coran-a4.html`)

Planner A4 en français, 9 pages : couverture, objectifs du mois, calendrier du mois
(choisir le mois/année en haut de la page 3), suivi des 30 juz, **une page journalière
exemple remplie**, une page journalière vierge à photocopier, tracker d'habitudes sur
4 semaines, liste de douaas, notes libres.

**Imprimer depuis l'iPad :** ouvrir le fichier dans Safari (AirDrop / Fichiers / iCloud)
→ Partager → **Imprimer** (format A4, recto ou recto-verso). Option « Enregistrer en PDF »
pour garder une copie numérique.

## 2. App iPad (`app-ipad/`)

App SwiftUI native, optimisée iPad (NavigationSplitView), iOS/iPadOS 17+ (SwiftData) :

- **Accueil** : verset du jour (arabe + français), date hégirienne, série de jours,
  statistiques, bouton « réflexion du jour ».
- **Journal** : entrées avec titre, texte, humeur, étiquettes, référence de sourate ;
  recherche, suppression par balayage.
- **Sourates** : les 114 sourates (noms FR/AR, nombre de versets), recherche, suivi de
  lecture et de mémorisation en %.
- **Planning** : calendrier mensuel avec les entrées du journal marquées par des points.
- **Réglages** : export du journal en Markdown (partage) et **impression AirPrint**.

Données 100 % locales (SwiftData, aucun réseau).

### Ouvrir dans Xcode

1. Double-cliquer sur `app-ipad/QuranJournal.xcodeproj` (macOS + Xcode 15+ recommandé).
2. Sélectionner une équipe de développement dans *Signing & Capabilities* si besoin,
   ou laisser « Automatically manage signing » avec un Apple ID gratuit.
3. Choisir une cible iPad (ou « Any iOS Device ») → ▶ Run.

Le bundle ID par défaut est `app.quranjournal.journal` — à personnaliser dans
*Signing & Capabilities* / build settings (`PRODUCT_BUNDLE_IDENTIFIER`).

> Si le projet est régénéré (`python3 tools/generate_project.py`, nécessite `pip install pillow`),
> les icônes et le `project.pbxproj` sont recréés automatiquement.

### Licence des versets

Les traductions françaises des versets sont celles de Muhammad Hamidullah (diffusion
Tanzil), reproduites ici à titre indicatif pour un **usage personnel et non commercial**.
Avant toute diffusion publique de l'app, remplacer par une traduction sous licence
adaptée et créditer sa source.
