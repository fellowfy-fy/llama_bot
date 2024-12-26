FROM python

WORKDIR /usr/src/app

# Установка Раста
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Копируем и устанавливаем зависимости Python
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Копируем все файлы из текущей директории в рабочую директорию контейнера
COPY . .

# Команда запуска контейнера
CMD ["/bin/bash", "-c", "python run.py"]