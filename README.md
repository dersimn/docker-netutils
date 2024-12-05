# Usage

Interactive:

	docker run -it --rm --network=MYNETWORK dersimn/netutils

Command:

    docker run     --rm --network=MYNETWORK dersimn/netutils ping 8.8.8.8


# Test new packages

    PLATFORMS="linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/riscv64,linux/s390x"
    PACKAGE_NAME="foo"
    
    for i in ${PLATFORMS//,/ }; do echo "$i"; docker run --rm --platform "$i" alpine sh -c "apk add $PACKAGE_NAME"; done

    for i in ${PLATFORMS//,/ }; do echo "$i"; docker run --rm --platform "$i" ubuntu bash -c "apt-get update && apt-get install -y $PACKAGE_NAME"; done


# Build

## build

Without buildx, the variable `TARGETARCH` must be (manually) specified:

    docker build \
        -t netutils \
        -f Dockerfile-ubuntu \
        --build-arg TARGETARCH=amd64 \
        .

## buildx

    docker buildx create --name mybuilder
    docker buildx use mybuilder

    docker buildx build \
        -f Dockerfile-ubuntu \
        --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/riscv64,linux/s390x \
        -t dersimn/netutils \
        -t dersimn/netutils:ubuntu \
        --push \
        .

    docker buildx build \
        -f Dockerfile-alpine \
        --platform linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/riscv64,linux/s390x \
        -t dersimn/netutils:alpine \
        --push \
        .

## GitHub

Create two secrets:

    gh secret set PERSONAL_ACCESS_TOKEN --body '<TOKEN>' --app dependabot
    gh secret set DOCKERHUB_TOKEN --body '<TOKEN>'

`PERSONAL_ACCESS_TOKEN` needs only scope `repo` (Classic Token)
