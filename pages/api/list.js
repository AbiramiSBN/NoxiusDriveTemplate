import fs from "fs/promises";
import path from "path";

const PUBLIC_ROOT = path.join(process.cwd(), "public");
const ALLOWED_ROOTS = new Set(["documents", "music", "pictures", "videos"]);

function safeJoinPublic(rel) {
  const cleaned = (rel || "").replace(/^\/+/, "");
  const normalized = path.posix.normalize(cleaned);

  if (normalized.includes("..")) throw new Error("Invalid path");

  const first = normalized.split("/")[0];
  if (normalized !== "" && !ALLOWED_ROOTS.has(first)) throw new Error("Path not allowed");

  const fsPath = path.join(PUBLIC_ROOT, ...normalized.split("/").filter(Boolean));
  if (!fsPath.startsWith(PUBLIC_ROOT)) throw new Error("Invalid path");
  return { fsPath, normalized };
}

function guessType(name, isDir) {
  if (isDir) return "folder";
  const ext = name.includes(".") ? name.split(".").pop().toLowerCase() : "";
  return ext || "file";
}

export default async function handler(req, res) {
  try {
    const rel = req.query.path ? String(req.query.path) : "";
    const { fsPath, normalized } = safeJoinPublic(rel);

    if (!normalized) {
      const items = ["documents", "music", "pictures", "videos"].map((x) => ({
        name: x[0].toUpperCase() + x.slice(1),
        kind: "folder",
        type: "folder",
        size: 0,
        mtimeMs: 0,
        relPath: `${x}`,
        url: `/${x}/`
      }));
      return res.status(200).json({ path: "", items });
    }

    const dirents = await fs.readdir(fsPath, { withFileTypes: true });
    const items = [];

    for (const d of dirents) {
      if (d.name === ".DS_Store") continue;

      const isDir = d.isDirectory();
      const itemRel = path.posix.join(normalized, d.name);
      const stat = await fs.stat(path.join(fsPath, d.name));

      items.push({
        name: d.name,
        kind: isDir ? "folder" : "file",
        type: guessType(d.name, isDir),
        size: isDir ? 0 : stat.size,
        mtimeMs: stat.mtimeMs,
        relPath: itemRel,
        url: `/${itemRel}${isDir ? "/" : ""}`
      });
    }

    items.sort((a, b) => {
      if (a.kind !== b.kind) return a.kind === "folder" ? -1 : 1;
      return a.name.localeCompare(b.name);
    });

    res.status(200).json({ path: normalized, items });
  } catch (e) {
    res.status(400).json({ error: String(e.message || e) });
  }
}
