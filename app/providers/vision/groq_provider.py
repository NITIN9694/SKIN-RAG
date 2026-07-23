import os
import json
import base64
from dotenv import load_dotenv
from groq import Groq

from app.providers.vision.base import VisionProvider
from app.providers.vision.prompt import VISION_PROMPT


load_dotenv()


class GroqVisionProvider(VisionProvider):
    """
    Vision provider implementation using the Groq API.
    """

    def __init__(self):
        api_key = os.getenv("GROQ_API_KEY")

        if not api_key:
            raise ValueError("GROQ_API_KEY not found in environment variables.")

        self.client = Groq(api_key=api_key)

        # Change this if you want to use another Groq vision model
        self.model = "qwen/qwen3.6-27b"

    @staticmethod
    def _encode_image(image_path: str) -> str:
        """
        Convert an image to a Base64 string.
        """

        if not os.path.exists(image_path):
            raise FileNotFoundError(f"Image not found: {image_path}")

        with open(image_path, "rb") as image:
            return base64.b64encode(image.read()).decode("utf-8")

    def analyze(self, image_path: str) -> dict:
        """
        Analyze a skin image using the Groq Vision model.
        """

        base64_image = self._encode_image(image_path)

        response = self.client.chat.completions.create(
            model=self.model,
            response_format={"type": "json_object"},
            messages=[
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "text",
                            "text": VISION_PROMPT,
                        },
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:image/jpeg;base64,{base64_image}"
                            },
                        },
                    ],
                }
            ],
        )

        content = response.choices[0].message.content

        try:
            return json.loads(content)

        except json.JSONDecodeError:
            raise ValueError(
                f"Invalid JSON returned from Groq:\n\n{content}"
            )