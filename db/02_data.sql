-- Torsdagspoker – data fra Pokerregnskab 2026.xls (22 aftener, uge 1–45)
-- Køres efter 01_schema.sql.

insert into public.players (id, name, active, guest) values
  ('allan', 'Allan', true, false),
  ('mikael', 'Mikael', true, false),
  ('stein', 'Stein', true, false),
  ('ole', 'Ole', true, false),
  ('mikkel', 'Mikkel', true, false),
  ('lars', 'Lars', true, false)
on conflict (id) do nothing;

insert into public.evenings (id, date, host, season, players, buy_in, game_count, results, source) values
  ('2026-01-01', '2026-01-01', 'ole', 2026, array['allan','mikael','stein','ole','lars'], 150, 2, '{"allan":0,"mikael":150,"stein":0,"ole":150,"lars":-300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-01-15', '2026-01-15', 'mikael', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":300,"mikael":-300,"stein":150,"ole":-150,"mikkel":-300,"lars":300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-01-29', '2026-01-29', 'allan', 2026, array['allan','mikael','ole','mikkel','lars'], 150, 2, '{"allan":0,"mikael":-300,"ole":0,"mikkel":150,"lars":150}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-02-12', '2026-02-12', 'stein', 2026, array['mikael','stein','ole','mikkel','lars'], 150, 2, '{"mikael":0,"stein":-300,"ole":150,"mikkel":450,"lars":-300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-02-26', '2026-02-26', 'ole', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":0,"mikael":150,"stein":600,"ole":-300,"mikkel":-300,"lars":-150}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-03-12', '2026-03-12', 'allan', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":150,"mikael":150,"stein":-300,"ole":150,"mikkel":-300,"lars":150}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-03-26', '2026-03-26', 'mikkel', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":-150,"mikael":150,"stein":-300,"ole":300,"mikkel":-150,"lars":150}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-04-09', '2026-04-09', 'stein', 2026, array['allan','mikael','stein','ole','lars'], 150, 2, '{"allan":150,"mikael":300,"stein":-300,"ole":150,"lars":-300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-04-23', '2026-04-23', 'mikkel', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":-150,"mikael":150,"stein":300,"ole":-150,"mikkel":150,"lars":-300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-05-07', '2026-05-07', 'allan', 2026, array['allan','mikael','ole','mikkel','lars'], 150, 2, '{"allan":150,"mikael":150,"ole":-300,"mikkel":-300,"lars":300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-05-21', '2026-05-21', 'allan', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":150,"mikael":150,"stein":-300,"ole":150,"mikkel":-150,"lars":0}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-06-04', '2026-06-04', 'lars', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":150,"mikael":150,"stein":0,"ole":-300,"mikkel":300,"lars":-300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-06-18', '2026-06-18', 'ole', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":150,"mikael":0,"stein":150,"ole":-300,"mikkel":0,"lars":0}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-07-16', '2026-07-16', 'lars', 2026, array['allan','mikael','ole','mikkel','lars'], 150, 2, '{"allan":450,"mikael":0,"ole":-300,"mikkel":-300,"lars":150}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-07-30', '2026-07-30', 'ole', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":0,"mikael":-300,"stein":450,"ole":-300,"mikkel":450,"lars":-300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-08-13', '2026-08-13', 'lars', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":150,"mikael":-150,"stein":0,"ole":150,"mikkel":150,"lars":-300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-08-27', '2026-08-27', 'mikkel', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":300,"mikael":600,"stein":-300,"ole":-300,"mikkel":-150,"lars":-150}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-09-10', '2026-09-10', 'allan', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":-300,"mikael":150,"stein":0,"ole":150,"mikkel":0,"lars":0}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-09-24', '2026-09-24', 'stein', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":-300,"mikael":-150,"stein":600,"ole":300,"mikkel":-300,"lars":-150}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-10-08', '2026-10-08', 'mikkel', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":300,"mikael":150,"stein":0,"ole":-150,"mikkel":0,"lars":-300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-10-24', '2026-10-24', 'stein', 2026, array['allan','mikael','stein','ole','mikkel','lars'], 150, 2, '{"allan":0,"mikael":-300,"stein":-300,"ole":450,"mikkel":-150,"lars":300}'::jsonb, 'Pokerregnskab 2026.xls'),
  ('2026-11-05', '2026-11-05', 'lars', 2026, array['allan','stein','ole','mikkel','lars'], 150, 2, '{"allan":0,"stein":-300,"ole":-300,"mikkel":150,"lars":450}'::jsonb, 'Pokerregnskab 2026.xls')
on conflict (id) do nothing;
