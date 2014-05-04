#! /bin/bash

# test as json, that the the account configuration

${CURL} -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/configuration?auth_token=${STORE_TOKEN} \
  | json_reformat -m \
  | fgrep '"value":"urn:dydra:baseIRI"'\
  | fgrep -q "${STORE_ACCOUNT}"


