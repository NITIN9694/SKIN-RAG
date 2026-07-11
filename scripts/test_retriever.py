import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parent.parent))

from app.rag.vector_store import get_vector_store
from app.rag.retriever import SkinRetriever

retriever = SkinRetriever()

query = """
Lesion Type: Pigmented lesion

Color: Dark Brown

Borders: Irregular

Symmetry: Asymmetrical

Summary:
Dark brown irregular skin lesion.
"""

results = retriever.retrieve(query, k=3)

for i, doc in enumerate(results, start=1):
    print("=" * 50)
    print(f"Result {i}")
    print(doc.page_content)
    print(doc.metadata)