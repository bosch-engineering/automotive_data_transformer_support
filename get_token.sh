#!/bin/bash

# This file needs to be executed next to the auth.json file

# Send the POST request and capture the response
response=$(curl -s -X POST --data @auth.json \
  -H 'X-Amz-Target: AWSCognitoIdentityProviderService.InitiateAuth' \
  -H 'Content-Type: application/x-amz-json-1.1' \
  https://cognito-idp.eu-central-1.amazonaws.com/)

# Extract the IdToken from the JSON response
id_token=$(echo $response | grep -o '"IdToken":"[^"]*' | cut -d'"' -f4)

# Print the IdToken
echo $id_token