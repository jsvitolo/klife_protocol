#!/bin/bash

docker-compose -f ./test/compose_files/docker-compose-kafka-latest.yml up --force-recreate --remove-orphans