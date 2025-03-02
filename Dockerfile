FROM rocm/dev-ubuntu-24.04

# Set the working directory in the container
WORKDIR /app

# Install Jupyter Notebook
RUN apt-get update && \
		apt-get install -y python3 python3-pip python3-venv git 

RUN python3 -m venv /venv
SHELL ["/bin/bash", "-c"]
RUN source /venv/bin/activate && \
		pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.2.4 && \
		pip3 install --no-cache-dir jupyterlab

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Define environment variable
ENV JUPYTER_ENABLE_LAB=yes

# Run jupyter lab on container start
CMD ["/bin/bash", "-c", "source /venv/bin/activate && jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]
