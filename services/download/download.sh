#!/usr/bin/env bash

set -Eeuo pipefail

# TODO: maybe just use the .gitignore file to create all of these
mkdir -vp /data/.cache \
  /data/embeddings \
  /data/config/ \
  /data/models/ \
  /data/models/Stable-diffusion \
  /data/models/GFPGAN \
  /data/models/RealESRGAN \
  /data/models/ESRGAN \
  /data/models/LDSR \
  /data/models/HAT \
  /data/models/VAE \
  /data/models/OmniSR \
  /data/models/clip_vision/SD1.5 \
  /data/models/Lora \
  /data/models/hypernetworks \
  /data/models/ControlNet \
  /data/models/CLIPEncoder \
  /data/models/ipadapter \
  /data/models/animatediff_motion_lora \
  /data/models/animatediff_models \
  /data/models/unet \
  /data/config/comfy/custom_nodes

echo "comfyui plugin, this might take a while..."

# 플러그인 초기화
rm -rf /data/config/comfy/custom_nodes/*

# comfyui manager 추가
git clone https://github.com/ltdrdata/ComfyUI-Manager.git /data/config/comfy/custom_nodes/ComfyUI-Manager

# ComfyUI IPAdapter plus 추가
git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git /data/config/comfy/custom_nodes/ComfyUI_IPAdapter_plus

# ComfyUI UltimateSDUpscale 추가
git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git /data/config/comfy/custom_nodes/ComfyUI_UltimateSDUpscale --recursive

# ComfyUI Nodes for External Tooling 추가
git clone https://github.com/Acly/comfyui-tooling-nodes.git /data/config/comfy/custom_nodes/comfyui-tooling-nodes

# ComfyUI Inpaint Nodes 추가
git clone https://github.com/Acly/comfyui-inpaint-nodes.git /data/config/comfy/custom_nodes/comfyui-inpaint-nodes

# ComfyUI ControlNet Aux 추가
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git /data/config/comfy/custom_nodes/comfyui_controlnet_aux

echo "Downloading, this might take a while..."

aria2c -x 10 --disable-ipv6 --input-file /docker/links.txt --dir /data/models --continue

echo "Checking SHAs..."

parallel --will-cite -a /docker/checksums.sha256 "echo -n {} | sha256sum -c"

cat <<EOF
By using this software, you agree to the following licenses:
https://github.com/AbdBarho/stable-diffusion-webui-docker/blob/master/LICENSE
https://github.com/CompVis/stable-diffusion/blob/main/LICENSE
https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/LICENSE.txt
https://github.com/invoke-ai/InvokeAI/blob/main/LICENSE
And licenses of all UIs, third party libraries, and extensions.
EOF
