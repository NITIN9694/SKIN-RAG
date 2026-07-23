from abc import ABC, abstractmethod


class LLMProvider(ABC):

    @abstractmethod
    def generate(self, features: dict, retrieved_documents: list) -> dict:
        pass