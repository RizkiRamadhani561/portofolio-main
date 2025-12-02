# Portfolio Deployment Guide

## ⚠️ Penting: Path Issue

Project Anda berada di path dengan karakter Unicode/Japanese yang menyebabkan error build di Windows:
```
C:\Users\ramsc\OneDrive\ドキュメント\latihan\portfolio-main
```

### Solusi 1: Pindahkan Project (Recommended)
Pindahkan folder ke path tanpa karakter spesial:
```powershell
# Contoh:
C:\Projects\portfolio-main
D:\dev\portfolio-main
C:\Users\ramsc\portfolio-main
```

### Solusi 2: Gunakan WSL2 / Linux Subsystem
Jika Anda menggunakan WSL2, cloninging project di Linux path akan menghindari masalah ini.

---

## 📋 Optimasi yang Telah Dilakukan

### 1. **next.config.ts**
- ✅ Image optimization dengan format AVIF & WebP
- ✅ Production browser source maps disabled
- ✅ Security headers configuration
- ✅ Optimized package imports untuk 3D libraries
- ✅ Cache headers untuk static assets (1 tahun)

### 2. **tsconfig.json**
- ✅ Target updated ke ES2020 (lebih optimal)
- ✅ Source maps disabled di production
- ✅ Comments removed dari build
- ✅ Duplicate paths dihapus

### 3. **tailwind.config.js**
- ✅ Purge CSS configuration
- ✅ Production-ready setup

### 4. **Build Optimization Files**
- ✅ `.env.production` - Environment variables untuk production
- ✅ `.vercelignore` - Files yang diabaikan di deployment
- ✅ `.npmrc` - NPM configuration untuk faster builds

---

## 🚀 Deployment Steps

### Untuk Vercel (Recommended)

1. **Push ke GitHub:**
   ```bash
   git add .
   git commit -m "Optimized for production deployment"
   git push origin main
   ```

2. **Import ke Vercel:**
   - Buka https://vercel.com
   - Klik "New Project"
   - Select GitHub repository
   - Framework: Next.js
   - Klik "Deploy"

3. **Konfigurasi Vercel:**
   - Environment: Production
   - Node Version: 20.x (atau latest)
   - Build Command: `npm run build` (default)
   - Output Directory: `.next` (default)

### Untuk Deployment Lokal

Setelah pindah ke path tanpa Unicode:

```powershell
# Build production
npm run build

# Start production server
npm start
```

### Untuk Docker Deployment

```dockerfile
FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

COPY --from=builder --chown=nextjs:nodejs /app/.next ./app/.next
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=deps --chown=nextjs:nodejs /app/package*.json ./
COPY public ./public

USER nextjs
EXPOSE 3000
ENV NODE_ENV production

CMD ["npm", "start"]
```

---

## 🔧 Build & Runtime Configuration

### Environment Variables
Set di production platform:
```
NODE_ENV=production
NEXT_PUBLIC_ANALYTICS_ID=your-analytics-id
```

### Recommended Platform
- **Vercel** - Best for Next.js (free tier tersedia)
- **Netlify** - Good alternative
- **AWS Amplify** - Untuk enterprise
- **DigitalOcean App Platform** - Cost-effective

---

## 📊 Performance Tips

1. **Asset Optimization:**
   - Gunakan WebP format untuk images
   - Optimize SVG files
   - Minimize font loading

2. **Bundle Analysis:**
   ```bash
   npm install --save-dev @next/bundle-analyzer
   ```

3. **Monitoring:**
   - Enable Vercel Analytics
   - Monitor Core Web Vitals
   - Setup error tracking

---

## ✅ Deployment Checklist

- [ ] Pindahkan project ke path tanpa Unicode
- [ ] Test build locally: `npm run build`
- [ ] Test production: `npm start`
- [ ] Push ke GitHub
- [ ] Connect dengan Vercel
- [ ] Setup custom domain (optional)
- [ ] Enable analytics & monitoring
- [ ] Test di production

---

## 🐛 Troubleshooting

### Build fails with readlink error
→ Pindahkan project ke path berbeda tanpa karakter spesial

### Build timeout
→ Increase timeout di Vercel settings atau kurangi bundle size

### Static generation issues
→ Gunakan `revalidate` untuk ISR (Incremental Static Regeneration)

---

Generated for optimization: December 2, 2025
