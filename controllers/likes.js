const pool = require('../database/db')
const jwt = require('jsonwebtoken')

exports.setLikes = (req, res, next) => {
  const decodedToken = jwt.verify(req.body[0], process.env.TOKEN_SECRET)
  const user = decodedToken.userId
  const gag = req.body[1]
  const likeType = req.body[2]
  const sql = `INSERT INTO like_dislike (user_id_fk, gag_id_fk, likeType) 
  VALUES ('${user}', ${gag}, ${likeType}) 
  ON DUPLICATE KEY UPDATE likeType = ${likeType}`

  pool.query(sql,
    function(error, results, fields) {
      if (error){
        res.status(400).json({ error })
      }
      if (results) {
        likesCounter(gag)
        res.status(201).json({ results })
      }
      if (fields) {
        console.log("Likes prit en compte")
      }
    }
    )
  }

exports.likeOrDislike = (req, res, next) => {
  const decodedToken = jwt.verify(req.query.user, process.env.TOKEN_SECRET)
  const likeOrDislike = [
    decodedToken.userId,
    req.query.gag
  ]

  pool.query('SELECT likeType FROM like_dislike WHERE user_id_fk = ? AND gag_id_fk = ?',
  likeOrDislike,
  function(error, results, fields) {
    if (error){
      res.status(404).json({ error })
    }
    if (results) {
      res.status(200).json({ results })
    }
  }
  )
}

exports.deleteLike = (req, res, next) => {
  const decodedToken = jwt.verify(req.query.user, process.env.TOKEN_SECRET)
  const likeOrDislike = [
    decodedToken.userId,
    req.query.gag
  ]
  pool.query('DELETE FROM like_dislike WHERE user_id_fk = ? AND gag_id_fk = ?',
  likeOrDislike,
  function(error, results, fields) {
    if (error){
      res.status(404).json({ error })
    }
    if (results) {
      likesCounter(Number(req.query.gag))
      res.status(200).json({ results })
    }
  }
  )
}

function likesCounter(onGag) {
  pool.query('SELECT likeType FROM like_dislike WHERE gag_id_fk = ?', 
  onGag, 
  function(error, results, fields) {
      if(results){
        const getNbOfLikes = results.filter(like => like.likeType === 1)
        const getNbOfDislikes = results.filter(like => like.likeType === -1)
        const nbOfLikes = [ getNbOfLikes.length, getNbOfDislikes.length, onGag]

        pool.query('UPDATE gags SET likes = ?, dislikes = ? WHERE id = ?', 
          nbOfLikes,
          function(error, results, fields) {
            if(error){
              console.log(error)
            }
            if(results){
              console.log("likes and dislikes updated!")
            }
              }
            )
          }
        }
      )
}