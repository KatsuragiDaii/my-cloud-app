@echo off

set "VPS_IP=100.110.87.83"
set "VPS_USER=atqi"
set "APP_DIR=/home/atqi/apps/my-cloud-app/my-cloud-app"
set "APP_NAME=my-cloud-app"

echo Starting deployment to Laptop B via Tailscale...

echo Pushing latest code to GitHub...
git add .
git commit -m "Docker integration update" || echo No changes to commit
git push origin main

echo Connecting to Laptop B and updating app...
ssh %VPS_USER%@%VPS_IP% "bash -lc 'cd %APP_DIR% && git pull origin main && npm install --omit=dev && (pm2 reload %APP_NAME% --update-env || pm2 start server.js --name %APP_NAME%) && pm2 save'"

echo Deployment finished.
echo Check your app at:
echo http://%VPS_IP%
echo or
echo http://%VPS_IP%:3000