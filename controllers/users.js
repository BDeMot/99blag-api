const pool = require('../database/db')
const bcrypt = require('bcrypt')
const { v4: uuidv4 } = require('uuid');
const jwt = require('jsonwebtoken')

const regexAlphanum = /[A-Za-z0-9]/g
const regexEmail = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/

exports.addUser = (req, res, next) => {

  if(req.body.password.length < 7 || !regexAlphanum.test(req.body.pseudo) || !regexEmail.test(req.body.email)) {
    res.status(422).json({ error : 'invalid input format' })
  } else {
    const hash = bcrypt.hashSync(req.body.password, 10)
    const uuid = uuidv4();
    const user = [
      uuid,
      req.body.pseudo,
      req.body.email,
      hash
    ]

    pool.query('INSERT INTO users SET id = ?, user = ?, email = ?, password = ?',
    user,
    function(error, results, fields) {
      if (error) {
        res.status(403).json({ message : error.sqlMessage })
      }
      if (results) {
        res.status(201).json({ 
          message : 'Utilisateur créé !',
          userPseudo: req.body.pseudo,
          token: jwt.sign(
            { userId: uuid },
            process.env.TOKEN_SECRET,
            { expiresIn: '12h' }
          )})
      }
    })
  }
}

exports.loginUser = (req, res, next) => {
  if (req.body.password.length < 7 || !regexEmail.test(req.body.email)) {
    res.status(422).json({ error : 'invalid input format' })
  } else {
    const email = req.body.email

    pool.query('SELECT * FROM users WHERE email= ?', 
      email, 
      function (error, results, fields) {
        if (error) {
          res.status(404).json({ message : error.sqlMessage })
        }
        if (results) {
          if (typeof results[0] === "undefined") {
            res.status(401).json({ message : "L'email ou le mot de passe sont erronés." })
            console.log("email doesn't exist on database")
          } else {
            bcrypt.compare(req.body.password, results[0].password)
            .then(valid => {
              if(!valid) {
                res.status(401).json({ message : "L'email ou le mot de passe sont erronés." })
                console.log("Password sent in request and the one stored in db doesn't match")
              } else {
                res.status(200).json({ 
                  message : 'Connexion établie !',
                  userPseudo: results[0].user,
                  privilege: results[0].privilege,
                  token: jwt.sign(
                    { userId: results[0].id },
                    process.env.TOKEN_SECRET,
                    { expiresIn: '12h' }
                  )
                })
                console.log("connection established")
              }
            })
            .catch(error => res.status(500).json({ error }))
          }
        }
        
        if(fields) {
          console.log("User querying a connexion")
        }
      }
    )
  }
}