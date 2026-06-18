@echo off
echo 🚀 Starting deployment to Laptop B via Tailscale...

:: 1. Push kode terbaru dari Laptop A ke GitHub
echo 📤 Pushing latest code to GitHub...
git add .
git commit -m "Automated deploy update"
git push origin main

:: 2. SSH ke Laptop B dan perintahkan untuk pull + restart aplikasi
echo 🖥️ Connecting to Laptop B (VPS) and updating...
ssh atqi@100.110.87.83 "cd apps/my-cloud-app && git pull origin main && npm install --production && pm2 reload my-cloud-app --update-env"

echo 🎉 All done! Check your app at http://100.110.87.83