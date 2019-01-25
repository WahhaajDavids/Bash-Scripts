#!/usr/bin/env bash

### declare an array variable
#declare -a arr=("element1" "element2" "element3")
#
### now loop through the above array
#for i in {0..2}
#do
#   echo "${arr[${i}]}"
#   # or do whatever with individual element of the array
#done
#

declare -a cdDIR=(
'/home/wahhaaj/Projects/khula/khula-b2b-library'
'/home/wahhaaj/Projects/khula/khula-mq-client-library'
'/home/wahhaaj/Projects/khula/customer-relationship-management-project'
'/home/wahhaaj/Projects/khula/khula-monolith'
)

for i in {0..2}; do
    echo "${cdDIR[${i}]}"
	cd "${cdDIR[${i}]}" && { mvn clean install -DskipTests=true; }
done

cd "${cdDIR[3]}" && { mvn clean install -DskipTests=true -P build_for_linux,autodeploy; }

