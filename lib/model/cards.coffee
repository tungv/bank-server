module.exports = (connection)->

  schema = connection.Schema {
    card_number: String
    cvc: String
    expire_date: Date
  }

  connection.model 'card', schema