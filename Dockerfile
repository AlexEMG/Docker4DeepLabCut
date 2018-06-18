FROM python:3
RUN pip install imageio
# install ffmpeg from imageio.
RUN python -c "import imageio; imageio.plugins.ffmpeg.download()"

FROM bethgelab/deeplearning:cuda8.0-cudnn5

RUN pip3 install easydict
RUN pip install tables #for h5 support
RUN pip install sk-video
RUN pip install requests
RUN pip install moviepy
RUN pip install tqdm
RUN pip install pandas

RUN pip install ipywidgets
RUN pip2 install ipywidgets
RUN pip3 install ipywidgets

RUN pip3 install seaborn
RUN pip install scikit-image
