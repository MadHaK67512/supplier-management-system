# 🚀 Deployment Guide — Supplier Management System

**Stack**: Neon.tech (PostgreSQL DB) + Vercel (Node.js API) + Netlify (Frontend)
**All services are FREE — no card required.**

---

## Step 1 — Push Project to GitHub

1. Go to [github.com](https://github.com) → **New Repository** → name it `supplier-management-system` → set **Public**
2. Open PowerShell in the project root and run:

```powershell
cd "c:\Users\HF\OneDrive\Desktop\Uni Work\4 SEMESTER\Web+DB(Project)\Web+DB(Project)"
git init
git add .
git commit -m "Initial commit - Supplier Management System"
git remote add origin https://github.com/YOUR_USERNAME/supplier-management-system.git
git push -u origin main
```

> ⚠️ `node_modules/` and `.env` are excluded automatically by `.gitignore`.

---

## Step 2 — Set Up Database on Neon.tech

1. Go to [neon.tech](https://neon.tech) → **Sign Up** (GitHub login, no card)
2. **New Project** → name it `SupplierManagementDB` → **Create**
3. Click **SQL Editor** → paste the full contents of [`schema.sql`](schema.sql) → **Run**
4. Verify: run `SELECT * FROM brand;` — should return **15 rows** ✅

**Copy your connection string:**
- Dashboard → **Connection Details** → select **"Connection string"** format
- Looks like: `postgresql://user:pass@ep-xxx.us-east-2.aws.neon.tech/neondb?sslmode=require`

---

## Step 3 — Deploy Backend API on Vercel

> **Why Vercel?** Free forever, no card required, auto-deploys on every `git push`.
> The `WebServer/vercel.json` file (already created) tells Vercel how to run the Express app.

1. Go to [vercel.com](https://vercel.com) → **Sign Up** with GitHub (no card needed)
2. Click **Add New Project** → select your `supplier-management-system` repo
3. In the configuration screen:
   - **Framework Preset**: Select `Other`
   - **Root Directory**: Click **Edit** → select `WebServer` → **Continue**
   - **Build and Output Settings**:
     - **Build Command**: Toggle "Override" to **ON** and leave the text box **EMPTY**.
     - **Output Directory**: Leave as default (`N/A`).
     - **Install Command**: Leave "Override" to **OFF** (it will default to `npm install`).
4. Open **Environment Variables** section → Add:
   - **Name**: `DATABASE_URL`
   - **Value**: *(paste your Neon connection string)*
   - Click **Add**
5. Click **Deploy** — wait ~1 minute ✅

**Copy your API URL** — looks like: `https://supplier-management-system-api.vercel.app`

**Test it:** Open `https://your-api-url.vercel.app/brands` in a browser → should return JSON ✅

---

## Step 4 — Update Frontend API URL

Open [`config.js`](config.js) and change **one line**:

```js
// BEFORE (local dev):
const API_BASE = 'http://localhost:4000';

// AFTER (paste YOUR Vercel API URL):
const API_BASE = 'https://your-api-url.vercel.app';
```

Commit and push:
```powershell
git add config.js
git commit -m "Update API_BASE to Vercel production URL"
git push
```

---

## Step 5 — Deploy Frontend on Netlify

1. Go to [netlify.com](https://netlify.com) → **Sign Up** with GitHub (no card needed)
2. **Add new site** → **Import an existing project** → **GitHub**
3. Select your `supplier-management-system` repo
4. Settings:
   - **Branch**: `main`
   - **Base directory**: *(leave empty)*
   - **Build command**: *(leave empty)*
   - **Publish directory**: *(leave empty)*
5. Click **Deploy site** — done in ~30 seconds ✅

**Your live URL**: `https://your-site-name.netlify.app`

---

## ✅ Verification Checklist

- [ ] Open Netlify URL → Login page loads
- [ ] Click "Log in" → Dashboard appears
- [ ] Click "Brands" → 15 brands load from DB
- [ ] Click "Add" on a brand → appears in Associated Brands
- [ ] Click "Customers" → list loads, Add/Remove work
- [ ] Click "Purchase" → dropdowns populate from DB

---

## 🔁 Future Updates

```powershell
git add .
git commit -m "describe your change"
git push
```
Both Vercel and Netlify **auto-redeploy** on every push. No manual steps needed.

---

## 💡 Notes

| Topic | Detail |
|---|---|
| **Cold starts** | Vercel serverless functions may take 1–2s on first request after inactivity — normal |
| **DB persistence** | Neon free tier keeps data permanently |
| **Login** | The login page is a UI demo (no real auth) — mention this in your portfolio |
| **CORS** | Already configured in `app.js` — no issues expected |
