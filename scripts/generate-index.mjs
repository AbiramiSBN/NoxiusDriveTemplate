// scripts/generate-index.mjs
// Generates public/_index.json by scanning public/{documents,music,pictures,videos}
// Works on local + Vercel build. No serverless needed.

import fs from "node:fs/promises";
import path from "node:path";

const ROOT = process.cwd();
const PUBLIC_DIR = path.join(ROOT, "public");
const OUT_FILE = path.join(PUBLIC_DIR, "_index.json");

// Folders your app shows at "This PC"
const TOPS = ["documents", "music", "pictures", "videos"];

// Ignore junk files (add more if you want)
const IGNORE_NAMES = new Set([
  ".DS_Store",
  "Thumbs.db",
  ".gitkeep"
]);

function toRelPath(absPath) {
  // Convert absolute path to "public-relative" path (no leading slash)
  const rel = path.relative(PUBLIC_DIR, absPath).replaceAll(path.sep, "/");
  return rel;
}

function toUrl(relPath, isFolder) {
  return "/" + relPath + (isFolder ? "/" : "");
}

async function safeStat(p) {
  try {
    return await fs.stat(p);
  } catch {
    return null;
  }
}

async function readDirSafe(dir) {
  try {
    return await fs.readdir(dir, { withFileTypes: true });
  } catch {
    return [];
  }
}

async function walkFolder(absFolderPath) {
  const entries = await readDirSafe(absFolderPath);

  // Sort: folders first, then files, alphabetical
  entries.sort((a, b) => {
    if (a.isDirectory() !== b.isDirectory()) return a.isDirectory() ? -1 : 1;
    return a.name.localeCompare(b.name);
  });

  const children = [];

  for (const ent of entries) {
    if (IGNORE_NAMES.has(ent.name)) continue;

    const absChild = path.join(absFolderPath, ent.name);
    const relChild = toRelPath(absChild);

    if (ent.isDirectory()) {
      const st = await safeStat(absChild);
      const node = {
        kind: "folder",
        name: ent.name,
        relPath: relChild,
        url: toUrl(relChild, true),
        mtimeMs: st ? st.mtimeMs : Date.now(),
        children: await walkFolder(absChild)
      };
      children.push(node);
    } else if (ent.isFile()) {
      const st = await safeStat(absChild);
      const node = {
        kind: "file",
        name: ent.name,
        relPath: relChild,
        url: toUrl(relChild, false),
        size: st ? st.size : 0,
        mtimeMs: st ? st.mtimeMs : Date.now()
      };
      children.push(node);
    }
  }

  return children;
}

async function main() {
  const tree = {};
  const now = Date.now();

  for (const top of TOPS) {
    const absTop = path.join(PUBLIC_DIR, top);
    const st = await safeStat(absTop);

    if (!st || !st.isDirectory()) {
      tree[top] = [];
      continue;
    }

    tree[top] = await walkFolder(absTop);
  }

  const out = {
    generatedAt: now,
    tree
  };

  await fs.mkdir(PUBLIC_DIR, { recursive: true });
  await fs.writeFile(OUT_FILE, JSON.stringify(out, null, 2), "utf8");

  console.log(`✅ Wrote ${path.relative(ROOT, OUT_FILE)} (generatedAt=${now})`);
}

main().catch((e) => {
  console.error("❌ Failed to generate _index.json:", e);
  process.exit(1);
});
