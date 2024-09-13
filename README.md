# Docker image for Flutter SDK

Docker image to build a Flutter app `*.apk` for Android. The latest image contains always the latest stable version of the Flutter SDK: https://flutter.dev/docs/development/tools/sdk/releases?tab=linux

<a href="https://github.com/slashwhy/flutter-sdk-image/releases/tag/3.24.3"><img src="https://img.shields.io/badge/Current%20version-3.24.3-blue.svg"/></a>

## Releases

For a full list of releases, see the [releases page](https://github.com/slashwhy/flutter-sdk-image/releases) of this repository.

## Usage

The image can be used on different cloud build services or own hosted pipeline solutions like Travis CI, CircleCI or GitLab CI/CD.

### CircleCI

CircleCI supports the direct specification of a Docker image and checks out the source code in it: https://circleci.com/docs/2.0/circleci-images/

Therefore you execute your CI script directly in the container.

Example:

```
# .circleci/config.yml
version: 2.1
jobs:
  build:
    docker:
      - image: slashwhyorganization/flutter-sdk-image:3.24.3
    steps:
      - checkout
      - run:
          name: Flutter Build
          command: flutter build apk
```

Example Project: https://github.com/mobiledevops/flutter-ci-demo

### Travis CI

To use a Docker container on Travis CI, you have to pull, run and execute it manually because Travis CI has no Docker executor: https://docs.travis-ci.com/user/docker/

And to prevent to do a new checkout of the source code in the Docker image, you can copy the code into the container via `tar` (see https://docs.docker.com/engine/reference/commandline/cp/).
To execute your CI script, use `docker exec` with the container name.

Example:

```
# .travis.yml
dist: bionic

services:
  - docker

env:
  - DOCKER_IMAGE=slashwhyorganization/flutter-sdk-image:3.24.3

before_install:
  - docker pull $DOCKER_IMAGE
  - docker run --name android_ci -t -d $DOCKER_IMAGE /bin/sh
  - tar Ccf . - . | docker exec -i android_ci tar Cxf /home/mobiledevops/app -

script:
  - docker exec android_ci flutter build apk
```

Example Project: https://github.com/mobiledevops/flutter-ci-demo

### GitLab CI

GitLab CI/CD supports to run jobs on provided Docker images: https://docs.gitlab.com/runner/executors/docker.html

Therefore you execute your CI script directly in the container.

Example:

```
# .gitlab-ci.yml
image: slashwhyorganization/flutter-sdk-image:3.24.3

stages:
    - build

release_build:
    stage: build
    tags:
      - shared
    script:
        - flutter build apk
```

---

[Contributing](.github/CONTRIBUTING.md)
[Code of Conduct](.github/CODE_OF_CONDUCT.md)

<br>
<center> 

[![Developed with ❤️ by slashwhy](https://img.shields.io/badge/Developed_with_❤️-by_slashwhy-EA425B?labelColor=fff)](https://slashwhy.de/en/)

</center>
