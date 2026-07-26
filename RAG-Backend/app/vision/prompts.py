from abc import ABC, abstractmethod


class VisionAnalyzer(ABC):

    @abstractmethod
    def analyze(self, image_path: str) -> dict:
        """Analyze an image and return structured skin features."""
        pass