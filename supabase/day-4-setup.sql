-- ตั้งค่า Database ให้เหมือนตอนจบ Day 4
-- รันครั้งเดียวใน Supabase Project ใหม่: SQL Editor → วางทั้งไฟล์ → Run
-- ถ้ามี Table issues อยู่แล้ว ไม่ต้องรันไฟล์นี้

-- 1. ชนิดข้อมูลของสถานะ
create type public.issue_status
as enum ('OPEN', 'IN_PROGRESS', 'DONE');

-- 2. Table issues
create table public.issues (
  id uuid primary key default gen_random_uuid(),
  reporter_name text not null,
  reporter_email text not null,
  title text not null check (char_length(title) >= 5),
  description text not null check (char_length(description) >= 10),
  status public.issue_status not null default 'OPEN',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 3. เปิด RLS และให้สิทธิ์อ่าน เพิ่ม และแก้
alter table public.issues enable row level security;

revoke all on public.issues from anon, authenticated;
grant select, insert, update
  on public.issues
  to anon, authenticated;

-- 4. Policy ทดลองที่ให้ทุกคนอ่าน เพิ่ม และแก้ได้ (Day 5 จะลบออก)
create policy "demo_select_issues"
  on public.issues
  for select
  to anon, authenticated
  using (true);

create policy "demo_insert_issues"
  on public.issues
  for insert
  to anon, authenticated
  with check (true);

create policy "demo_update_issues"
  on public.issues
  for update
  to anon, authenticated
  using (true)
  with check (true);

-- 5. ข้อมูลตัวอย่าง 3 แถว
insert into public.issues
  (reporter_name, reporter_email, title, description, status)
values
  ('Anan', 'anan@example.com', 'Login เข้าระบบไม่ได้',
    'ไม่สามารถเข้าสู่ระบบด้วยบัญชีเดิมได้', 'OPEN'),
  ('Mali', 'mali@example.com', 'ส่งแบบฟอร์มสมัครไม่ได้',
    'กดส่งข้อมูลแล้วระบบขึ้น error', 'IN_PROGRESS'),
  ('Kanda', 'kanda@example.com', 'ขอสิทธิ์เข้าใช้งาน dashboard',
    'ต้องการสิทธิ์สำหรับตรวจสอบข้อมูลหลังบ้าน', 'DONE');
