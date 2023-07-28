const express = require('express');
const body_parser = require('body-parser');

const userRouter = require('./routers/user.router');
const weightRouter = require('./routers/weight.router');

const app = express();
app.use(body_parser.json());
app.use('/',userRouter);
app.use('/',weightRouter);

module.exports = app;