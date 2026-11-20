/**
 * Torsdagspoker – automatisk backup til Google Sheets
 *
 * Sådan sættes det op (én gang):
 *  1. Opret et tomt Google-regneark, fx "Torsdagspoker backup".
 *  2. Udvidelser → Apps Script. Slet det, der står, og sæt hele denne fil ind. Tryk Gem.
 *  3. Vælg funktionen "installer" i rullemenuen øverst og tryk Kør. Godkend med din Gmail.
 *     Det laver en backup med det samme og igen hver nat ca. kl. 4.
 *
 * Nøglen herunder er den offentlige læsenøgle, som også står i appen. Den kan kun læse.
 */
const SB_URL = "https://wmmdgdpdejqazrginqgp.supabase.co/rest/v1/";
const SB_KEY = "sb_publishable_IxWJBCmySse3nCVfv2Oyrw_IRtgn_tR";

function installer() {
  ScriptApp.getProjectTriggers().forEach(t => ScriptApp.deleteTrigger(t));
  ScriptApp.newTrigger("backup").timeBased().everyDays(1).atHour(4).create();
  backup();
}

function backup() {
  const get = path => JSON.parse(UrlFetchApp.fetch(SB_URL + path, { headers: { apikey: SB_KEY } }).getContentText());
  const players = get("players?select=*&order=name");
  const evenings = get("evenings?select=*&order=date");
  const config = get("config?select=data&id=eq.main");
  const name = id => (players.find(p => p.id === id) || {}).name || id || "";
  const guest = id => (players.find(p => p.id === id) || {}).guest ? "ja" : "";

  // Én række pr. spiller pr. spil (samme format som .csv-filen fra appen)
  const rows = [];
  evenings.forEach(ev => {
    const base = [ev.date, ev.season, ev.cancelled ? "Aflyst" : "Spillet", name(ev.host)];
    if (ev.cancelled) { rows.push(base.concat(["", "", "", "", "", "", "", ev.note || ""])); return; }
    if (ev.games && ev.games.length) {
      ev.games.forEach((g, gi) => ev.players.forEach(p => {
        const i = g.indexOf(p), w = i >= 0 ? ((ev.prizes || [])[i] || 0) : 0;
        rows.push(base.concat([name(p), guest(p), gi + 1, i >= 0 ? i + 1 : "", ev.buy_in, w, w - ev.buy_in, ev.note || ""]));
      }));
    } else if (ev.results) {
      const paid = ev.buy_in * ev.game_count;
      Object.keys(ev.results).forEach(p => {
        const n = ev.results[p];
        rows.push(base.concat([name(p), guest(p), "alle", "", paid, n + paid, n, (ev.note || "") + " (kun netto)"]));
      });
    }
  });

  const ss = SpreadsheetApp.getActiveSpreadsheet();
  write(ss, "Rækker", ["Dato", "Sæson", "Status", "Vært", "Spiller", "Gæst", "Spil", "Placering", "Indskud (kr)", "Gevinst (kr)", "Netto (kr)", "Note"], rows);
  write(ss, "Spillere", ["id", "Navn", "Aktiv", "Gæst"], players.map(p => [p.id, p.name, p.active, p.guest]));
  write(ss, "Aftener (rå)", ["id", "Dato", "Aflyst", "Vært", "Spillere", "Indskud pr. spil", "Antal spil", "Præmier", "Placeringer", "Netto", "Note"],
    evenings.map(e => [e.id, e.date, !!e.cancelled, e.host || "", (e.players || []).join(", "), e.buy_in, e.game_count,
      JSON.stringify(e.prizes || []), JSON.stringify(e.games || []), JSON.stringify(e.results || {}), e.note || ""]));
  write(ss, "Info", ["Sidst opdateret", "Aftener", "Spillere", "Regler"],
    [[new Date(), evenings.length, players.length, JSON.stringify((config[0] || {}).data || {})]]);
}

function write(ss, title, head, rows) {
  const sh = ss.getSheetByName(title) || ss.insertSheet(title);
  sh.clearContents();
  sh.getRange(1, 1, 1, head.length).setValues([head]).setFontWeight("bold");
  if (rows.length) sh.getRange(2, 1, rows.length, head.length).setValues(rows);
  sh.setFrozenRows(1);
}
