# Используем образ Python
FROM python:3.12-slim

# Устанавливаем рабочую директорию
WORKDIR /usr/src/app

# Устанавливаем зависимости системы
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl libssl-dev libffi-dev python3-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Установка Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    echo 'source $HOME/.cargo/env' >> ~/.bashrc
ENV PATH="/root/.cargo/bin:${PATH}"

# Копируем и устанавливаем зависимости Python
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Копируем исходный код проекта
COPY . .

# Команда запуска контейнера
CMD ["python", "run.py"]
