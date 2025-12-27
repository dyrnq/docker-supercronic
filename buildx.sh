#!/usr/bin/env bash
set -Eeo pipefail

base_image="${base_image:-}"
version="${version:-v0.2.41}";
push="${push:-false}"
repo="${repo:-dyrnq}"
image_name="${image_name:-supercronic}"
platforms="${platforms:-linux/amd64,linux/arm64/v8}"
curl_opts="${curl_opts:-}"
docker_file=${docker_file:-./Dockerfile}
while [ $# -gt 0 ]; do
    case "$1" in
        --docker-file)
            docker_file="$2"
            shift
            ;;
        --base-image|--base)
            base_image="$2"
            shift
            ;;
        --version|--ver)
            version="$2"
            shift
            ;;
        --push)
            push="$2"
            shift
            ;;
        --curl-opts)
            curl_opts="$2"
            shift
            ;;
        --platforms)
            platforms="$2"
            shift
            ;;
        --repo)
            repo="$2"
            shift
            ;;
        --image-name|--image)
            image_name="$2"
            shift
            ;;
        --*)
            echo "Illegal option $1"
            ;;
    esac
    shift $(( $# > 0 ? 1 : 0 ))
done


latest_tag=" --tag $repo/$image_name:$version"

latest=$(cat latest);

if [ "$latest" = "$version" ]; then
    latest_tag="${latest_tag} --tag $repo/$image_name:latest --tag $repo/$image_name:latest-debian --tag $repo/$image_name:latest-trixie";
fi


docker buildx build \
--platform ${platforms} \
--output "type=image,push=${push}" \
--build-arg SUPERCRONIC_VERSION=${version} \
--file ${docker_file} . \
${latest_tag}



