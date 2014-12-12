#! /bin/bash

# exercise the query state functions

${CURL} -f -s -S -X POST \
     -H "Content-Type: application/sparql-query" \
     -H "Accept: application/sparql-results+json" \
     --data-binary @- \
     -u "${STORE_TOKEN}:" \
     "${SPARQL_URL}" <<EOF \
 | jq '.results.bindings[] | .[].value' | fgrep -q 'true'
prefix xsd: <http://www.w3.org/2001/XMLSchema-datatypes>

select ((( xsd:gYearMonth('1976-02-05:00') = '1976-02-05:00'^^xsd:gYearMonth) &&
         ( xsd:gYearMonth('1976-02Z') = '1976-02Z'^^xsd:gYearMonth) &&
         ( xsd:gYearMonth('1976-02Z') != '1976-02'^^xsd:gYearMonth) &&
         ( xsd:gYearMonth('1976-02+12:00') = '1976-02+12:00'^^xsd:gYearMonth) &&

         ( xsd:gYearMonth('1976-02-12:00') != '1976-02+12:00'^^xsd:gYearMonth) &&
         ( xsd:gYearMonth('1976-02-10:00') != '1976-02Z'^^xsd:gYearMonth) &&

         # no order, but also not incommendurable
         (! ( xsd:gYearMonth('1975-02') <   xsd:gYearMonth('1976-02') )) &&
         (! ( xsd:gYearMonth('1976-02') <   xsd:gYearMonth('1975-02') )) &&
         (! ( xsd:gYearMonth('1975-02') <=   xsd:gYearMonth('1976-02') )) &&
         (! ( xsd:gYearMonth('1976-02') <=   xsd:gYearMonth('1975-02') )))
       as ?ok)
where {
 }

EOF
