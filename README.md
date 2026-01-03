# NoxiustDrive

![NoxiustDrive Banner](public/pictures/wallpaper/banner.png)

NoxiustDrive is a **fullscreen, Windows File Explorer–style web UI** for navigating server folders on **Vercel (Next.js)**.
It includes real folder browsing via an API, clickable breadcrumbs, search, details/preview pane, and a frosted-glass (“mica”) look.

## Features
- Fullscreen Windows Explorer–inspired UI
- Frosted glass / mica effect over a wallpaper background
- Real directory browsing inside the UI (no fake files)
- Clickable breadcrumbs + “Up” button
- Search filter for current folder
- Details pane + image preview
- Double-click to open folders/files
- Right-click menu (Open)
- Optional real protection with Basic Auth via Edge Middleware

## Folder layout (served from /public)
Put your content in:
- `public/documents/`
- `public/music/`
- `public/pictures/`
- `public/videos/`

Wallpapers:
- Lock screen: `public/pictures/wallpapers/wallpaper.jpeg`
- Browser background: `public/pictures/wallpapers/wallpaper2.jpeg`

Banner:
- `public/pictures/wallpaper/banner.png`

## Run locally
```bash
npm i
npm run dev
```
Open: `http://localhost:3000/app.html`

## Deploy to Vercel (with real auth)
1) Compute password SHA-256:
```bash
node -e "const crypto=require('crypto'); console.log(crypto.createHash('sha256').update('YOUR_PASSWORD').digest('hex'))"
```

2) In Vercel → Project → Settings → Environment Variables:
- `NOXI_USER` = your username
- `NOXI_PASS_SHA256` = the sha256 hex from above
