# 1. Empieza desde una imagen base oficial (Ubuntu 22.04 en este caso)
FROM ubuntu:24.04

LABEL maintainer="miles-militis@hotmail.com"
# 2. Configurar el entorno para que no pida confirmaciones interactivas
ENV DEBIAN_FRONTEND=noninteractive
ENV PDK_ROOT /root/TTdev/ttsetup/pdk
ENV PDK sky130A
ENV LIBRELANE_TAG 2.4.2
###############################################
#For GF180MCU enable this line
#ENV PDK gf180mcuD
###############################################
#for IHP projects set this environment variables
#ENV PDK ihp-sg13g2
#ENV LIBRELANE_TAG 3.0.0.dev39

# 3. Instalar dependencias. 
#    'python3-pip' y 'python3-venv' usarán la versión 3.12 del sistema.
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    git \
    python3-pip \
    python3.12-venv \
    libcairo2-dev \
    xterm \
    xfce4-terminal \
    python3.12-tk \
    curl \
    && \
    rm -rf /var/lib/apt/lists/*

# 4. ---------- NUEVO: Instalar el Cliente de Docker ----------
#    Esto es necesario para que librelane (Docker-en-Docker) funcione.
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get install -y docker-ce-cli
# -----------------------------------------------------------------

    
RUN git clone https://github.com/TinyTapeout/ttsky25b-factory-test /root/TTdev/factory-test
RUN git clone https://github.com/TinyTapeout/tt-support-tools /root/TTdev/factory-test/tt
###############################################
#for IHP projects set this environment variables
#run git clone -b tt2025 https://github.com/TinyTapeout/IHP-Open-PDK $PDK_ROOT

RUN mkdir /root/TTdev/ttsetup
RUN python3.12 -m venv /root/TTdev/ttsetup/venv
#    Instala 'requirements.txt' Y 'librelane' en el venv
RUN /root/TTdev/ttsetup/venv/bin/pip install -r /root/TTdev/factory-test/tt/requirements.txt && \
    /root/TTdev/ttsetup/venv/bin/pip install librelane==${LIBRELANE_TAG}

# 7. Establece el directorio de trabajo
WORKDIR /root/TTdev/factory-test
RUN /bin/bash -c "source /root/TTdev/ttsetup/venv/bin/activate && \
                  python3 tt/tt_tool.py --create-user-config"


# 8. Define el comando de inicio
CMD ["xfce4-terminal", "-e", "/bin/bash -c 'source /root/TTdev/ttsetup/venv/bin/activate && cd /root/TTdev && /bin/bash'"]
