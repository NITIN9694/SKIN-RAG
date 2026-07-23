Flutter
    │
    ▼
FastAPI
    │
    ▼
SkinAnalysisService
    │
    ├──────────────┐
    ▼              ▼
Groq Vision     ChromaDB
(Qwen 3.6)      (RAG)
    │              │
    └──────┬───────┘
           ▼
Groq LLM (GPT-OSS 120B / Llama 3.3)
           ▼
      Final Response