mongoose = require 'mongoose'
Schema = mongoose.Schema

user_schema = new Schema
  username: mongoose.ObjectId
  display: String
  key: String
  secret: String


module.exports = mongoose.model 'User', user_schema