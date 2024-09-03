#!/bin/bash

i=0

for file in "./tests"/*; do
       
        ./tema "$file" > "${i}.md"
        ((i++))

done
