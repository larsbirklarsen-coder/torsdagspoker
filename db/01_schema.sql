-- Torsdagspoker – tabeller og adgangsregler
-- Køres én gang i Supabase: SQL Editor → New query → indsæt → Run.
-- Alle (også uden login) må LÆSE. Kun mailadresser i public.admins må SKRIVE.

create table if not exists public.players (
  id          text primary key,
  name        text not null,
  active      boolean not null default true,
  guest       boolean not null default false,
  created_at  timestamptz not null default now()
);

create table if not exists public.evenings (
  id          text primary key,
  date        date not null,
  host        text,
  season      int  not null,
  players     text[] not null,
  buy_in      int  not null,
  game_count  int  not null,
  prizes      int[],          -- præmier pr. placering (aftener tastet i appen)
  games       jsonb,          -- [[1.plads, 2.plads, ...], ...] pr. spil
  results     jsonb,          -- netto pr. spiller (aftener fra regnearket)
  source      text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create table if not exists public.config (
  id    text primary key,
  data  jsonb not null
);

create table if not exists public.admins (
  email text primary key
);

alter table public.players  enable row level security;
alter table public.evenings enable row level security;
alter table public.config   enable row level security;
alter table public.admins   enable row level security;   -- ingen politikker = ingen adgang udefra

create or replace function public.is_admin()
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.admins
    where lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
  );
$$;
revoke all on function public.is_admin() from public;
grant execute on function public.is_admin() to anon, authenticated;

-- Læseadgang for alle
create policy "alle læser spillere" on public.players  for select to anon, authenticated using (true);
create policy "alle læser aftener"  on public.evenings for select to anon, authenticated using (true);
create policy "alle læser regler"   on public.config   for select to anon, authenticated using (true);

-- Skriveadgang kun for administratorer
create policy "admin skriver spillere" on public.players  for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admin skriver aftener"  on public.evenings for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admin skriver regler"   on public.config   for all to authenticated using (public.is_admin()) with check (public.is_admin());

grant select on public.players, public.evenings, public.config to anon, authenticated;
grant insert, update, delete on public.players, public.evenings, public.config to authenticated;

-- Spilleregler
insert into public.config (id, data) values
  ('main', '{"buyIn":150,"games":2,"minPlayers":5,"maxPlayers":6,"prizes":{"5":[450,300],"6":[450,300,150]}}')
on conflict (id) do nothing;

-- Administratorer kan se, tilføje og fjerne andre administratorer fra appen.
create policy "admin ser admins"      on public.admins for select to authenticated using (public.is_admin());
create policy "admin tilføjer admins" on public.admins for insert to authenticated with check (public.is_admin());
create policy "admin fjerner admins"  on public.admins for delete to authenticated using (public.is_admin());
grant select, insert, delete on public.admins to authenticated;
