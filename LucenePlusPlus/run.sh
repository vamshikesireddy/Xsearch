#! /bin/bash

rm iter*

mv src/XSearchData_manu3.cpp src/XSearchData.cpp

make 

./scripts/iterate.sh
