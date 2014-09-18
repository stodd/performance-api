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

router = express.Router()

router.use (req, res, next) ->
  console.log "INFO %s %s %s", req.method, req.path, req.body
  #TODO: Record metrics here.
  #TODO: Pull up user via api key and sign request and validate signatures to see if they match.
  #TODO: If the match pass user as auth in next.
  next()



router.get '/', (req, res) ->
  res.render 'index'


router.route '/performance'

  .post (req,res) ->
    performance = new Performance
    performance.name = req.body.name
    performance.user = req.body.user
    performance.video_ref = req.body.video_ref
    performance.instruments = req.body.instruments.split /[\s,]+/
    performance.save (err) ->
      if err
        res.send(err)
      res.json performance.toJSON virtuals: true

  .get (req,res) ->
    Performance.find {}, (err, performances) ->
      if err
        res.send err
      res.json performances.map (performance) -> performance.toJSON virtuals: true #expose virtuals for each item.


router.route '/performance/:id'

  .get (req,res) ->
    Performance.findById req.params.id, (err, performance) ->
      if err
        res.send err
      res.json performance.toJSON virtuals: true

  .put (req, res) ->
    performance = Performance.findOne _id: req.params.id

    performance.name = req.body.name
    performance.description = req.body.description
    performance.instruments = req.body.instruments.split /[\s,]+/
    performance.video_ref = req.body.video_ref

    performance.save (err, updated) ->
      res.json updated.toJSON virtuals: true

  .delete (req,res) ->
    Performance.remove _id: req.params.id, (err) ->
        if err
          res.send err
        res.json msg: 'Successfully deleted'


router.route '/performance/:id/rate'

  .put (req, res) ->
    #If we had api keys to support auth then we would check if the user was rating his own performance.
    max_rating = (x) -> if x > 5 then 5 else x
    console.log "INFO RATING: supplied is %s new is %s", req.body.rating, max_rating(req.body.rating)
    Performance.update {_id: req.params.id}, {$inc: {rating_sum: max_rating(req.body.rating), rating_count: 1}}, {multi: true}, (err, updated) ->
        if err
          res.send err
        Performance.findById req.params.id, (err, performance) ->
          res.json performance.toJSON virtuals: true


router.route '/performance/:id/comments'

  .post (req, res) ->
    comment = req.body
    console.log "INFO COMMENT: %s", comment
    Performance.findOne _id: req.params.id, (err, performance) ->
      performance.comments.addToSet comment
      performance.save (err, updated) ->
        if err
          res.send err
        res.json updated.toJSON virtuals: true

app.use '/api', router
app.listen 3000
