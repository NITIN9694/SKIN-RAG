from fastapi import APIRouter
from pydantic import BaseModel


from app.rag.retriever import SkinRetriever

router = APIRouter()

retriever = SkinRetriever()

class SearchRequest(BaseModel):
    query: str
    
@router.post("/search") 
def search(request:SearchRequest):
    docs = retriever.retrieve(request.query)
    results = []

    for doc in docs:
        results.append({
            "content": doc.page_content,
            "metadata": doc.metadata
        })

    return {"results": results}      