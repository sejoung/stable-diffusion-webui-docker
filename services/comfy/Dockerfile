FROM pytorch/pytorch:2.4.0-cuda12.1-cudnn9-runtime

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN apt-get update && apt-get install -y git ffmpeg libsm6 libxext6 gcc g++ && apt-get clean

ENV ROOT=/stable-diffusion
RUN --mount=type=cache,target=/root/.cache/pip \
  git clone https://github.com/comfyanonymous/ComfyUI.git ${ROOT}

WORKDIR ${ROOT}

RUN pip install -r requirements.txt
RUN pip install insightface==0.7.3 opencv-python xformers onnxruntime-gpu --extra-index-url https://aiinfra.pkgs.visualstudio.com/PublicPackages/_packaging/onnxruntime-cuda-12/pypi/simple/

# add info
COPY . /docker/
RUN cp /docker/extra_model_paths.yaml ${ROOT}
RUN chmod u+x /docker/entrypoint.sh
RUN cp /docker/extra_model_paths.yaml ${ROOT}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 7860
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python -u main.py --listen --port 7860 ${CLI_ARGS}
