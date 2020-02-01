#!/bin/bash

#nc -v -n -l -p8085
## Listen
nc -n -l 8085

## Connect
nc domain.com 8085

