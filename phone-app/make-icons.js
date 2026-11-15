#!/usr/bin/env node
/*
 * Quran Planner 2027 — app icon generator (zero dependencies).
 *
 * Renders the planner's crescent + star emblem (beige palette) into
 * icon-192.png, icon-512.png and icon-maskable-512.png using a small
 * hand-rolled PNG encoder (Node's built-in zlib only). Run by the
 * GitHub Pages workflow before deployment, but works anywhere:
 *
 *     node phone-app/make-icons.js
 */
"use strict";

const zlib = require("zlib");
const fs = require("fs");
const path = require("path");

/* Beige palette (matches the planner) */
const BRUN = [95, 74, 54];    /* #5f4a36 background */
const CREAM = [253, 250, 244]; /* #fdfaf4 emblem */

/* ---------- PNG encoder ---------- */
const crcTable = (() => {
  const t = new Array(256);
  for (let n = 0; n < 256; n++) {
    let c = n;
    for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
    t[n] = c >>> 0;
  }
  return t;
})();
function crc32(buf) {
  let c = 0xffffffff;
  for (let i = 0; i < buf.length; i++) c = crcTable[(c ^ buf[i]) & 0xff] ^ (c >>> 8);
  return (c ^ 0xffffffff) >>> 0;
}
function chunk(type, data) {
  const len = Buffer.alloc(4);
  len.writeUInt32BE(data.length, 0);
  const body = Buffer.concat([Buffer.from(type, "ascii"), data]);
  const crc = Buffer.alloc(4);
  crc.writeUInt32BE(crc32(body), 0);
  return Buffer.concat([len, body, crc]);
}
function encodePNG(w, h, rgba) {
  const sig = Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]);
  const ihdr = Buffer.alloc(13);
  ihdr.writeUInt32BE(w, 0);
  ihdr.writeUInt32BE(h, 4);
  ihdr[8] = 8;  /* bit depth */
  ihdr[9] = 6;  /* RGBA */
  const stride = w * 4;
  const raw = Buffer.alloc((stride + 1) * h);
  for (let y = 0; y < h; y++) {
    raw[y * (stride + 1)] = 0; /* filter: none */
    rgba.copy(raw, y * (stride + 1) + 1, y * stride, (y + 1) * stride);
  }
  const idat = zlib.deflateSync(raw, { level: 9 });
  return Buffer.concat([sig, chunk("IHDR", ihdr), chunk("IDAT", idat), chunk("IEND", Buffer.alloc(0))]);
}

/* ---------- Emblem geometry (unit square 0..1) ---------- */
/* Crescent: inside circle A, outside circle B (opens to the right) */
function inCrescent(x, y) {
  const d1 = (x - 0.47) * (x - 0.47) + (y - 0.50) * (y - 0.50);
  const d2 = (x - 0.59) * (x - 0.59) + (y - 0.50) * (y - 0.50);
  return d1 <= 0.27 * 0.27 && d2 > 0.24 * 0.24;
}
/* Five-pointed star in the crescent's opening */
const STAR_CX = 0.71, STAR_CY = 0.42, STAR_R = 0.075, STAR_RI = 0.030;
const starPts = [];
for (let i = 0; i < 10; i++) {
  const r = i % 2 === 0 ? STAR_R : STAR_RI;
  const a = -Math.PI / 2 + (i * Math.PI) / 5;
  starPts.push([STAR_CX + r * Math.cos(a), STAR_CY + r * Math.sin(a)]);
}
function inStar(x, y) {
  let inside = false;
  for (let i = 0, j = starPts.length - 1; i < starPts.length; j = i++) {
    const xi = starPts[i][0], yi = starPts[i][1];
    const xj = starPts[j][0], yj = starPts[j][1];
    if ((yi > y) !== (yj > y) && x < ((xj - xi) * (y - yi)) / (yj - yi) + xi) inside = !inside;
  }
  return inside;
}

/* ---------- Render with 4x4 supersampling ---------- */
function render(size, shrink) {
  const S = 4;
  const buf = Buffer.alloc(size * size * 4);
  for (let py = 0; py < size; py++) {
    for (let px = 0; px < size; px++) {
      let hits = 0;
      for (let sy = 0; sy < S; sy++) {
        for (let sx = 0; sx < S; sx++) {
          let x = (px + (sx + 0.5) / S) / size;
          let y = (py + (sy + 0.5) / S) / size;
          if (shrink !== 1) { /* pull geometry toward the centre (maskable safe zone) */
            x = 0.5 + (x - 0.5) / shrink;
            y = 0.5 + (y - 0.5) / shrink;
          }
          if (inCrescent(x, y) || inStar(x, y)) hits++;
        }
      }
      const t = hits / (S * S);
      const o = (py * size + px) * 4;
      buf[o] = Math.round(BRUN[0] + (CREAM[0] - BRUN[0]) * t);
      buf[o + 1] = Math.round(BRUN[1] + (CREAM[1] - BRUN[1]) * t);
      buf[o + 2] = Math.round(BRUN[2] + (CREAM[2] - BRUN[2]) * t);
      buf[o + 3] = 255;
    }
  }
  return buf;
}

/* ---------- Main ---------- */
const outDir = __dirname;
const targets = [
  [192, 1, "icon-192.png"],
  [512, 1, "icon-512.png"],
  [512, 0.8, "icon-maskable-512.png"]
];
for (const [size, shrink, name] of targets) {
  const png = encodePNG(size, size, render(size, shrink));
  fs.writeFileSync(path.join(outDir, name), png);
  console.log("wrote " + name + " (" + png.length + " bytes)");
}
