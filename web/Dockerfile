FROM ghcr.io/cirruslabs/flutter:latest as builder

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 pkg-config python3
RUN apt-get clean

# RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor -v

# RUN flutter upgrade

RUN mkdir /app/
# RUN mkdir /app/eca_packages
# RUN mkdir /app/lp/
# RUN mkdir /app/common/

COPY . /app
# COPY ../common/. /app/common/
# COPY ../../eca_packages/. /app/eca_packages/

WORKDIR /app/

ARG CACHEBUST=1

RUN flutter clean
RUN flutter pub get
RUN flutter build web --web-renderer html
# COPY ./assets/. /app/assets/.

EXPOSE 5000

RUN ["chmod", "+x", "/app/server/server.sh"]

# COPY --from=builder /web-app/assets/. ./assets/.
# COPY --from=builder /web-app/build/web .

ENTRYPOINT [ "/app/server/server.sh"]
# CMD ["danco_contigo"]
# CMD ["./build/danco_contigo"]