FROM pimachinelearning/raspi-python:3.9.16

ARG VISION_VERSION=0.15.2

RUN wget https://github.com/pytorch/vision/archive/refs/tags/v${VISION_VERSION}.tar.gz && mkdir vision && tar -zxf v${VISION_VERSION}.tar.gz --strip-components=1 -C vision

COPY pip.conf /etc/pip.conf

RUN cd vision && apt install -y libatlas3-base libgfortran5 && python3 -m pip install torch numpy pillow wheel 
RUN cd vision && BUILD_VERSION=${VISION_VERSION} python3 setup.py bdist_wheel

CMD ["find", "/vision", "-name", "torchvision*.whl"]
