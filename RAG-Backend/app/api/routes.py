import os
import shutil
import uuid

from fastapi import APIRouter,File, HTTPException,UploadFile
from app.service.skin_analysis_service import SkinAnalysisService


router = APIRouter()
service = SkinAnalysisService()

UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)

@router.post("/analyze")
async def analyze_skin(file: UploadFile = File(...)):

    if not file.content_type.startswith("image/"):
        raise HTTPException(
            status_code=400,
            detail="Please upload an image."
        )

    extension = file.filename.split(".")[-1]
    filename = f"{uuid.uuid4()}.{extension}"
    image_path = os.path.join(UPLOAD_DIR, filename)

    try:
        with open(image_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        result = service.analyze(image_path)

        return result

    finally:
        if os.path.exists(image_path):
            os.remove(image_path)