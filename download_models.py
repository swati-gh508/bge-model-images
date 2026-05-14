from sentence_transformers import SentenceTransformer, CrossEncoder

# Embedding model
SentenceTransformer("BAAI/bge-base-en-v1.5")

# Reranker model
CrossEncoder("BAAI/bge-reranker-base")

print("Models downloaded successfully")
