# Rails Authentication API example

Prepared for Lendesk  

## Getting started

```
bundle
rails db:migrate
```

## Testing  

```
rails test
```

## Requirements  
Using a combination of Ruby on Rails and Redis for data storage, we need an authentication API for internal services to create and authenticate users. This API should be RESTful and use JSON. It should be fast and secure, and be able to pass a basic security audit (e.g. password complexity). If there are areas of security that your solution hasn't had time to address they should be annotated for future development.

The API should be able to create a new login with a username and password, ensuring that usernames are unique. It should also be able to authenticate this login at a separate end point. It should respond with 200 OK messages for correct requests, and 401 for failing authentication requests. It should do proper error checking, with error responses in a JSON response body.

## Technologies and Frameworks Used
Ruby on Rails 6.0 API Only version  
Redis - for jwt token blacklisting  
JSON Web Token - for API tokens  
Postgres - for persistant User storage  
Minitest - For testing  
Interacter - For Service Objects  
