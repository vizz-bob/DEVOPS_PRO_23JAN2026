from fastapi import FastAPI
from fastapi.responses import JSONResponse

app = FastAPI(title="Auth Service")

@app.get("/health")
def health():
    return JSONResponse(content={"status": "ok"})

@app.get("/login")
def login():
    return JSONResponse(content={"message": "Login endpoint working"})

