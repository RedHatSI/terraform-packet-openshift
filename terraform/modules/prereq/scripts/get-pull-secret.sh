#!/bin/bash

export OFFLINE_ACCESS_TOKEN="eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICItNGVsY19WZE5fV3NPVVlmMkc0UXhyOEdjd0l4X0t0WFVDaXRhdExLbEx3In0.eyJqdGkiOiI2ZTU3ZDYxYi0xNzVhLTQ5NmYtOGQ4NC05NGI3ODZhMzU2ZTkiLCJleHAiOjAsIm5iZiI6MCwiaWF0IjoxNTg5MzAzOTM2LCJpc3MiOiJodHRwczovL3Nzby5yZWRoYXQuY29tL2F1dGgvcmVhbG1zL3JlZGhhdC1leHRlcm5hbCIsImF1ZCI6ImNsb3VkLXNlcnZpY2VzIiwic3ViIjoiZjo1MjhkNzZmZi1mNzA4LTQzZWQtOGNkNS1mZTE2ZjRmZTBjZTY6cmhuLXN1cHBvcnQtanJtb3JnYW4iLCJ0eXAiOiJPZmZsaW5lIiwiYXpwIjoiY2xvdWQtc2VydmljZXMiLCJub25jZSI6IjlhMzgyMjI4LWRjMzgtNDZiNy04YWJjLTVkYzRiMDY0YzRhYyIsImF1dGhfdGltZSI6MCwic2Vzc2lvbl9zdGF0ZSI6ImI1ZDc4ZTMxLTAwMzktNGRhZi1iZWRkLTNiYWI0MDgzNDVlMSIsInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJhdXRoZW50aWNhdGVkIiwicG9ydGFsX21hbmFnZV9zdWJzY3JpcHRpb25zIiwib2ZmbGluZV9hY2Nlc3MiLCJhZG1pbjpvcmc6YWxsIiwicG9ydGFsX21hbmFnZV9jYXNlcyIsInBvcnRhbF9zeXN0ZW1fbWFuYWdlbWVudCIsInBvcnRhbF9kb3dubG9hZCJdfSwicmVzb3VyY2VfYWNjZXNzIjp7fX0.UxgNbwp5iwZodG2Nw0Z9Hfz5ukooGMKv3X7UQRmA19A9DLgccbblCOHXYAlDOcCg6Gsi57XgDdpYzvApUMa3Mt8fImS9tA0rHMEOehvkU62kCs19gYUVMOJ5cZaP1SGnB6emhaQR64CmFgfND6psNz_Z02gCEkTlBVvml3RN9MGrJOxVZag_TCA3T4DjuNaTFbs7ei5zTtNk_kb8e-6E90BDuKUwD_ia5vMQ5n4zXc6xTSjNZL1m3jDgsFHFCtKZUqC6ZVphMewY4wuGYn6hv9D_gAIHA2hw-WptLr3UL_a2cbsog1W9lJCoN9pLb2lcAedTLCsEHg1dQXmPWTJ2igse9CEC5tei1AgAQJ0OX4_ZrIWGw_0UtDfbPEGMsR9DokzfDyUXUN4A4RdU0OuKnJxi7zU6n9nTc4ILMUXDeAiM7arFIY7acQHhlGB5j6GXVCA9KhScHKc9k7tu1c52Wdt4d6AvdPqlijsGCXDVsbn6S9roowFibMgM3tcE2vtlp_aOhbJFCATLFVFP_jOZvlU1_s0CucG9RVQL5yXCxVOzJhyFdbly-AAOBs4B5-1uoJvCoYP2rTWRVtttoOC9lCns7Q0OFpw4xHSHtsxJiu2D0Ki0QAtu6n5JHRXZdkFr6dZXyLMDVi1MGxwGlBPm-Q_-bpgr6GiXVf6V87i_96Q"


export BEARER=$(curl \
--silent \
--data-urlencode "grant_type=refresh_token" \
--data-urlencode "client_id=cloud-services" \
--data-urlencode "refresh_token=${OFFLINE_ACCESS_TOKEN}" \
https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token | \
jq -r .access_token)

export PULLSECRET=$(curl --silent -X POST https://api.openshift.com/api/accounts_mgmt/v1/access_token --header "Content-Type:application/json" --header "Authorization: Bearer $BEARER")

## Combine template outside of terraform:
##{ cat install-config.yaml.backup ; echo "pullSecret: '${PULLSECRET}'" ; }

echo "${PULLSECRET}"

