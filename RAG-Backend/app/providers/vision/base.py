from abc import ABC, abstractmethod

class VisionProvider(ABC):
    @abstractmethod
    def analyze(self, image_path: str) -> dict:
        """Analyze an image and return structured information."""
        pass