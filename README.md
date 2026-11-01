# ระบบแจ้งปัญหา IT: จุดเริ่มต้นของ Day 5

Repository นี้คือโปรเจกต์ในสถานะ **จบ Day 4** อ่าน เพิ่ม และเปลี่ยนสถานะ Issue ใน Supabase ได้ แต่ยังไม่มีระบบ Login

ใช้ Repository นี้เมื่อ:

- ไม่ได้เรียน Day 4 หรือยังทำไม่จบ
- โปรเจกต์ของตัวเองพังและอยากเริ่ม Day 5 พร้อมเพื่อน

ถ้าโปรเจกต์ของตัวเองทำงานได้ครบแล้ว ไม่ต้องใช้ Repository นี้

## สิ่งที่ต้องมี

- Node.js เวอร์ชัน `20.9` ขึ้นไป (`node -v`)
- Git และบัญชี GitHub
- บัญชี Supabase

## 1. สร้างโปรเจกต์ของตัวเอง

1. กดปุ่ม **Use this template** → **Create a new repository** แล้วตั้งชื่อ Repository ของตัวเอง
2. Clone Repository ใหม่ลงเครื่อง แล้วติดตั้ง Package:

```bash
npm install
```

ต้องเป็น Repository ของตัวเอง เพราะท้าย Day 5 จะ `git push` และ Deploy ขึ้น Vercel

## 2. สร้าง Database บน Supabase

1. เปิด Supabase Dashboard แล้วสร้าง Project ใหม่
   - ตั้ง Database Password ที่เดายาก และตรวจว่าเป็น Plan ฟรี
   - ถ้ามีตัวเลือก ให้เปิด **Enable Data API**, ปิด **Automatically expose new tables and functions** และเปิด **Enable automatic RLS**
2. เปิด **SQL Editor** วางเนื้อหาทั้งไฟล์ `supabase/day-4-setup.sql` แล้วกด **Run** หนึ่งครั้ง
3. ตรวจผล:
   - **Table Editor** มี Table `issues` และข้อมูล 3 แถว
   - หน้า **Policies** ของ `issues` มี Policy ที่ขึ้นต้นด้วย `demo_` 3 รายการ

## 3. ใส่ค่าเชื่อมต่อ Supabase

คัดลอก `.env.example` เป็น `.env.local` ที่โฟลเดอร์หลักของโปรเจกต์:

```bash
cp .env.example .env.local
```

บน Windows ใช้ `copy .env.example .env.local`

เปิด `.env.local` แล้วใส่ค่าจริงจากปุ่ม **Connect** หรือหน้า **Settings → API Keys** ของ Project:

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=sb_publishable_...
```

ห้ามใส่ Secret Key และห้าม Commit `.env.local`

## 4. ตรวจว่าพร้อมเริ่ม Day 5

```bash
npm run dev
```

เปิด `http://localhost:3000` แล้วตรวจ:

1. `/issues` แสดงข้อมูลตัวอย่าง 3 รายการ
2. `/issues/new` แจ้งปัญหาใหม่แล้วรายการขึ้นใน `/issues`
3. ปุ่มสถานะในหน้า `/issues` เปลี่ยนสถานะได้ และ Refresh แล้วค่ายังอยู่

ครบ 3 ข้อแล้วเริ่ม Day 5 ได้เลย ส่วนการ Deploy ขึ้น Vercel ทำตอนท้าย Day 5 พร้อมเพื่อน

## ถ้าไม่ทำงาน

| อาการ | ตรวจที่ |
|---|---|
| ขึ้น `Supabase environment variables are missing` | ชื่อค่าใน `.env.local` และหยุดแล้วรัน `npm run dev` ใหม่ |
| ขึ้น `permission denied` | รัน `supabase/day-4-setup.sql` ครบทั้งไฟล์แล้ว |
| `/issues` ไม่มีข้อมูล | ส่วนข้อมูลตัวอย่างท้ายไฟล์ SQL ถูกรันแล้ว |
