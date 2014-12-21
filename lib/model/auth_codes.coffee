module.exports = (connection)->

  schema = connection.Schema {
    transaction_id: String
    amount: Number
    client: String
  }

  connection.model 'auth_code', schema