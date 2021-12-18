const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const session = require("express-session");
const hbs = require('hbs');
const flash = require('connect-flash');
const passport = require('./auth/passport');
const app = express();

// require Router
const indexRouter = require('./routes/index');
const productRouter = require('./components/product');

// view engine setup
app.set('views', [
  path.join(__dirname, 'views'),
  path.join(__dirname, 'components')
]);
app.set('view engine', 'hbs');

hbs.registerPartials(__dirname + '/views/partials', function (err) { });
// load helpers
const { helpers } = require('./views/hbsHelpers');
helpers(hbs);

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: true,
  cookie: {
    maxAge: 1000 * 60 * 60 * 24,
  }
}));

app.use(flash());
app.use(passport.initialize());
app.use(passport.session());

//Get user from req
app.use((req, res, next) => {
  res.locals.user = req.user;
  next();
})

//Route
app.use('/', indexRouter);
app.use('/product', productRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
