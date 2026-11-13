# Journal du Coran — planner imprimable + éditions numériques (iPad & ordi)

Cinq outils pour un journaling spirituel quotidien :

```
quran-journal/
├── planner-imprimable/
│   ├── quran-planner-2027.html      # planner annuel 2027 A4 (225 pages, FR, imprimable)
│   ├── quran-planner-2027-ipad.html # planner annuel 2027 iPad (4:3, navigation + cases interactives)
│   ├── quran-planner-2027-ordi.html # planner annuel 2027 ordinateur (plein écran, saisie clavier)
│   ├── quran-planner-2027-en-pink.html # planner annuel 2027 EN rose (imprimable, dédié à Mariam)
│   └── planner-coran-a4.html        # planner A4 mensuel compact (9 pages, FR)
└── app-ipad/
    ├── QuranJournal.xcodeproj/      # projet Xcode (SwiftUI + SwiftData, iOS 17+)
    ├── QuranJournal/                # sources de l'app
    └── tools/generate_project.py    # régénère le pbxproj + les icônes
```

## 1. Quran Planner 2027 — édition A4 (`planner-imprimable/quran-planner-2027.html`)

Planner annuel complet de 225 pages en français, fidèle au modèle « Quran Planner 2027 » :

- **01 My Year with the Quran** : vision annuelle (intention, objectifs, mot de l'année,
  Q1-Q4), vue d'ensemble des 12 calendriers 2027 et bilan de fin d'année.
- **02 114-Surah Index** : les 114 sourates (nom, nombre d'ayat) avec suivi
  lecture / étude / mémorisation / révision.
- **03 Monthly & Weekly Planning** : 12 mois × 3 pages (focus du mois + calendrier,
  tracker coranique quotidien, bilan du mois) et 52 plannings hebdomadaires.
- **04 Hifdh & Revision** : parcours de Hifdh libre, suivi Juz Amma (J+1 / J+7 / J+30)
  et 4 plannings de révision espacée.
- **05 Study Sheets** : 114 fiches d'étude et de réflexion (contexte, thèmes,
  verset marquant, application, questions).
- **06 Connect with Allah** : du'as, 99 noms d'Allah, prophètes du Coran,
  gratitudes, lettre personnelle.

À l'écran, une barre verte permet de cocher les sections à inclure avant
d'imprimer (masquée automatiquement à l'impression).

**Imprimer depuis l'iPad :** ouvrir le fichier dans Safari (AirDrop / Fichiers / iCloud)
→ choisir les sections dans la barre verte → « Imprimer » (A4, recto ou recto-verso).
Option « Enregistrer en PDF » pour une copie numérique.

## 2. Quran Planner 2027 — édition iPad (`planner-imprimable/quran-planner-2027-ipad.html`)

Même planner (225 pages) au format 4:3 portrait (186 × 248 mm) pour un usage
numérique sur iPad :

- **Navigation par onglets** : barre verte pour sauter à une section, un mois
  (Jan → Déc), les semaines, les révisions, les fiches ou les extras.
- **Cases à cocher interactives** : dans Safari, taper une case la coche /
  la décoche ; l'état est sauvegardé automatiquement sur l'iPad.
- **Écriture manuscrite** : Safari → Partager → Imprimer → pincer l'aperçu pour
  générer un PDF → ouvrir dans GoodNotes / Notability avec l'Apple Pencil.

## 3. Quran Planner 2027 — édition ordinateur (`planner-imprimable/quran-planner-2027-ordi.html`)

Même planner (225 pages), optimisé pour un usage quotidien sur ordinateur :

- **Navigation latérale fixe** : sections, mois (Jan → Déc), semaines, révisions,
  fiches et extras accessibles en un clic.
- **Saisie au clavier** : toutes les lignes pointillées et les cellules vides des
  tableaux (trackers, Hifdh, semaines, fiches d'étude, du'as, 99 noms…) sont
  directement saisissables au clavier.
- **Sauvegarde automatique** : cases cochées et textes sont enregistrés dans le
  navigateur (localStorage, clés dédiées à l'édition ordi) et restaurés à chaque
  ouverture.
- **Compteur de progression** : nombre de cases cochées et barre d'avancement
  dans la barre latérale.
- **Impression / PDF** : bouton « Imprimer / PDF » (ou Ctrl+P) ; la barre latérale
  est automatiquement masquée.
- **Effacement** : bouton « Effacer mes saisies » pour repartir de zéro
  (confirmation demandée).

> Les sauvegardes sont locales au navigateur de l'ordinateur utilisé. Ouvrir le
> fichier dans un autre navigateur ou sur un autre ordi repart d'une page vierge.

## 4. Quran Planner 2027 — English pink edition (`planner-imprimable/quran-planner-2027-en-pink.html`)

Même planner annuel (225 pages), en anglais et en palette rose, prêt à imprimer (A4) :

- Structure identique à l'édition A4 française : vision annuelle, index des 114
  sourates, Hifdh & Juz Amma, 12 mois × 3 pages, 52 semaines, révisions espacées,
  114 fiches d'étude et extras.
- **Palette rose** (rose foncé `#9d174d` + rose vif `#db2777`) sur toutes les
  pages : couverture, en-têtes de tableaux, cases à cocher et barre d'impression.
- **Crédit de couverture : Librairie Islamique 237** et **dédicace pour Mariam** :
  « For Mariam, as a sadaka, my beloved cousin, love you and may Allah guide you
  and protect you. May we meet in this life every time and enjoy our time.
  And in Jannah. »
- Barre d'impression à l'écran (rose) pour choisir les sections à inclure avant
  d'imprimer, comme sur l'édition A4 française.

## 5. Planner mensuel compact (`planner-imprimable/planner-coran-a4.html`)

Planner A4 en français, 9 pages : couverture, objectifs du mois, calendrier du mois
(choisir le mois/année en haut de la page 3), suivi des 30 juz, **une page journalière
exemple remplie**, une page journalière vierge à photocopier, tracker d'habitudes sur
4 semaines, liste de douaas, notes libres.

## 6. App iPad (`app-ipad/`)

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
