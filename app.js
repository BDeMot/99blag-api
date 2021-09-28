const express = require('express')
const path = require('path')
const helmet = require('helmet')
const limits = require('limits')
var cors = require('cors')

const gagsRoute = require('./routes/gags')
const commentsRoute = require('./routes/comments')
const usersRoute = require('./routes/users')
const likesRoute = require('./routes/likes')

const app = express()

require('dotenv').config()

const limits_config = {
  enable: true,
  file_uploads: true,
  post_max_size: 500000,
  global_timeout: 500 
}
// app.use(limits(limits_config))

app.use(cors())

app.use(helmet())
app.use(helmet({ crossOriginEmbedderPolicy: true }))
app.use(helmet({ crossOriginOpenerPolicy: true }))
app.use(helmet({ crossOriginResourcePolicy: { policy: "same-site" } }))

app.use(( req, res, next ) => {
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE')
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With, Origin, Content, Accept, Content-Type, Authorization')
  res.header("X-powered-by", "My little fingers")
  next()
})

app.use(express.urlencoded({extended: true}))
app.use(express.json())

app.use('/images', express.static(path.join(__dirname, 'images')))
app.use('/api/gags', gagsRoute)
app.use('/api/gags/:id/comments', commentsRoute )
app.use('/api/users', usersRoute)
app.use('/api/gags/:id/likes', likesRoute)

module.exports = app