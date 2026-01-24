from fastapi import FastAPI
from fastapi.responses import JSONResponse

app = FastAPI(title="Catalog Service")

@app.get("/health")
def health():
    return JSONResponse(content={"status": "ok"})

@app.get("/items")
def list_items():
    return JSONResponse(content={"items": ["item1", "item2", "item3"]})

