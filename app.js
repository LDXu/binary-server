const Koa = require('koa')
const router = require('./server/routes')
const logger = require('koa-logger')
const mongoose = require('mongoose')
const koaBody = require('koa-body')

const app = new Koa

const mongoDBHost =
  process.env.BUILD_ENV === 'docker'
    ? 'mongodb://database/binary_database'
    : 'mongodb://localhost/binary_database';

mongoose.connect(mongoDBHost, {useNewUrlParser: true, useUnifiedTopology: true})

app.use(koaBody({ multipart: true }))
app.use(logger())
app.use(router.routes())
app.listen(8080)