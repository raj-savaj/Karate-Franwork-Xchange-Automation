Feature: Work with redis

Background: Connected to redis
* def redisHandler = Java.type("helpers.RedisHandler")

Scenario: Retrive Route Rule from Redis
    * def route = redisHandler.getRedisData("edge.core.sms.routes-data")