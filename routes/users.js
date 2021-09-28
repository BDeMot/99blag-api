const express = require('express')
const router = express.Router()
const limiter = require('../middleware/express-limit')
const usersCtrl = require('../controllers/users')

router.post('/signup', usersCtrl.addUser)
router.post('/login', limiter, usersCtrl.loginUser)

module.exports = router