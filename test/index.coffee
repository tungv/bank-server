should = require 'should'
fibrous = require 'fibrous'
request = require 'request'

BankServer = require '../lib/server'
URL = 'http://localhost:3001'

server = new BankServer {
  mongo: 'localhost/bank-test'
}

## setup data
Client = server.models.clients
Card = server.models.cards

shop = new Client {
  _id: '5492a8075bab5410f85f3864'
  secret: 'shop_secret'
}

card = new Card {
  card_number: '4242424242424242'
  cvc: '444'
  expire_date: new Date(2016,11,11)
}


## helpers
params = {
  post: (url, opts, cb)->
    opts.url = URL + url
    request.post opts, cb
}

before fibrous ->
  Client.sync.remove()
  Card.sync.remove()

  shop.sync.save()
  card.sync.save()


before fibrous ->
  server.start {
    port: 3001
  }

describe 'get token', ->
  require('./token') params
