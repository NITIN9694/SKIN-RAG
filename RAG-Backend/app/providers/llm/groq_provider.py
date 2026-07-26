import json
import os

from app.providers.groq.client import get_groq_client
from app.providers.llm.base import LLMProvider
from app.providers.llm.prompt import LLM_PROMPT


class GroqLLMProvider(LLMProvider):

    def __init__(self):
        self.client = get_groq_client()
        self.model = os.getenv(
            "GROQ_LLM_MODEL",
            "openai/gpt-oss-120b"
        )

    def generate(
        self,
        features: dict,
        retrieved_documents: list
    ) -> dict:

        context = "\n\n".join(
            [
                doc.page_content
                for doc in retrieved_documents
            ]
        )

        prompt = f"""
{LLM_PROMPT}

Skin Features

{json.dumps(features, indent=2)}

Retrieved Cases

{context}
"""

        response = self.client.chat.completions.create(
            model=self.model,
            response_format={"type": "json_object"},
            messages=[
                {
                    "role": "user",
                    "content": prompt
                }
            ]
        )

        return json.loads(
            response.choices[0].message.content
        )