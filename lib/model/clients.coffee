module.exports = (connection)->

  schema = connection.Schema {
    secret: String
  }

  connection.model 'client', schema