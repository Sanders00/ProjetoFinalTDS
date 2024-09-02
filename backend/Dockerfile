FROM dart:stable as builder

RUN dart --version
# RUN apt-get update 
# RUN sudo apg-get upgrade dart
RUN dart --version
# RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
# RUN apt-get clean

# RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

COPY . /dart-server
# COPY ../../landing_page/. /web-app
# COPY ../../../../eca_packages/. /web-app/eca_packages

# COPY ./pubspec.yaml /dart-server/backend_app
WORKDIR /dart-server
# COPY ./pubspec.yaml /dart-server/backend
RUN dart pub get
RUN mkdir build
RUN mkdir downloads
RUN dart compile exe ./bin/server.dart -o ./build/gluten_and_lactose_free_app

# WORKDIR /web-app
# RUN flutter pub get
# RUN mkdir build
# RUN mkdir eca_packages
# RUN flutter build web

# FROM debian:buster-slim
FROM scratch
COPY --from=builder /dart-server/assets/dev.env ./assets/dev.env 
COPY --from=builder /dart-server/assets/prod.env ./assets/prod.env 
COPY --from=builder /runtime/ /
COPY --from=builder /dart-server/build /bin

# COPY --from=builder /web-app/assets/. ./assets/.
# COPY --from=builder /web-app/build/web .

CMD ["gluten_and_lactose_free_app"]
# CMD ["./build/danco_contigo"]