# 1. Empieza desde una imagen base oficial (Ubuntu 22.04 en este caso)
FROM ubuntu:24.04

LABEL maintainer="miles-militis@hotmail.com"
# 2. Configurar el entorno para que no pida confirmaciones interactivas
ENV DEBIAN_FRONTEND=noninteractive

ENV PDK_ROOT /root/ttsetup/pdk
ENV PDK sky130A
ENV LIBRELANE_TAG 2.4.2

# 3. Instalar dependencias. 
#    'python3-pip' y 'python3-venv' usarán la versión 3.12 del sistema.
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    git \
    python3-pip \
    python3.12-venv \
    libcairo2-dev \
    && \
    rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/TinyTapeout/ttsky25b-factory-test /root/TTdev/factory-test
RUN git clone https://github.com/TinyTapeout/tt-support-tools /root/TTdev/factory-test/tt
RUN mkdir /root/ttsetup
RUN python3.12 -m venv /root/ttsetup/venv
#    Instala 'requirements.txt' Y 'librelane' en el venv
RUN /root/ttsetup/venv/bin/pip install -r /root/TTdev/factory-test/tt/requirements.txt && \
    /root/ttsetup/venv/bin/pip install librelane==${LIBRELANE_TAG}

# 7. Establece el directorio de trabajo
WORKDIR /root/TTdev/factory-test
RUN /bin/bash -c "source /root/ttsetup/venv/bin/activate && \
                  python3 tt/tt_tool.py --create-user-config"


# 8. Define el comando de inicio
CMD ["/bin/bash"]