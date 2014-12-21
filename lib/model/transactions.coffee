module.exports = (connection)->

  schema = connection.Schema {
    client_transaction_id: String
    amount: Number
    timestamp:
      type: Date
      default: Date.now

  }

  connection.model 'transaction', schema