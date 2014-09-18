express = require 'express'
mongoose = require 'mongoose'
body_parser = require 'body-parser'

app = express()

mongoose.connect 'mongodb://localhost:27017/performance'
Performance = require './app/models/performance'

app.use body_parser.json()
app.use body_parser.urlencoded {extended: true}

app.set 'views', __dirname + '/app/views'
app.set 'view engine', 'jade'

#TODO: define middleware to validate request signatures with api key and secret and then fetch user.

router = express.Router()

router.get '/', (req, res) ->
  res.render 'index'

router.route '/performance'
  .post (req,res) ->
    perf = new Performance
    perf.name = req.body.name
    perf.save (err) ->
      if err
        res.send(err)
      res.json perf
  .get (req,res) ->
    res.json "TODO Get list"

router.route '/performance/:id'
  .get (req,res) ->
    Performance.findById req.params.id, (err, performance) ->
      if err
        res.send err
      res.json performance
  .put (req, res) ->
    res.json "TODO Update single"
  .delete (req,res) ->
    Performance.remove _id: req.params.id, (err, performance) ->
        if err
          res.send err
        res.json msg: 'Successfully deleted'

router.route '/performance/:id/rate'
  .put (req, res) ->
    res.json "TODO update the rating atomically"

router.route '/performance/:id/comments'
  .post (req, res) ->
    res.json "TODO push a new comment."




app.use '/api', router
app.listen 3000
