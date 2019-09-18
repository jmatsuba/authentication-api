# Rails Authentication API example

Prepared for Lendesk  

## Getting started

```
bundle
bundle exec rails db:setup
bundle exec rails s
```

## Testing  

```
bundle exec rails test
```

## Routes
```
GET    /items
POST   /users
POST   /sessions
DELETE /sessions
```

Create a User
```
curl -H "Content-Type: application/json" -X POST -d '{ "user": { "username": "dhh", "first_name": "David", "last_name": "Hansson", "password": "cpciU9scr9!" } }' http://localhost:3000/users
Status 201
```

Authenticate User
```
curl -H "Content-Type: application/json" -X POST -d '{ "session": { "username": "dhh", "password": "cpciU9scr9!" } }' http://localhost:3000/sessions
=> {"auth_token":"xxxxxxxx_auth_token_xxxxxxxx"}
Status 200
```

Test Route (Unauthorized)
```
curl http://localhost:3000/items
=> {"error":"Not Authorized"}
Status 401
```

Test Route (Authorized)
```
curl -H "Authorization: xxxxxxxx_auth_token_xxxxxxxx" http://localhost:3000/items
=> []
Status 200
```

Destroy Session (Blacklists API Key)
```
curl -H "Authorization: xxxxxxxx_auth_token_xxxxxxxx" -X DELETE http://localhost:3000/sessions
=> {"message":"logout successful"}
Status 200
```

## Requirements  
Using a combination of Ruby on Rails and Redis for data storage, we need an authentication API for internal services to create and authenticate users. This API should be RESTful and use JSON. It should be fast and secure, and be able to pass a basic security audit (e.g. password complexity). If there are areas of security that your solution hasn't had time to address they should be annotated for future development.

The API should be able to create a new login with a username and password, ensuring that usernames are unique. It should also be able to authenticate this login at a separate end point. It should respond with 200 OK messages for correct requests, and 401 for failing authentication requests. It should do proper error checking, with error responses in a JSON response body.

## Overall Approach
Given the requirements the API only version of rails felt like the obvious choice. Decided on the using the latest version 6.0.0, which is production ready as both Shopify and Github have been using it in production for some time already. Given the requirements the choice was made to use redis for some sort of session management and postgres as a persistant data store. This decision was made as for users there would be many advantages of using a relational database and many disadvanatges of using a store like Redis. After some brainstorming, resaerch and testing in a sandbox the decision was made to use JWT tokens, and redis as a way to track blacklisted tokens.  

## Performance
The average time for a authorized a request on my dev machine was around 40ms to the first call and closer to 10ms for subsequent calls. The slowest endpoint is the login and the create user endpoints. This is mostly due to BCrypt, which takes up the majority of the time. 

## Performance vs Security
The new default is to use a BCrypt cost factor of 12. If we were to lower it to 11 we could reduce the hashing time by roughly 50% and if we were to lower the cost factor to 10, the default used by `bcrypt-ruby` about 1 year ago and most likely used in most stateless authentication architecture, we could reduce the hashing time by 75%.   

If we were to switch to using a cost factor of 10 we could probably (did not have time to confirm) achieve sub 100ms performance on the login and create user routes. See [bcrypt-ruby on cost factors](https://github.com/codahale/bcrypt-ruby#cost-factors). 

Ultimaetly this is something that would need to be considered when looking at purpose and security risk of the API.

## Password Complexity
I made the decision to use a regex and custom rails validations to staisfy this requirement. The regex can be modified as needed. Based on reearch a more secure way would be to use a gem, like [strong password](https://github.com/bdmac/strong_password) that tries to comply with more complex NIST requirements. However, it would have taken more work to use it as the UX was poor around validation messaging and the requirements ask for a basic secuirty audit.  

## Technologies and Frameworks Used
Ruby on Rails 6.0 API Only version  
Redis - for jwt token blacklisting  
JSON Web Token - for API tokens  
Postgres - for persistant User storage  
Minitest - For testing  
Interacter - For Service Objects  

## Assumptions
It is assumed the challenge is asking for a custom implementation of Redis as a data store, not implementing basic Redis caching. If this was the challenge I would happily re-write it based on this requirement, and would start with this [guide on Redis caching](https://guides.rubyonrails.org/caching_with_rails.html#activesupport-cache-rediscachestore).  

## TODO
Integration test to tie together creating a user, logging in, and testing the items endpoint  
Change root rails route to something not Welcome to Rails
