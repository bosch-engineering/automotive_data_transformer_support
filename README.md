# automotive_data_transformer_support
Documentation/Getting Started/Support for the Automotive Data Transformer

## How to get access to ADT?

Contact Tim Sibold tim.sibold@de.bosch.com if you have interest in ADT and would like to get access for a free trial. You will recieve a welcome Email with you credentials and other necessary info.
      
## What to do once you got your credentials?

### Generate Access Token and ID Token:

You will need an Access Token in order to change your password. You will need an ID Token for authenticating you requests in ADT.

Create file auth.json with the following content (or find a temaplte in this repository):

```
{"AuthParameters" : {"USERNAME" : "<your-email>", "PASSWORD" : "<password>"}, "AuthFlow" : "USER_PASSWORD_AUTH", "ClientId" : "<client-id>"}
```

Run the following command in the location for the file:
```sh
curl -X POST --data @auth.json \                                  
-H 'X-Amz-Target: AWSCognitoIdentityProviderService.InitiateAuth' \
-H 'Content-Type: application/x-amz-json-1.1' \
https://cognito-idp.eu-central-1.amazonaws.com/
```

Client ID is sent to you in your welcome Email, together with your initial password. As a result you get the following output:
```json
{
  "AuthenticationResult": {
    "AccessToken": "YourAccesTokeneyJraWQiOiJsT2NEb0V6ZWpOdThlZ1wva1NUNXZSWUNBSG5lO",
    "ExpiresIn": 86400,
    "IdToken": "YourIdTokeneyJraWQiOiJqRkh5b05MeWpxakVxWWJUUnlicStVYkF",
    "RefreshToken": "YourRefreshTokeneyJjdHkiOiJKV1QiLCJlbmMiOiJ",
    "TokenType": "Bearer"
  },
  "ChallengeParameters": {}
}
```
### Change your passowrd


Create a file named change-password.json (you can find template in this repository) with the following content:

```
{ "AccessToken": "string", "PreviousPassword": "string", "ProposedPassword": "string" }
```

Run the following command in the location of the newly created file:

```sh
curl -X POST --data @change_password.json \
-H 'X-Amz-Target: AWSCognitoIdentityProviderService.ChangePassword' \
-H 'Content-Type: application/x-amz-json-1.1' \
https://cognito-idp.eu-central-1.amazonaws.com/
```

After the password is changed you need to generate a new ID Token again as the old one is invalid.


