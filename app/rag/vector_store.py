
from app.rag.embedding import get_embedding_model
from langchain_chroma import Chroma

def get_vector_store():
    return Chroma(
        collection_name="skin_dataset",
        persist_directory="chroma_db",
        embedding_function=get_embedding_model(),
    )