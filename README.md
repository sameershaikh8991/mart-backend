# D-Mart Backend (Neon Postgres)

## 1. Neon database
- Sign up at neon.tech (free tier is enough)
- Create a project → copy the connection string (looks like `postgres://user:pass@ep-xxxx.neon.tech/dbname?sslmode=require`)
- Open the Neon SQL editor → paste and run everything in `schema.sql`

## 2. Run locally (to test)
```bash
npm install
cp .env.example .env   # then paste your real DATABASE_URL inside .env
npm start
```
Server runs at `http://localhost:3001`.

## 3. Deploy (so your phone can reach it)
Easiest free option: **Vercel** or **Render**.
- Push this folder to a GitHub repo
- Import it in Vercel/Render
- Add an environment variable `DATABASE_URL` with your Neon connection string
- Deploy → you'll get a URL like `https://dmart-backend.vercel.app`

## 4. Connect the frontend
In the React app (`dmart-app-v2.jsx`), replace the `window.storage.get/set` calls with `fetch` calls to your deployed URL, e.g.:

```js
const API = "https://dmart-backend.vercel.app";

// login
await fetch(`${API}/api/login`, { method: "POST", headers: {"Content-Type":"application/json"}, body: JSON.stringify({ name, mobile }) });

// get items
const items = await fetch(`${API}/api/items/${mobile}`).then(r => r.json());

// add item
await fetch(`${API}/api/items/${mobile}`, { method: "POST", headers: {"Content-Type":"application/json"}, body: JSON.stringify({ name, category, qty, unit }) });

// update item (qty/price/checked)
await fetch(`${API}/api/items/${mobile}/${id}`, { method: "PATCH", headers: {"Content-Type":"application/json"}, body: JSON.stringify({ checked: true }) });

// delete item
await fetch(`${API}/api/items/${mobile}/${id}`, { method: "DELETE" });
```

Once this is wired in, your list truly lives in Postgres — accessible from any device, any browser, as long as you log in with the same mobile number.
