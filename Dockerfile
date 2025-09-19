
FROM rust:1.89.0
WORKDIR /home

RUN echo 'deb [trusted=yes] https://apt.fury.io/caarlos0/ /' | tee /etc/apt/sources.list.d/caarlos0.list

RUN apt-get update && apt-get install -y libudev-dev git wget python3 python3-pip  python3.13-venv libusb-1.0-0 cmake svu  just lftp

RUN pip3 install --upgrade esptool --break-system-packages

RUN cargo install espup --locked

RUN espup install

RUN cargo install cargo-generate

RUN cargo install ldproxy

RUN cargo install espflash

RUN git clone -b v5.2.5 --recursive https://github.com/espressif/esp-idf.git /home/esp-idf

RUN python3 /home/esp-idf/tools/idf_tools.py install

RUN python3 /home/esp-idf/tools/idf_tools.py install-python-env

ENV IDF_PATH=/home/esp-idf

RUN /home/esp-idf/install.sh

