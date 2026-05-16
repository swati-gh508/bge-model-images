FROM python:3.11-slim

ENV HF_HOME=/models
ENV TRANSFORMERS_CACHE=/models
ENV SENTENCE_TRANSFORMERS_HOME=/models
ENV HF_HUB_DISABLE_TELEMETRY=1

WORKDIR /app

RUN pip install --no-cache-dir \
    --index-url https://download.pytorch.org/whl/cpu \
    torch

RUN pip install --no-cache-dir \
    transformers \
    sentence-transformers

# Save embedding model cleanly
RUN python -c "\
from sentence_transformers import SentenceTransformer; \
model = SentenceTransformer('BAAI/bge-base-en-v1.5'); \
model.save('/models/bge-base-en-v1.5')"

# Save reranker cleanly
RUN python -c "\
from sentence_transformers import CrossEncoder; \
model = CrossEncoder('BAAI/bge-reranker-base'); \
model.model.save_pretrained('/models/bge-reranker-base'); \
model.tokenizer.save_pretrained('/models/bge-reranker-base')"

RUN rm -rf /root/.cache/pip

CMD [\"bash\"]
