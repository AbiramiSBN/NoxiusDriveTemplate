import { NextResponse } from "next/server";

async function sha256Hex(str) {
  const data = new TextEncoder().encode(str);
  const digest = await crypto.subtle.digest("SHA-256", data);
  return Array.from(new Uint8Array(digest)).map(b => b.toString(16).padStart(2, "0")).join("");
}

export const config = {
  matcher: [
    "/app.html",
    "/api/:path*",
    "/documents/:path*",
    "/music/:path*",
    "/pictures/:path*",
    "/videos/:path*",
    "/"
  ]
};

export default async function middleware(req) {
  const USER = process.env.NOXI_USER || "";
  const PASS_SHA = (process.env.NOXI_PASS_SHA256 || "").toLowerCase();

  if (!USER || !PASS_SHA) return NextResponse.next();

  const auth = req.headers.get("authorization") || "";
  if (!auth.startsWith("Basic ")) {
    return new NextResponse("Auth required", {
      status: 401,
      headers: { "WWW-Authenticate": 'Basic realm="NoxiustDrive"' }
    });
  }

  const b64 = auth.slice("Basic ".length);
  let decoded = "";
  try { decoded = atob(b64); } catch { decoded = ""; }

  const idx = decoded.indexOf(":");
  const u = idx >= 0 ? decoded.slice(0, idx) : "";
  const p = idx >= 0 ? decoded.slice(idx + 1) : "";

  const pHash = await sha256Hex(p);
  if (u === USER && pHash === PASS_SHA) return NextResponse.next();

  return new NextResponse("Unauthorized", {
    status: 401,
    headers: { "WWW-Authenticate": 'Basic realm="NoxiustDrive"' }
  });
}
