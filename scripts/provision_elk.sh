#!/usr/bin/env bash

# Configure Virtual Memory on Elasticsearch
# ref:https://www.elastic.co/guide/en/elasticsearch/reference/5.0/vm-max-map-count.html#vm-max-map-count
sudo sysctl -w vm.max_map_count=262144

# ref: https://elk-docker.readthedocs.io/
sudo docker pull sebp/elk
# Need to forwarding-port after deployed container elk
sudo docker run -p 5601:5601 -p 9200:9200 -p 5044:5044 -it --name elk sebp/elk