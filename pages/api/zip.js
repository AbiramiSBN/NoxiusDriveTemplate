// pages/api/zip.js
import fs from "fs";
import path from "path";
import archiver from "archiver";

export const config = {
  api: {
    bodyParser: false,
    responseLimit: false,
  },
};

function safeRelPath(input) {
  const raw = String(input || "").replace(/^\/+/, "");
  const normalized = path.posix.normalize(raw);

  // block traversal / weird input
  if (!normalized || normalized === "." || normalized.startsWith("..") || normalized.includes("\0")) {
    return null;
  }

  // only allow top-level roots you use
  const top = normalized.split("/")[0];
  const allowed = new Set(["documents", "music", "pictures", "videos"]);
  if (!allowed.has(top)) return null;

  return normalized;
}

export default async function handler(req, res) {
  try {
    const rel = safeRelPath(req.query.path);
    if (!rel) return res.status(400).send("Invalid path");

    const folderAbs = path.join(process.cwd(), "public", rel);

    const st = await fs.promises.stat(folderAbs).catch(() => null);
    if (!st || !st.isDirectory()) return res.status(404).send("Folder not found");

    const folderName = path.basename(rel.replace(/\/+$/, "")) || "folder";
    res.setHeader("Content-Type", "application/zip");
    res.setHeader("Content-Disposition", `attachment; filename="${folderName}.zip"`);

    const archive = archiver("zip", { zlib: { level: 9 } });

    archive.on("warning", (err) => console.warn("zip warning:", err));
    archive.on("error", (err) => {
      console.error("zip error:", err);
      try {
        if (!res.headersSent) res.status(500).send("Zip error");
        else res.end();
      } catch {}
    });

    archive.pipe(res);

    // zip folder content into ZIP root
    archive.directory(folderAbs, false);

    await archive.finalize();
  } catch (e) {
    console.error(e);
    res.status(500).send("Server error");
  }
}
