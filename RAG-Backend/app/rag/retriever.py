from app.rag.vector_store import get_vector_store

class SkinRetriever:

    def __init__(self):
        self.vector_store = get_vector_store()

    def retrieve(self, query: str, k: int = 3):
        return self.vector_store.similarity_search(
            query=query,
            k=k
        )