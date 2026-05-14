FROM python:3.11-slim

ENV HF_HOME=/models
ENV TRANSFORMERS_CACHE=/models
ENV SENTENCE_TRANSFORMERS_HOME=/models

WORKDIR /app

RUN pip install --no-cache-dir \
    torch \
    transformers \
    sentence-transformers

COPY download_models.py .

RUN python download_models.py

# Optional cleanup
RUN rm -rf /root/.cache/pip

CMD ["bash"]
