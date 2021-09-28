const limiter = require('express-limit').limit

module.exports = 
	limiter({
        max: 5,
        period: 60 * 1000
    }), 
	(req, res, next) => {
	next()
}

