<img width="1536" height="1024" alt="ChatGPT Image Jul 26, 2026, 06_36_59 PM" src="https://github.com/user-attachments/assets/00db4aa1-fe9e-435f-be7c-eebaf8667fef" />
# 🩺 Skin-RAG: AI-Powered Skin Analysis using Vision + RAG + LLM

## 📌 Overview

Skin-RAG is a production-style AI application that analyzes skin images using a multimodal Retrieval-Augmented Generation (RAG) pipeline.

The system combines:

* **Vision AI** for extracting structured skin features from an image
* **Vector Search (ChromaDB)** to retrieve similar medical cases
* **Large Language Model (LLM)** to generate an evidence-grounded explanation and recommendations

> **Disclaimer:** This project is for educational and research purposes only. It does **not** provide medical diagnoses or replace professional healthcare advice.

---

# ✨ Features

* 📷 Upload a skin image
* 🤖 AI-powered skin feature extraction
* 🔍 Retrieval-Augmented Generation (RAG)
* 🧠 Context-aware LLM reasoning
* ⚡ FastAPI backend
* 💾 ChromaDB vector database
* 🌐 REST API
* 📱 Flutter-ready backend

---

# 🏗️ System Architecture

```text
                    User
                      │
                      ▼
              Upload Skin Image
                      │
                      ▼
                FastAPI Backend
                      │
                      ▼
          SkinAnalysisService
          ┌─────────┼─────────┐
          ▼         ▼         ▼
   Vision Provider  Retriever  LLM Provider
          │         │          │
          ▼         ▼          ▼
    Groq Vision   ChromaDB   Groq LLM
          │         │          │
          └─────────┼──────────┘
                    ▼
            AI Generated Response
```

---

# 🔄 Application Workflow

```text
Image Upload
      │
      ▼
Groq Vision Model
      │
Extract Skin Features
      │
      ▼
Generate Search Query
      │
      ▼
ChromaDB Vector Search
      │
Retrieve Similar Cases
      │
      ▼
Groq LLM
      │
Generate Final Response
      │
      ▼
JSON Response
```

---

# 🧠 AI Models Used

## Vision Model

**Provider:** Groq

**Model:**

```
qwen/qwen3.6-27b
```

Purpose:

* Analyze uploaded skin image
* Detect visual characteristics
* Extract structured information

Example Output:

```json
{
  "lesion_type": "",
  "color": "",
  "symmetry": "",
  "borders": "",
  "texture": "",
  "summary": ""
}
```

---

## Large Language Model

**Provider:** Groq

**Model:**

```
openai/gpt-oss-120b
```

Purpose:

* Read retrieved medical knowledge
* Explain findings
* Generate recommendations
* Produce structured JSON output

---

# 📚 Dataset

This project uses the **Sunny Skin & Sunscreen Extract Dataset** published on Hugging Face.

Dataset:

https://huggingface.co/datasets/mrdbourke/sunny-skin-and-sunscreen-extract-1k

Dataset Features:

* Image
* Image ID
* Input Prompt
* Structured Output
* Source

Approximate Size:

* **987** samples

Each record contains:

* Skin image
* AI-generated structured annotations
* Medical description

---

# 🧩 Retrieval-Augmented Generation (RAG)

The project uses RAG to improve the quality of AI responses.

Pipeline:

```
Vision Features
        │
        ▼
Embedding Model
        │
        ▼
ChromaDB
        │
Similarity Search
        │
Retrieve Top K Documents
        │
        ▼
LLM
```

Instead of relying only on the LLM's internal knowledge, the system retrieves relevant medical examples before generating the final response.

---

# 🗄️ Vector Database

**Database**

* ChromaDB

Purpose:

* Store document embeddings
* Perform similarity search
* Retrieve related medical cases

---

# ⚙️ Tech Stack

## Backend

* Python
* FastAPI
* Uvicorn

## AI

* Groq API
* Qwen Vision Model
* GPT-OSS 120B

## RAG

* LangChain
* ChromaDB
* HuggingFace Embeddings

## Environment

* Python 3.12
* dotenv

---

# 📁 Project Structure

```
skin-rag/

app/
│
├── api/
│
├── core/
│
├── providers/
│   ├── vision/
│   ├── llm/
│   └── groq/
│
├── rag/
│
├── service/
│
├── schemas/
│
└── main.py

chroma_db/

data/

uploads/

scripts/

README.md
```

---

# 🚀 API Endpoint

## Analyze Skin

```
POST /api/analyze
```

Content-Type:

```
multipart/form-data
```

Parameter:

| Name | Type  |
| ---- | ----- |
| file | Image |

---

Example Response

```json
{
  "possible_condition": "Benign melanocytic nevus",
  "confidence": "Moderate",
  "explanation": "The retrieved medical cases indicate similarity with benign pigmented lesions.",
  "recommendations": [
    "Monitor changes in size or colour.",
    "Consult a dermatologist if changes occur."
  ],
  "disclaimer": "This AI-generated assessment is not a medical diagnosis."
}
```

---

# 🔒 Environment Variables

Create a `.env` file.

```
GROQ_API_KEY=your_api_key

GROQ_VISION_MODEL=qwen/qwen3.6-27b

GROQ_LLM_MODEL=openai/gpt-oss-120b

CHROMA_DB_PATH=chroma_db

UPLOAD_DIR=uploads
```

---

# ▶️ Running the Project

Clone repository

```bash
git clone https://github.com/<your-username>/skin-rag.git
cd skin-rag
```

Create virtual environment

```bash
python -m venv venv
```

Activate

macOS/Linux

```bash
source venv/bin/activate
```

Windows

```bash
venv\Scripts\activate
```

Install dependencies

```bash
pip install -r requirements.txt
```

Run

```bash
uvicorn app.main:app --reload
```

Swagger

```
http://127.0.0.1:8000/docs
```

---

# 🔮 Future Improvements

* Flutter Mobile Application
* Authentication
* Medical Report PDF
* Patient History
* Cloud Storage
* Docker
* CI/CD Pipeline
* Kubernetes Deployment
* Monitoring & Logging
* Unit & Integration Tests

---

# ⚠️ Disclaimer

This project is intended for educational and research purposes only.

The AI-generated output should not be interpreted as medical advice or a diagnosis. Always consult a qualified healthcare professional for medical concerns.

---

# 👨‍💻 Author

**Nitin Jha**

Flutter Developer | AI Enthusiast | FastAPI | LangChain | RAG | Computer Vision

If you found this project helpful, consider giving it a ⭐ on GitHub.
