const jwt = require('jsonwebtoken')
const connection = require('../database/db')

module.exports = (req, res, next) => {
	const decodedToken =  jwt.verify(req.query.user, process.env.TOKEN_SECRET)
  const userId = decodedToken.userId
  
  connection.query('SELECT * from users WHERE id = ?',
    userId,
    function(error, results, fields) {
      if (error){
        res.status(400).json({ error })
      }
      if (results) {
        const userQueried = results[0]
        if (userQueried.user === req.query.author || userQueried.privilege === 1) {
          next()
        } else {
          res.status(401).json({ message : 'You are not authorized to do this!' })
        }
      }
    }
  )
}

