FROM nikolaik/python-nodejs:python3.10-nodejs19

# Install ffmpeg (static build)
RUN apt-get update && apt-get install -y --no-install-recommends curl xz-utils \
    && curl -L https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz \
    | tar -xJ --strip-components=1 -C /usr/local/bin --wildcards '*/ffmpeg' '*/ffprobe' \
    && apt-get purge -y --auto-remove curl xz-utils \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app/
RUN pip3 install --no-cache-dir -U -r requirements.txt

CMD ["bash", "start"]
