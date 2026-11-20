-- Torsdagspoker – aflyste aftener (20. nov. 2026)
-- Køres i Supabase: SQL Editor → indsæt → Run.

alter table public.evenings add column if not exists cancelled boolean not null default false;
alter table public.evenings add column if not exists note text;

-- Uge 27 (2. juli 2026) stod som "Aflyst." i Pokerregnskab 2026.xls
insert into public.evenings (id, date, host, season, players, buy_in, game_count, cancelled, note, source)
values ('2026-07-02', '2026-07-02', null, 2026, '{}', 0, 0, true, 'Aflyst', 'Pokerregnskab 2026.xls')
on conflict (id) do nothing;
