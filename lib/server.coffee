express = require 'express'
fibrous = require 'fibrous'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'
logger = require('log4js').getLogger('server')

class BankServer

  constructor: (config)->

    @app = express()
    @setUpMiddlewares()

    models = @models = @setUpModels config.mongo

    @app.post '/token', (req, res) ->

      fibrous.run ->
        ## TODO: verify req and respond an auth_code
        {client_id, client_secret, amount, transaction_id} = req.body

        client = models.clients.sync.findOne {
          _id: client_id
          secret: client_secret
        }


        throw {
          code: 404
          message: 'invalid client'
        } unless client

        auth = new models.auth_codes {
          client: client._id
          amount
          transaction_id
        }

        auth.sync.save()

        res.json {
          auth_code: auth._id
        }

      , (err)->
        return unless err
        res.status err.code or 500
        res.json err or {message: 'unknown error'}


    @app.get '/dialog', (req, res)->
      ## verify the auth_code and render the card input form

    @app.use (err, req, res, next)->
      logger.warn 'Error', err
      res.status err.code or 500
      res.send err.message or 'unknown error'


  setUpMiddlewares: ->
    @app.use bodyParser()

  setUpModels: (connectionStr)->
    modelNames = ['auth_codes', 'cards', 'clients', 'transactions']
    connection = mongoose.connect connectionStr
    models = {}
    try
      models[name] = require('./model/' + name)(connection) for name in modelNames
    catch ex
      logger.warn 'error while bootstraping models', ex

    return models


  start: (opts)->
    port = opts.port or process.env.PORT or 3000
    @http = @app.listen port
    logger.info 'server started on port %s', port

  stop: ->
    return unless @http
    @http.close()
    delete @http

module.exports = BankServer