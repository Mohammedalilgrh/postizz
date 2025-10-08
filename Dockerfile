# استخدم صورة Postiz الرسمية من GitHub Container Registry
FROM ghcr.io/gitroomhq/postiz:latest

# expose port 5000 داخل الحاوية
EXPOSE 5000

# إعداد المتغيرات البيئية البسيطة
ENV POSTIZ_APP_URL=https://postizz.onrender.com
ENV POSTIZ_SECRET_KEY=simplekey123

# تشغيل التطبيق مباشرة
CMD ["npm", "start"]
