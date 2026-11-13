import Foundation

struct Surah: Identifiable {
    let number: Int
    let nameFr: String
    let nameAr: String
    let ayahCount: Int

    var id: Int { number }
}

// (numéro, nom français, nom arabe, nombre de versets)
let SURAHS: [Surah] = [
    Surah(number: 1, nameFr: "Al-Fâtiha — L'Ouverture", nameAr: "الفاتحة", ayahCount: 7),
    Surah(number: 2, nameFr: "Al-Baqara — La Vache", nameAr: "البقرة", ayahCount: 286),
    Surah(number: 3, nameFr: "Âl 'Imrân — La Famille d'Imran", nameAr: "آل عمران", ayahCount: 200),
    Surah(number: 4, nameFr: "An-Nisâ' — Les Femmes", nameAr: "النساء", ayahCount: 176),
    Surah(number: 5, nameFr: "Al-Mâ'ida — La Table servie", nameAr: "المائدة", ayahCount: 120),
    Surah(number: 6, nameFr: "Al-An'âm — Les Bestiaux", nameAr: "الأنعام", ayahCount: 165),
    Surah(number: 7, nameFr: "Al-A'râf — Les Hauteurs", nameAr: "الأعراف", ayahCount: 206),
    Surah(number: 8, nameFr: "Al-Anfâl — Le Butin", nameAr: "الأنفال", ayahCount: 75),
    Surah(number: 9, nameFr: "At-Tawba — Le Repentir", nameAr: "التوبة", ayahCount: 129),
    Surah(number: 10, nameFr: "Yûnus — Jonas", nameAr: "يونس", ayahCount: 109),
    Surah(number: 11, nameFr: "Hûd", nameAr: "هود", ayahCount: 123),
    Surah(number: 12, nameFr: "Yûsuf — Joseph", nameAr: "يوسف", ayahCount: 111),
    Surah(number: 13, nameFr: "Ar-Ra'd — Le Tonnerre", nameAr: "الرعد", ayahCount: 43),
    Surah(number: 14, nameFr: "Ibrâhîm — Abraham", nameAr: "إبراهيم", ayahCount: 52),
    Surah(number: 15, nameFr: "Al-Hijr", nameAr: "الحجر", ayahCount: 99),
    Surah(number: 16, nameFr: "An-Nahl — L'Abeille", nameAr: "النحل", ayahCount: 128),
    Surah(number: 17, nameFr: "Al-Isrâ' — Le Voyage nocturne", nameAr: "الإسراء", ayahCount: 111),
    Surah(number: 18, nameFr: "Al-Kahf — La Caverne", nameAr: "الكهف", ayahCount: 110),
    Surah(number: 19, nameFr: "Maryam — Marie", nameAr: "مريم", ayahCount: 98),
    Surah(number: 20, nameFr: "Tâ-Hâ", nameAr: "طه", ayahCount: 135),
    Surah(number: 21, nameFr: "Al-Anbiyâ' — Les Prophètes", nameAr: "الأنبياء", ayahCount: 112),
    Surah(number: 22, nameFr: "Al-Hajj — Le Pèlerinage", nameAr: "الحج", ayahCount: 78),
    Surah(number: 23, nameFr: "Al-Mu'minûn — Les Croyants", nameAr: "المؤمنون", ayahCount: 118),
    Surah(number: 24, nameFr: "An-Nûr — La Lumière", nameAr: "النور", ayahCount: 64),
    Surah(number: 25, nameFr: "Al-Furqân — Le Discernement", nameAr: "الفرقان", ayahCount: 77),
    Surah(number: 26, nameFr: "Ash-Shu'arâ' — Les Poètes", nameAr: "الشعراء", ayahCount: 227),
    Surah(number: 27, nameFr: "An-Naml — La Fourmi", nameAr: "النمل", ayahCount: 93),
    Surah(number: 28, nameFr: "Al-Qasas — Le Récit", nameAr: "القصص", ayahCount: 88),
    Surah(number: 29, nameFr: "Al-'Ankabût — L'Araignée", nameAr: "العنكبوت", ayahCount: 69),
    Surah(number: 30, nameFr: "Ar-Rûm — Les Byzantins", nameAr: "الروم", ayahCount: 60),
    Surah(number: 31, nameFr: "Luqmân", nameAr: "لقمان", ayahCount: 34),
    Surah(number: 32, nameFr: "As-Sajda — La Prosternation", nameAr: "السجدة", ayahCount: 30),
    Surah(number: 33, nameFr: "Al-Ahzâb — Les Coalisés", nameAr: "الأحزاب", ayahCount: 73),
    Surah(number: 34, nameFr: "Sabâ'", nameAr: "سبأ", ayahCount: 54),
    Surah(number: 35, nameFr: "Fâtir — Le Créateur", nameAr: "فاطر", ayahCount: 45),
    Surah(number: 36, nameFr: "Yâ-Sîn", nameAr: "يس", ayahCount: 83),
    Surah(number: 37, nameFr: "As-Sâffât — Les Rangés en rangs", nameAr: "الصافات", ayahCount: 182),
    Surah(number: 38, nameFr: "Sâd", nameAr: "ص", ayahCount: 88),
    Surah(number: 39, nameFr: "Az-Zumar — Les Groupes", nameAr: "الزمر", ayahCount: 75),
    Surah(number: 40, nameFr: "Ghâfir — Le Pardonneur", nameAr: "غافر", ayahCount: 85),
    Surah(number: 41, nameFr: "Fussilat — Exposé en détail", nameAr: "فصلت", ayahCount: 54),
    Surah(number: 42, nameFr: "Ash-Shûrâ — La Consultation", nameAr: "الشورى", ayahCount: 53),
    Surah(number: 43, nameFr: "Az-Zukhruf — L'Ornement", nameAr: "الزخرف", ayahCount: 89),
    Surah(number: 44, nameFr: "Ad-Dukhân — La Fumée", nameAr: "الدخان", ayahCount: 59),
    Surah(number: 45, nameFr: "Al-Jâthiya — L'Agenouillée", nameAr: "الجاثية", ayahCount: 37),
    Surah(number: 46, nameFr: "Al-Ahqâf — Les Dunes", nameAr: "الأحقاف", ayahCount: 35),
    Surah(number: 47, nameFr: "Muhammad", nameAr: "محمد", ayahCount: 38),
    Surah(number: 48, nameFr: "Al-Fath — La Victoire", nameAr: "الفتح", ayahCount: 29),
    Surah(number: 49, nameFr: "Al-Hujurât — Les Appartements privés", nameAr: "الحجرات", ayahCount: 18),
    Surah(number: 50, nameFr: "Qâf", nameAr: "ق", ayahCount: 45),
    Surah(number: 51, nameFr: "Adh-Dhâriyât — Celles qui éparpillent", nameAr: "الذاريات", ayahCount: 60),
    Surah(number: 52, nameFr: "At-Tûr — Le Mont", nameAr: "الطور", ayahCount: 49),
    Surah(number: 53, nameFr: "An-Najm — L'Étoile", nameAr: "النجم", ayahCount: 62),
    Surah(number: 54, nameFr: "Al-Qamar — La Lune", nameAr: "القمر", ayahCount: 55),
    Surah(number: 55, nameFr: "Ar-Rahmân — Le Tout Miséricordieux", nameAr: "الرحمن", ayahCount: 78),
    Surah(number: 56, nameFr: "Al-Wâqi'a — L'Événement inévitable", nameAr: "الواقعة", ayahCount: 96),
    Surah(number: 57, nameFr: "Al-Hadîd — Le Fer", nameAr: "الحديد", ayahCount: 29),
    Surah(number: 58, nameFr: "Al-Mujâdila — La Discussion", nameAr: "المجادلة", ayahCount: 22),
    Surah(number: 59, nameFr: "Al-Hashr — Le Rassemblement", nameAr: "الحشر", ayahCount: 24),
    Surah(number: 60, nameFr: "Al-Mumtahina — Celle qui est éprouvée", nameAr: "الممتحنة", ayahCount: 13),
    Surah(number: 61, nameFr: "As-Saff — Le Rang", nameAr: "الصف", ayahCount: 14),
    Surah(number: 62, nameFr: "Al-Jumu'a — L'Assemblée du vendredi", nameAr: "الجمعة", ayahCount: 11),
    Surah(number: 63, nameFr: "Al-Munâfiqûn — Les Hypocrites", nameAr: "المنافقون", ayahCount: 11),
    Surah(number: 64, nameFr: "At-Taghâbun — La Grande Perte", nameAr: "التغابن", ayahCount: 18),
    Surah(number: 65, nameFr: "At-Talâq — Le Divorce", nameAr: "الطلاق", ayahCount: 12),
    Surah(number: 66, nameFr: "At-Tahrîm — L'Interdiction", nameAr: "التحريم", ayahCount: 12),
    Surah(number: 67, nameFr: "Al-Mulk — Le Royaume", nameAr: "الملك", ayahCount: 30),
    Surah(number: 68, nameFr: "Al-Qalam — Le Calame", nameAr: "القلم", ayahCount: 52),
    Surah(number: 69, nameFr: "Al-Hâqqa — Celle de vérité", nameAr: "الحاقة", ayahCount: 52),
    Surah(number: 70, nameFr: "Al-Ma'ârij — Les Degrés", nameAr: "المعارج", ayahCount: 44),
    Surah(number: 71, nameFr: "Nūh — Noé", nameAr: "نوح", ayahCount: 28),
    Surah(number: 72, nameFr: "Al-Jinn — Les Djinns", nameAr: "الجن", ayahCount: 28),
    Surah(number: 73, nameFr: "Al-Muzzammil — L'Enveloppé", nameAr: "المزمل", ayahCount: 20),
    Surah(number: 74, nameFr: "Al-Muddathir — Le Revêtu d'un manteau", nameAr: "المدثر", ayahCount: 56),
    Surah(number: 75, nameFr: "Al-Qiyâma — La Résurrection", nameAr: "القيامة", ayahCount: 40),
    Surah(number: 76, nameFr: "Al-Insân — L'Homme", nameAr: "الإنسان", ayahCount: 31),
    Surah(number: 77, nameFr: "Al-Mursalat — Les Envoyées", nameAr: "المرسلات", ayahCount: 50),
    Surah(number: 78, nameFr: "An-Nabâ' — La Grande Nouvelle", nameAr: "النبأ", ayahCount: 40),
    Surah(number: 79, nameFr: "An-Nâzi'ât — Les Arracheuses", nameAr: "النازعات", ayahCount: 46),
    Surah(number: 80, nameFr: "'Abasa — Il s'est renfrogné", nameAr: "عبس", ayahCount: 42),
    Surah(number: 81, nameFr: "At-Takwîr — L'Obscurcissement", nameAr: "التكوير", ayahCount: 29),
    Surah(number: 82, nameFr: "Al-Infitar — La Fente", nameAr: "الانفطار", ayahCount: 19),
    Surah(number: 83, nameFr: "Al-Mutaffifîn — Les Fraudeurs", nameAr: "المطففين", ayahCount: 36),
    Surah(number: 84, nameFr: "Al-Inshiqâq — La Fente dans le ciel", nameAr: "الانشقاق", ayahCount: 25),
    Surah(number: 85, nameFr: "Al-Burûj — Les Constellations", nameAr: "البروج", ayahCount: 22),
    Surah(number: 86, nameFr: "At-Târiq — L'Astre nocturne", nameAr: "الطارق", ayahCount: 17),
    Surah(number: 87, nameFr: "Al-A'lâ — Le Très-Haut", nameAr: "الأعلى", ayahCount: 19),
    Surah(number: 88, nameFr: "Al-Ghâshiya — L'Enveloppante", nameAr: "الغاشية", ayahCount: 26),
    Surah(number: 89, nameFr: "Al-Fajr — L'Aube", nameAr: "الفجر", ayahCount: 30),
    Surah(number: 90, nameFr: "Al-Balad — La Cité", nameAr: "البلد", ayahCount: 20),
    Surah(number: 91, nameFr: "Ash-Shams — Le Soleil", nameAr: "الشمس", ayahCount: 15),
    Surah(number: 92, nameFr: "Al-Layl — La Nuit", nameAr: "الليل", ayahCount: 21),
    Surah(number: 93, nameFr: "Ad-Duhâ — Le Jour montant", nameAr: "الضحى", ayahCount: 11),
    Surah(number: 94, nameFr: "Ash-Sharh — L'Ouverture de la poitrine", nameAr: "الشرح", ayahCount: 8),
    Surah(number: 95, nameFr: "At-Tîn — Le Figuier", nameAr: "التين", ayahCount: 8),
    Surah(number: 96, nameFr: "Al-'Alaq — L'Adhérence", nameAr: "العلق", ayahCount: 19),
    Surah(number: 97, nameFr: "Al-Qadr — La Destinée", nameAr: "القدر", ayahCount: 5),
    Surah(number: 98, nameFr: "Al-Bayyina — La Preuve claire", nameAr: "البينة", ayahCount: 8),
    Surah(number: 99, nameFr: "Az-Zalzala — Le Séisme", nameAr: "الزلزلة", ayahCount: 8),
    Surah(number: 100, nameFr: "Al-'Âdiyât — Les Coursières", nameAr: "العاديات", ayahCount: 11),
    Surah(number: 101, nameFr: "Al-Qâri'a — Le Fracas", nameAr: "القارعة", ayahCount: 11),
    Surah(number: 102, nameFr: "At-Takâthur — La Rivalité dans l'accumulation", nameAr: "التكاثر", ayahCount: 8),
    Surah(number: 103, nameFr: "Al-'Asr — Le Temps", nameAr: "العصر", ayahCount: 3),
    Surah(number: 104, nameFr: "Al-Humaza — Le Calomniateur", nameAr: "الهمزة", ayahCount: 9),
    Surah(number: 105, nameFr: "Al-Fîl — L'Éléphant", nameAr: "الفيل", ayahCount: 5),
    Surah(number: 106, nameFr: "Quraysh", nameAr: "قريش", ayahCount: 4),
    Surah(number: 107, nameFr: "Al-Mâ'ûn — L'Ustensile", nameAr: "الماعون", ayahCount: 7),
    Surah(number: 108, nameFr: "Al-Kawthar — L'Abondance", nameAr: "الكوثر", ayahCount: 3),
    Surah(number: 109, nameFr: "Al-Kâfirûn — Les Mécréants", nameAr: "الكافرون", ayahCount: 6),
    Surah(number: 110, nameFr: "An-Nasr — Le Secours divin", nameAr: "النصر", ayahCount: 3),
    Surah(number: 111, nameFr: "Al-Masad — La Corde de fibre", nameAr: "المسد", ayahCount: 5),
    Surah(number: 112, nameFr: "Al-Ikhlâs — La Purification de la foi", nameAr: "الإخلاص", ayahCount: 4),
    Surah(number: 113, nameFr: "Al-Falaq — L'Aube naissante", nameAr: "الفلق", ayahCount: 5),
    Surah(number: 114, nameFr: "An-Nâs — Les Hommes", nameAr: "الناس", ayahCount: 6),
]

struct Ayah: Identifiable {
    let id = UUID()
    let ref: String
    let arabic: String
    let french: String
}

// Traduction française : Muhammad Hamidullah (diffusion Tanzil, usage non commercial avec attribution).
// Voir README — remplacer par une traduction sous licence adaptée si besoin.
let AYAHS: [Ayah] = [
    Ayah(ref: "112:1-4", arabic: "قُلْ هُوَ اللَّهُ أَحَدٌ ۝ اللَّهُ الصَّمَدُ ۝ لَمْ يَلِدْ وَلَمْ يُولَدْ ۝ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ", french: "Dis : « Il est Allah, Un. Allah, le Se suffisant à Lui-même. Il n'a ni engendré ni été engendré, et nul n'est égal à Lui. »"),
    Ayah(ref: "113:1-5", arabic: "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۝ مِن شَرِّ مَا خَلَقَ ۝ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ۝ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ۝ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ", french: "Dis : « Je cherche refuge auprès du Seigneur de l'aube naissante, contre le mal des êtres qu'Il a créés, contre le mal de l'obscurité quand elle s'installe, contre le mal des souffleuses dans les nœuds, et contre le mal de l'envieux quand il envie. »"),
    Ayah(ref: "114:1-6", arabic: "قُلْ أَعُوذُ بِرَبِّ النَّاسِ ۝ مَلِكِ النَّاسِ ۝ إِلَهِ النَّاسِ ۝ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۝ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ۝ مِنَ الْجِنَّةِ وَالنَّاسِ", french: "Dis : « Je cherche refuge auprès du Seigneur des hommes, le Roi des hommes, le Dieu des hommes, contre le mal du chuchoteur insidieux qui souffle dans les poitrines des hommes, qu'il soit djinn ou homme. »"),
    Ayah(ref: "103:1-3", arabic: "وَالْعَصْرِ ۝ إِنَّ الْإِنسَانَ لَفِي خُسْرٍ ۝ إِلَّا الَّذِينَ آمَنُوا وَعَمِلُوا الصَّالِحَاتِ وَتَوَاصَوْا بِالْحَقِّ وَتَوَاصَوْا بِالصَّبْرِ", french: "Par le Temps ! L'homme est certes en perte, sauf ceux qui ont cru, accompli de bonnes œuvres, et recommandé mutuellement la vérité et la patience. »"),
    Ayah(ref: "110:1-3", arabic: "إِذَا جَاءَ نَصْرُ اللَّهِ وَالْفَتْحُ ۝ وَرَأَيْتَ النَّاسَ يَدْخُلُونَ فِي دِينِ اللَّهِ أَفْوَاجًا ۝ فَسَبِّحْ بِحَمْدِ رَبِّكَ وَاسْتَغْفِرْهُ ۚ إِنَّهُ كَانَ تَوَّابًا", french: "Lorsque vient le secours d'Allah ainsi que la victoire, et que tu vois les gens entrer en masse dans la religion d'Allah, alors célèbre les louanges de ton Seigneur et implore Son pardon, car Il est grandement repentant. »"),
    Ayah(ref: "108:1-3", arabic: "إِنَّا أَعْطَيْنَاكَ الْكَوْثَرَ ۝ فَصَلِّ لِرَبِّكَ وَانْحَرْ ۝ إِنَّ شَانِئَكَ هُوَ الْأَبْتَرُ", french: "Nous t'avons certes donné l'Abondance (Al-Kawthar). Accomplis donc la prière pour ton Seigneur et sacrifie. C'est certes ton détracteur qui est sans descendance. »"),
    Ayah(ref: "94:1-3", arabic: "وَالضُّحَىٰ ۝ وَاللَّيْلِ إِذَا سَجَىٰ ۝ مَا وَدَّعَكَ رَبُّكَ وَمَا قَلَىٰ", french: "Par le Jour Montant, et par la nuit quand elle recouvre tout ! Ton Seigneur ne t'a pas abandonné et ne t'a pas pris en aversion. »"),
    Ayah(ref: "94:5-6", arabic: "فَإِنَّ مَعَ الْعُسْرِ يُسْرًا ۝ إِنَّ مَعَ الْعُسْرِ يُسْرًا", french: "Certes, avec la difficulté vient la facilité. Certes, avec la difficulté vient la facilité. »"),
    Ayah(ref: "2:152", arabic: "فَاذْكُرُونِي أَذْكُرْكُمْ وَاشْكُرُوا لِي وَلَا تَكْفُرُونِ", french: "Invoquez-Moi donc, afin que Je vous invoque. Remerciez-Moi et ne Me soyez pas ingrats. »"),
    Ayah(ref: "2:153", arabic: "يَا أَيُّهَا الَّذِينَ آمَنُوا اسْتَعِينُوا بِالصَّبْرِ وَالصَّلَاةِ ۚ إِنَّ اللَّهَ مَعَ الصَّابِرِينَ", french: "Ô vous qui avez cru ! Cherchez secours dans la patience et la prière. Certes, Allah est avec les endurants. »"),
    Ayah(ref: "2:286", arabic: "لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا ۚ …", french: "Allah ne charge aucune âme au-delà de sa capacité. […] »"),
    Ayah(ref: "13:28", arabic: "الَّذِينَ آمَنُوا وَتَطْمَئِنُّ قُلُوبُهُم بِذِكْرِ اللَّهِ ۗ أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ", french: "Ceux qui ont cru et dont les cœurs se tranquillisent à l'évocation d'Allah. Certes, c'est par l'évocation d'Allah que se tranquillisent les cœurs. »"),
    Ayah(ref: "3:139", arabic: "وَلَا تَهِنُوا وَلَا تَحْزَنُوا وَأَنتُمُ الْأَعْلَوْنَ إِن كُنتُم مُّؤْمِنِينَ", french: "Ne faiblissez pas et ne soyez pas tristes, alors que vous serez les plus élevés si vous êtes croyants. »"),
    Ayah(ref: "29:69", arabic: "إِنَّ اللَّهَ مَعَ الَّذِينَ اتَّقَوا وَّالَّذِينَ هُم مُّحْسِنُونَ", french: "Certes, Allah est avec ceux qui Le craignent et avec ceux qui font le bien. »"),
    Ayah(ref: "39:53", arabic: "قُلْ يَا عِبَادِيَ الَّذِينَ أَسْرَفُوا عَلَىٰ أَنفُسِهِمْ لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ ۚ إِنَّ اللَّهَ يَغْفِرُ الذُّنُوبَ جَمِيعًا ۚ إِنَّهُ هُوَ الْغَفُورُ الرَّحِيمُ", french: "Dis : « Ô Mes serviteurs qui avez commis des excès envers vous-mêmes, ne désespérez pas de la miséricorde d'Allah. Certes, Allah pardonne tous les péchés. C'est Lui le Pardonneur, le Miséricordieux. »"),
    Ayah(ref: "49:13", arabic: "يَا أَيُّهَا النَّاسُ إِنَّا خَلَقْنَاكُم مِّن ذَكَرٍ وَأُنثَىٰ وَجَعَلْنَاكُمْ شُعُوبًا وَقَبَائِلَ لِتَعَارَفُوا ۚ إِنَّ أَكْرَمَكُمْ عِندَ اللَّهِ أَتْقَاكُمْ", french: "Ô hommes ! Nous vous avons créés d'un mâle et d'une femelle et vous avons désignés en nations et tribus pour que vous vous connaissiez. Le plus honorable d'entre vous auprès d'Allah est le plus pieux d'entre vous. »"),
    Ayah(ref: "55:13", arabic: "فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ", french: "Lequel donc des bienfaits de votre Seigneur démentirez-vous ? »"),
    Ayah(ref: "67:2", arabic: "الَّذِي خَلَقَ الْمَوْتَ وَالْحَيَاةَ لِيَبْلُوَكُمْ أَيُّكُمْ أَحْسَنُ عَمَلًا ۚ وَهُوَ الْعَزِيزُ الْغَفُورُ", french: "Celui qui a créé la mort et la vie afin de vous éprouver et de voir lequel de vous agit le mieux. C'est Lui le Puissant, le Pardonneur. »"),
]

let REFLECTION_PROMPTS: [String] = [
    "Quel verset t'a marqué aujourd'hui ?",
    "Pour quoi es-tu reconnaissant aujourd'hui ?",
    "Quelle doua as-tu faite ce matin ?",
    "Quelle bonne action veux-tu faire avant la fin de la journée ?",
    "Qui peux-tu appeler ou voir aujourd'hui ?",
    "Qu'as-tu appris aujourd'hui sur toi-même ?",
]

func ayahOfTheDay(for date: Date = Date()) -> Ayah {
    let day = Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 0
    return AYAHS[abs(day) % AYAHS.count]
}

func randomPrompt() -> String {
    REFLECTION_PROMPTS.randomElement() ?? REFLECTION_PROMPTS[0]
}

// MARK: - Calendrier hégirien (approximatif, calendrier islamique civil d'iOS)

let HIJRI_MONTHS_FR = [
    "Muharram", "Safar", "Rabi' al-Awwal", "Rabi' al-Thani",
    "Jumada al-Awwal", "Jumada al-Thani", "Rajab", "Sha'ban",
    "Ramadan", "Shawwal", "Dhu al-Qi'dah", "Dhu al-Hijjah",
]

func hijriDateString(for date: Date = Date()) -> String {
    var calendar = Calendar(identifier: .islamicCivil)
    calendar.locale = Locale(identifier: "fr_FR")
    let c = calendar.dateComponents([.day, .month, .year], from: date)
    let month = HIJRI_MONTHS_FR[max(0, min(11, (c.month ?? 1) - 1))]
    return "\(c.day ?? 0) \(month) \(c.year ?? 0) H"
}

func surah(forNumber number: Int) -> Surah? {
    SURAHS.first { $0.number == number }
}
