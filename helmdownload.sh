#!/bin/bash

format_docker_url() {
    echo ${1//\"/}
}

declare -A all_images

xx=`helm template testdryrun . --dry-run |grep "image:" |awk '{print $2}'`

for x in $xx 
do 
    # echo x is $x
    b=$(format_docker_url $x)
    all_images[$b]=1
done

for key in ${!all_images[@]};do
    docker pull $key
    # echo "in key " $key
done

# echo ${!all_images[@]}
docker save -o xx.tar ${!all_images[@]}
