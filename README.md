# FastAPI + React Cloud Deployment Demo

## 🔧 Local Development

### Backend (FastAPI)
```bash
cd backend
docker build -t fastapi-app .
docker run -p 8000:8000 fastapi-app
