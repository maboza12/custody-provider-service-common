# Wallet Provider Service
Using our Spec-First approach we will be developing the spec to generate different pieces of our project (including our models and controllers). These specs follow the OpenAPI 3.0 standards outlined by the OpenAPI initative:
https://www.openapis.org/

## Functions
Create Vault Accounts
Create Wallet Accounts
Create Transaction

## Spec Structure

The spec is divided in multiple folders and is referenced by the main spec, `openapi-v1.0.yaml`.

Below is the folder structure:
```shell
.
├── parameters
├── resources
├── responses
├── schemas
└── openapi-v1.0.yaml
```
**Parameters:** Models the parameters and queries entered into the endpoint. 

**Resources:** Details on the endpoints. 

**Responses:** References the schemas for the responses given by the service. 

**Schemas:** Models the data that will be used in responses and requests. 

## Adding a New Service Request
Go to the `./openapi/openapi-v1.0.yaml` spec and add the new endpoint under paths. 

### Adding the New Endpoint
For instance, if you wanted to add an endpoint `/person` it would look like the following in the `openapi-v1.0`:

```aidl
paths:
  /person:
    $ref: "resources/person.yaml"
    
  /pets:
    $ref: "resources/pets.yaml"
```

### Adding the Resource for the Endpoint
The person endpoint points to a `person.yaml` file under the `./openapi/resource` directory. Go into the resource directory and create a `person.yaml` file.
The resource person yaml will look like the following, it's a GET request that returns the person schema (`./openapi/schema/Person.yaml`) if it's successful, and an unexpected error response (`./openapi/responses/UnexpectedError.yaml`) if it's unsuccessful. 
```aidl
get:
  summary: Detail
  operationId: showPerson
  description: Info for a specific person
  tags:
    - person
  responses:
    '200':
      description: Expected response to a valid request
      content:
        application/json:
          schema:
            $ref: "../schemas/Person.yaml"
    default:
      $ref: "../responses/UnexpectedError.yaml"

```

### Adding the Schema for the Resource
```aidl
type: object
required:
  - id
  - name
  - age
properties:
  id:
    type: integer
    format: int64
  name:
    type: string
  age:
    type: int64
```

After adding all these additional pieces, the new GET endpoint, `/person` is included in the spec. 

## Linting OpenAPI Spec
This linting tool ensures that the Spec is clean and follows best practices. Refer to the documentation for further details:
https://sherwoodforest.atlassian.net/wiki/spaces/ARC/pages/2754773412/API+Style+Guide

From the root directory run:
```shell
./gradlew spectral
```

## Mock Data for API
To mock data you will need to install Prism (https://stoplight.io/open-source/prism) locally.

To install it locally you will need to run the following command:
```aidl
npm install -g @stoplight/prism-cli

# OR

yarn global add @stoplight/prism-cli
```
Once it's installed you can run the following gradle command from the root directory to produce mock data off the spec:

```shell
./gradlew mockServiceData
```

## Validate Mock Results with Actual Results
Checks that the results generated from the spec mocker match up with the application code

- The code must be generated and built to validate this

