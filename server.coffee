BankServer = require './lib/server'
config = require 'config'


server = new BankServer config
server.start()