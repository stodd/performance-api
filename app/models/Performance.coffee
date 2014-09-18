mongoose = require 'mongoose'
Schema = mongoose.Schema

performance_schema = new Schema
  name:
    type: String
    required: true
  description: String
  video_ref:
    type: String
    required: true
    unique: true
  instruments: [ String ]
  user:
    type: String
    required: true
  rating_count:
    type: Number
    default: 0
  rating_sum:
    type: Number
    default: 0
  create_dt:
    type: Date
    required: true
    default: Date.now()
  comments: [
    user:
      type: String
      required: true
    body:
      type: String
      required: true
    created_dt:
      type: Date
      required: true
      default: Date.now()
  ]

performance_schema.virtual 'avgRating'
  .get ->
    @rating_sum / @rating_count

module.exports = mongoose.model 'Performance', performance_schema