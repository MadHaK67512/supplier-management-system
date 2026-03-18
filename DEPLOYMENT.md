# 🚀 Deployment Guide — Supplier Management System

**Stack**: Neon.tech (PostgreSQL) + Render.com (Node.js API) + Netlify (Frontend)
**All services are FREE** for portfolio projects.

---

## Step 1 — Push Project to GitHub

1. Go to [github.com](https://github.com) → **New Repository** → name it e.g. `supplier-management-system`
2. Make it **Public** (required for free Netlify/Render deploys)
3. Open PowerShell in your project root and run:

```powershell
cd "c:\Users\HF\OneDrive\Desktop\Uni Work\4 SEMESTER\Web+DB(Project)\Web+DB(Project)"
git init
git add .
git commit -m "Initial commit - Supplier Management System"
git remote add origin https://github.com/YOUR_USERNAME/supplier-management-system.git
git push -u origin main
```

> ⚠️ Make sure `node_modules` and `.env` are NOT pushed — the `.gitignore` files handle this.

---

## Step 2 — Set Up Database on Neon.tech

1. Go to [neon.tech](https://neon.tech) → **Sign Up** (free, use GitHub login)
2. Click **New Project** → name it `SupplierManagementDB` → Region: closest to you → **Create**
3. In your Neon dashboard, click **SQL Editor**
4. Copy the **entire contents** of [`schema.sql`](schema.sql) and paste into the SQL Editor
5. Click **Run** — you should see no errors
6. Verify by running: `SELECT * FROM brand;` — should return 15 rows ✅

**Copy your connection string:**
- Go to **Dashboard → Connection Details**
- Select **Connection string** format
- Copy the string — it looks like:
  ```
  postgresql://username:password@ep-xxx.us-east-2.aws.neon.tech/neondb?sslmode=require
  ```

---

## Step 3 — Deploy Backend on Render.com

1. Go to [render.com](https://render.com) → **Sign Up** (use GitHub login)
2. Click **New** → **Web Service**
3. Connect your GitHub repo → select `supplier-management-system`
4. Configure the service:
   - **Name**: `supplier-management-api`
   - **Root Directory**: `WebServer`
   - **Runtime**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
5. Scroll to **Environment Variables** → click **Add Environment Variable**:
   - Key: `DATABASE_URL`
   - Value: *(paste your Neon connection string from Step 2)*
6. Click **Create Web Service** — wait ~3 minutes for deploy

**Copy your Render URL** — it looks like: `https://supplier-management-api.onrender.com`

**Test it:** Open `https://supplier-management-api.onrender.com/brands` in your browser — you should see JSON data ✅

---

## Step 4 — Update Frontend API URL

Open [`config.js`](config.js) in your project root and change **one line**:

```js
// BEFORE (local):
const API_BASE = 'http://localhost:4000';

// AFTER (production) — paste YOUR Render URL:
const API_BASE = 'https://supplier-management-api.onrender.com';
```

Commit and push the change:
```powershell
git add config.js
git commit -m "Update API_BASE to production URL"
git push
```

---

## Step 5 — Deploy Frontend on Netlify

1. Go to [netlify.com](https://netlify.com) → **Sign Up** (use GitHub login)
2. Click **Add new site** → **Import an existing project** → **GitHub**
3. Select your `supplier-management-system` repo
4. Configure:
   - **Branch**: `main`
   - **Base directory**: *(leave empty — the HTML files are in the root)*
   - **Build command**: *(leave empty — no build needed)*
   - **Publish directory**: `.` (or leave empty)
5. Click **Deploy site** — takes ~30 seconds

**Your live URL** will look like: `https://your-site-name.netlify.app`

---

## ✅ Verification Checklist

After deployment:
- [ ] Open Netlify URL → login page loads
- [ ] Click "Log in" → dashboard appears
- [ ] Click "Brands" → table loads with 15 Pakistani brands from DB
- [ ] Click "Add" on a brand → success alert + brand appears in Associated Brands
- [ ] Click "Customers" → 15 customers shown, Add/Remove work
- [ ] Click "Purchase" → table loads, dropdowns populate from DB

---

## 🔁 Future Updates Workflow

Whenever you make code changes:
```powershell
git add .
git commit -m "Your change description"
git push
```
Render and Netlify **auto-deploy** when you push to GitHub. No manual steps needed.

---

## 💡 Important Notes

| | Note |
|---|---|
| **Free tier sleep** | Render's free tier sleeps after 15 min inactivity. First request after sleep takes ~30s. Upgrade to $7/mo to avoid this. |
| **DB persistence** | Neon free tier persists data. Your seed data (brands, suppliers, etc.) stays permanently. |
| **Login** | The login page is a UI demo — no real authentication. Mention this in your portfolio description. |
| **CORS** | Already configured in `app.js` — no CORS issues expected. |
