# Torsdagspoker

Turneringsapp til torsdagspoker: aftener, udbetaling og order of merit.
Alle kan se resultaterne uden login. Kun administratorer (tabellen `admins`) kan taste.

- **Side:** `index.html` (én fil, ingen build). Udgives med GitHub Pages.
- **Data og login:** Supabase-projektet `torsdagspoker` (Central EU, Frankfurt). Login sker med et link på mail.
- **Holde databasen vågen:** `.github/workflows/keepalive.yml` kalder databasen mandag og torsdag.
  Gratis Supabase pauser efter 7 dage uden aktivitet. Er den pauset alligevel, kan den startes igen med ét klik i Supabase.

## Opsætning (én gang)
1. Supabase → SQL Editor: kør `db/01_schema.sql` (ret de to admin-mails først) og derefter `db/02_data.sql`.
2. Supabase → Authentication → URL Configuration: Site URL = adressen på GitHub Pages-siden.
3. Indsæt publishable-nøglen i `SB_KEY` i `index.html`.

## Ny administrator
Supabase → Table Editor → `admins` → Insert row → mailadressen.

## Regler i appen
- Indskud pr. spil, spil pr. aften, mindste/største antal spillere og præmier pr. antal spillere kan ændres under "Regler og spillere".
- En gemt aften beholder de præmier, den blev spillet med.
- Order of merit = sum af (gevinst − indskud) pr. sæson. Gæster vises, men får ingen placering.
- Aftenerne fra `Pokerregnskab 2026.xls` (uge 1–45) har kun netto pr. spiller og kan slettes, men ikke rettes.

## Ny version
Hæv `APP_VERSION` i `index.html` og indholdet af `version.txt` til samme værdi. Så henter telefonerne den nye side, næste gang appen åbnes.

## Aflyste aftener, statistik og backup (20. nov. 2026)
- `db/03_aflyste.sql` tilføjer `cancelled` og `note` på `evenings` og lægger uge 27 (2. juli) ind som aflyst.
- Fra 2027 skal alle placeringer tastes; i 2026 kun præmiepladserne.
- En påbegyndt aften gemmes i telefonen (`localStorage` "tp-draft") og hentes frem efter genindlæsning. Appen opdaterer sig ikke selv, mens der ligger en kladde.
- Backup: .csv til Google Sheets og fuld .json fra "Regler og spillere". Automatisk natlig backup: `backup/google-sheets-backup.gs` (Apps Script i et Google-regneark, kør `installer`).

## Gamle sæsoner 2008-09 til 2025 (26. nov. 2026)
- Mikaels regneark ligger i `regnskaber/` (kun lokalt, står i `.gitignore`). `regnskaber/04_historik.sql` lægger 437 aftener ind (23 aflyste) og opretter Peter, Thomas, Røde og Casper som inaktive samt "Gæster" (alle gæster samlet, kun netto).
- Kontrol: alle aftener går i nul, og hver sæson stemmer med "Pokerregnskab total gevinster-tab.xls".
- Sæsonen gemmes som startåret: 2008 = 2008-09, 2009 = 2009-10, 2010 = 2010-11, 2011 = 2011-12 lang sæson (navnene står i `SEASON_NAMES`).
- Indskud: 3 spil à 100 kr. til og med 2010-11, derefter 2 spil à 150 kr.
- "Ulrik" i 2008-09 er Røde. Rettede datoer: 2013 uge 10 = 6/3-2013 og 2021 uge 49 = 9/12-2021.
- Order of Merit → "Alle år": samlet stilling og antal 1.-, 2.- og 3.-pladser i afsluttede sæsoner. Står to lige, går den med flest aftener foran.

## Statistik (26. nov. 2026)
- "Plus i træk" og "Minus i træk": flest aftener i træk med gevinst eller tab. En aften med 0 kr. bryder rækken, og aftener man ikke var med, springes over. Tryk på tallet for at se datoerne.
- Hver spiller har en fast farve (`FIXED_COLOR`). Gæster er grå.
- "Alle sæsoner": grafen viser stillingen efter hver sæson, og tidligere spillere og gæster er skjult, til man trykker på knappen.
- Placeringer i de enkelte spil vises kun for én sæson fra 2027.
