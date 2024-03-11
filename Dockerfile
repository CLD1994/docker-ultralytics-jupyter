FROM ultralytics/ultralytics:8.1.26

## ROBOFLOW
RUN pip install roboflow \
        && rm -rf ~/.cache/pip

## JupyterLab ##

RUN apt-get update && apt-get install --no-install-recommends -y \
        # - Add necessary fonts for matplotlib/seaborn
        #   See https://github.com/jupyter/docker-stacks/pull/380 for details
        fonts-liberation \
        # - `pandoc` is used to convert notebooks to html files
        #   it's not present in the aarch64 Ubuntu image, so we install it here
        pandoc \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install jupyterlab \
	&& rm -rf ~/.cache/pip

ENV JUPYTER_PORT=8888

EXPOSE $JUPYTER_PORT

CMD jupyter lab --no-browser --allow-root --LabApp.token='' --ServerApp.ip="0.0.0.0"
