# 1. Empieza desde una imagen base oficial (Ubuntu 22.04 en este caso)
FROM ubuntu:22.04

# 2. (Opcional) Establece quién es el mantenedor de la imagen
LABEL maintainer="tu-nombre@example.com"

# 3. (Importante) Actualiza los repositorios e instala tu software.
#    - 'RUN' ejecuta comandos DENTRO de la imagen que se está construyendo.
#    - 'apt-get update' actualiza la lista de paquetes.
#    - 'apt-get install -y' instala el software. '-y' acepta automáticamente.
#    - '&& \' se usa para encadenar comandos en una sola capa (buena práctica).
RUN apt-get update && \
    apt-get install -y \
    git \
    python3 \
    python3-pip \
    vim \
    && \
    # Limpia la caché para que la imagen sea más pequeña
    rm -rf /var/lib/apt/lists/*

# 4. (Opcional) Establece el directorio de trabajo por defecto
WORKDIR /app

# 5. (Opcional) Define el comando que se ejecutará cuando inicie el contenedor
#    En este caso, simplemente inicia un shell 'bash'.
CMD ["/bin/bash"]