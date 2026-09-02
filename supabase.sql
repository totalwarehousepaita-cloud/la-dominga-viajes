-- LA DOMINGA · Backend para Supabase
-- Ejecuta TODO este archivo en Supabase > SQL Editor > New query.

create table if not exists public.trips (
  token text primary key,
  trip_code text not null,
  state jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists trips_created_at_idx
  on public.trips (created_at desc);

alter table public.trips enable row level security;

drop policy if exists "public can read trips" on public.trips;
drop policy if exists "public can insert trips" on public.trips;
drop policy if exists "public can update trips" on public.trips;
drop policy if exists "public can delete trips" on public.trips;

-- Políticas preparadas para esta versión sin login.
-- El token largo del enlace identifica cada viaje.
create policy "public can read trips"
on public.trips for select
to anon
using (true);

create policy "public can insert trips"
on public.trips for insert
to anon
with check (true);

create policy "public can update trips"
on public.trips for update
to anon
using (true)
with check (true);

create policy "public can delete trips"
on public.trips for delete
to anon
using (true);

-- Evidencias fotográficas
insert into storage.buckets (id, name, public)
values ('evidencias', 'evidencias', true)
on conflict (id) do update set public = true;

drop policy if exists "public can upload evidencias" on storage.objects;
drop policy if exists "public can read evidencias" on storage.objects;

create policy "public can upload evidencias"
on storage.objects for insert
to anon
with check (bucket_id = 'evidencias');

create policy "public can read evidencias"
on storage.objects for select
to anon
using (bucket_id = 'evidencias');

-- Habilita Realtime para la tabla. Si ya está agregada, Supabase puede
-- mostrar un aviso de que la relación ya pertenece a la publicación.
do $$
begin
  begin
    alter publication supabase_realtime add table public.trips;
  exception
    when duplicate_object then null;
  end;
end $$;
