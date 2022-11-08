FROM python:3

RUN apt update
RUN apt install -y apt-transport-https curl gnupg
RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
RUN mv bazel-archive-keyring.gpg /usr/share/keyrings
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN apt update && apt -y install bazel git libboost-all-dev
RUN apt update && apt -y full-upgrade
RUN pip install numpy

COPY . /visqol
WORKDIR /visqol
RUN ls
RUN bazel test -c opt python:visqol_lib_py_test
