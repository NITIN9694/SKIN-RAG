from app.providers.vision.groq_provider import GroqVisionProvider
from app.providers.llm.groq_provider import GroqLLMProvider
from app.rag.retriever import SkinRetriever

class SkinAnalysisService:
    def __init__(self):
        self.vision = GroqVisionProvider()
        self.vision_provider = GroqVisionProvider()
        self.retriever = SkinRetriever()
        self.llm = GroqLLMProvider()  

    def analyze(self, image_path: str):
        features = self.vision.analyze(image_path)

        documents = self.retriever.retrieve(
            features["summary"]
        )

        response = self.llm.generate(
            features,
            documents
        )

        return response