fibrous = require 'fibrous'


module.exports = (params)->
  post = params.post


  it 'should send back a token if id/secret is matching', fibrous ->
    res = post.sync '/token', {
      json:
        client_id: '5492a8075bab5410f85f3864'
        client_secret: 'shop_secret'
        amount: 1000
        transaction_id: 'transaction_0001'
    }


    res.statusCode.should.equal 200
    res.body.auth_code.should.be.a.string

  it 'should send an 404 error if id/secret is not matching', fibrous ->
    res = post.sync '/token', {
      json:
        client_id: '5492a8075bab5410f85f3864'
        client_secret: 'fake'
        amount: 1000
        transaction_id: 'transaction_0001'
    }

    res.statusCode.should.equal 404
    res.body.message.should.be.a.string
