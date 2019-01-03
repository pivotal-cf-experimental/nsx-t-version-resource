# docker login -u pasnsxt
# docker build -t pasnsxt/nsx-t-version .
# docker push pasnsxt/nsx-t-version
FROM ubuntu
RUN apt update && \
  apt install -y jq curl
ADD bin /opt/resource
