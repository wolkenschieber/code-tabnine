# Readme

This project provides an isolated environment to test the AI assistant [Tabnine](https://www.tabnine.com/) in [Visual Studio Code](https://code.visualstudio.com/). 

Docker images are available on [dockerhub](https://hub.docker.com/r/wolkenschieber/code-tabnine):
| Image                                           | Arch    |
| ----------------------------------------------- | ------- |
| `wolkenschieber/code-tabnine:latest`         | `amd64` |

## Docker

### Run 

#### Background

```sh
docker run --detach \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/Berlin \
    -p 3000:3000 \
    --name code-tabnine \
    --security-opt seccomp=unconfined \
    --shm-size="1gb" \
    wolkenschieber/code-tabnine:latest
```
#### Diagnostic

```sh
docker run --rm -it \
    -e CODE_RUN_AS_ROOT=0 \
    -e CODE_DEBUG=1 \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/Berlin \
    -p 3000:3000 \
    --name code-tabnine \
    --security-opt seccomp=unconfined \
    --shm-size="1gb" \
    wolkenschieber/code-tabnine:latest \
    bash
```
### Pull

```sh
docker pull wolkenschieber/code-tabnine:latest
```
### Build

```sh
docker build --tag wolkenschieber/code-tabnine:latest .
```

## Docker Compose

This project provides a sample [docker-compose.yml](https://github.com/wolkenschieber/code-tabnine/blob/master/docker-compose.yml) file.

### Run

```sh
docker compose up -d
```
### Pull

```sh
docker compose pull
```
### Build

```sh
docker compose -f docker-compose.yml -f docker-compose.build.yml build
```
### Proxy

The container follows default proxy environment variables:
```yaml
environment:
    - "HTTP_PROXY=http://proxyhost:8080"
    - "HTTPS_PROXY=http://proxyhost:8080"      
    - "NO_PROXY=127.0.0.1"
```
## Parameters

| Parameter | Function |
| :----: | --- |
| `-p 3000` | Code-Tabnine desktop gui. |
| `-e PUID=1000` | for UserID |
| `-e PGID=1000` | for GroupID |
| `-e TZ=Etc/UTC` | specify a timezone to use |
| `-e CODE_DEBUG=1` | run Code with program args `--verbose` |
| `-e CODE_RUN_AS_ROOT=1` | run Code as root |
| `-v /config` | User's home directory in the container, stores program settings. |
| `--security-opt seccomp=unconfined` | Permits syscalls of Chromium and Code |
| `--shm-size=` | This is needed for electron applications to function properly. |

## Mac/Apple silicon

On Apple silicon run [docker-compose.mac.yml](https://github.com/wolkenschieber/code-tabnine/blob/master/docker-compose.mac.yml) file. Update `PUID` and `PGID` according to the output of `id your_user`.

## Links

* [linuxserver/kasmvnc](https://github.com/linuxserver/docker-baseimage-kasmvnc)
* [wolkenschieber/docker-chromium](https://github.com/wolkenschieber/docker-chromium/tree/master)
* [wolkenschieber/code-tabnine](https://hub.docker.com/r/wolkenschieber/code-tabnine)
* [wolkenschieber/eclipse-tabnine](https://hub.docker.com/r/wolkenschieber/eclipse-tabnine)
* [Code - Command line extension management](https://code.visualstudio.com/docs/editor/extension-marketplace)