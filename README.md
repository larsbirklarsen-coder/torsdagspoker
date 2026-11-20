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
