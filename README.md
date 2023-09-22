# Automotive Data Transformer Support
The automotive data transformer is a cloud-native measurement data processor for data engineers and cloud developers that allows them to convert MDF files with easy API requests even without several years of experience in automotive calibration. It is fast, reliable, secure. Unlock the potential of your MDF files by processing them with our new cloud-based microservice. 

Website: http://automotive-data-transformer.com

## How to get access to ADT?

Contact Tim Sibold tim.sibold@de.bosch.com if you have interest in ADT and would like to get access for a free trial. 

## What are prerequisites for using ADT?

* You have registered and recieved a CustomerID, ExtrenalID, ClientID and your Login Credebtials
* You have created a Cross-Account Role to grant ADT access to your S3 bucket

      
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

### Create Cross-Account Role to grant ADT Access to your S3 Bucket

1. Download a CloudFormation Template for the cross-account role.
2. Create a new CloudFormation Stack:
   ![image](https://github.com/bosch-engineering/automotive_data_transformer_support/assets/91074947/15dde2e8-b4bf-45d6-a2dc-cdc533db700d)

3.![image](https://github.com/bosch-engineering/automotive_data_transformer_support/assets/91074947/558bb8c2-687a-4c69-8e5f-6101a3369c7d)

4. Build the stack. User created Cross-Account Role in your requests to ADT.

## Postman Collection

You can find examples of possible requests here: https://documenter.getpostman.com/view/10945379/2s9XxztC6V#intro

## Troubleshooting

* If you get Error 407 (Error: tunneling socket could not be established, statusCode=407), check your proxy settings.
* If you get "Unauthorized" error, make sure that your Token is valid. IdToken is valid 24 hours only!
* If you get "Internal Server Error", double check attributes in your request. If everything looks correct, contact our support team by sending an Email to Tim Sibold tim.sibold@de.bosch.com.




