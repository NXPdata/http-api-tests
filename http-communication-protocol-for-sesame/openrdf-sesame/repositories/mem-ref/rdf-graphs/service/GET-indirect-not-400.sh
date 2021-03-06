#! /bin/bash

# url designators _may_ have the '<>' markers

curl -w "%{http_code}\n" -f -s -X GET \
     -H "Accept: application/n-triples" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/service?graph=\<${STORE_NAMED_GRAPH}\>\&auth_token=${STORE_TOKEN} \
   | fgrep -q "${STATUS_OK}"

