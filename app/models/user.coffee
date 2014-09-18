mongoose = require 'mongoose'
Schema = mongoose.Schema

user_schema = new Schema
  username:
    type: String
    require: true
  display: String
  key: String
  secret:
    type: String
    select: false


module.exports = mongoose.model 'User', user_schema