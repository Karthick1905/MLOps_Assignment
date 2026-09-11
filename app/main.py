from typing import List
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(
    title="Sample ML API",
    description="Simple API used for MLOps platform engineering demonstration.",
    version="1.0.0",
)

class PredictionRequest(BaseModel):
    features: List[float]

@app.get("/")
def root():
    return {"message": "Hello World from ML API"}

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/ready")
def ready():
    return {"status": "ready"}

@app.post("/predict")
def predict(request: PredictionRequest):
    # Placeholder deterministic inference for platform demonstration.
    prediction = 1 if sum(request.features) >= 0 else 0
    return {
        "prediction": prediction,
        "feature_count": len(request.features),
    }
