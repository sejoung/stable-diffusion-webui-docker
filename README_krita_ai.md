# ComfyUI-Manager

```shell

cd data/config/comfy/custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git

```

## stable-diffusion-webui-docker custom branch

```shell

git clone -b custom https://github.com/sejoung/stable-diffusion-webui-docker.git

```

## ComfyUI

Fannovel16/comfyui_controlnet_aux 설치 필요

```shell
docker compose --profile download up --build

docker compose --profile comfy up --build -d

docker compose --profile comfy stop

docker compose --profile comfy down

docker compose --profile comfy restart

```

[krita-ai-diffusion](https://github.com/Acly/krita-ai-diffusion)
