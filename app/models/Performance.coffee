mongoose = require 'mongoose'
Schema = mongoose.Schema

performance_schema = new Schema
  name:
    type: String
    required: true
  video_ref:
    type: String
    required: true
  instruments: [
    type: String
    required: true
  ]
  ratings: Number
  avg_rating: Number
  comments: [
    comment:
      type: String
      required: true
  ]



module.exports = mongoose.model 'Performance', performance_schema