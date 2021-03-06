#! /bin/bash

# verify the accept order is observed such that the result is json

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     ${STORE_URL}/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}?'query=select%20count(*)%20where%20%7b?s%20?p%20?o%7d&'auth_token=${STORE_TOKEN} \
   | json_reformat -m \
   | egrep -q -s '"bindings".*"COUNT1".*"value":"1"'


curl -f -s -X GET\
     -H 'Accept: application/sparql-results+xml;q=0.5,application/sparql-results+json,*/*;q=0.9' \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}?'query=select%20count(*)%20where%20%7b?s%20?p%20?o%7d&'auth_token=${STORE_TOKEN} \
   | json_reformat -m \
   | egrep -q -s '"bindings".*"COUNT1".*"value":"1"'

curl -f -s -X GET\
     -H 'Accept: application/sparql-results+json,application/sparql-results+xml,*/*;q=0.9' \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}?'query=select%20count(*)%20where%20%7b?s%20?p%20?o%7d&'auth_token=${STORE_TOKEN} \
   | json_reformat -m \
   | egrep -q -s '"bindings".*"COUNT1".*"value":"1"'
