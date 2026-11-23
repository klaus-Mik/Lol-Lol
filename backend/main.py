import os
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="GCP Docker CI/CD App")

items = [
    {"id": 1, "note": "Build Docker image in WSL Ubuntu"},
    {"id": 2, "note": "Push via GitHub Actions & provision with Terraform"},
]


class NoteIn(BaseModel):
    note: str


@app.get("/api/health")
def health():
    return {"status": "ok", "env": os.getenv("APP_ENV", "local")}


@app.get("/api/notes")
def get_notes():
    return {"notes": items}


@app.post("/api/notes", status_code=201)
def add_note(payload: NoteIn):
    created = {"id": len(items) + 1, "note": payload.note}
    items.append(created)
    return created