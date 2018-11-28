#!/bin/bash

set -eu
# set -x

# Registry file to keep track of search_term <--> image
LINK_FILE="/usr/local/etc/dr.db"

# Define a weird set of char that doesn't have 
# to appear in search term nor in registry image name
LINK_SEP=":::::"

# Docker Registry HTTP url
DOCKER_REGISTRY_URL="https://registry.hub.docker.com/v1/repositories"

# Our echo function to log things
function _echo() {
	echo -e "\033[00;34m[dr] ${1}\033[0m"
}

# Parse arguments
s_term="$1"
s_image="$(awk -F'@' '{print $1}' <<< "${s_term}")"
s_tag="$(awk -F'@' '{print $2}' <<< "${s_term}")"

# Touch reg file
touch ${LINK_FILE}

# Search in local registry
image=$(cat ${LINK_FILE} | grep "${s_term}${LINK_SEP}" | head -n 1)

if [ ! -z "${image}" ]; then
	# If we found an image in local registry, use it
	_echo "Found link in local registry for '${s_term}'"
	image="$(awk -F${LINK_SEP} '{print $2}' <<< "${image}")"

else
	_echo "Searching for '${s_image}' in Docker Hub..."
	# Otherwise search in Docker Hub
	remote_image=$(docker search "${s_image}" --limit 1 --no-trunc --format "{{.Name}}")

	if [ ! -z "${remote_image}" ]; then
		_echo "Found '${remote_image}' in Docker Hub!"
	
		# If we found that image into the Docker hub, search for preferred tag
		if [ ! -z "${s_tag}" ]; then
			image_tag=$(curl -s "${DOCKER_REGISTRY_URL}/${s_image}/tags" | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}' | grep -w "${s_tag}" | head -n 1)

			if [ -z "${image_tag}" ]; then
				_echo "Unable to find version '${s_tag}' of '${remote_image}', using latest tag!"
				image_tag="latest"
			else
				_echo "Found '${image_tag}' version in Docker Hub!"
			fi
		else
			image_tag="latest"
			_echo "Using latest version"
		fi

		image="${remote_image}:${image_tag}"

		_echo "Linking search term '${1}' to '${image}' in local registry..."
		echo "${1}${LINK_SEP}${image}" >> ${LINK_FILE}
	fi
fi

if [ -z "${image}" ]; then
	_echo "Unable to find an image that match your criteria"
	exit 1
fi

_echo "Docker Image used: ${image}"
docker run -it --rm "${image}" ${@:2}