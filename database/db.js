const mysql = require('mysql')

const connection = mysql.createPool({
  host: 'db4free.net',
  user: 'benjamindm',
  password: '1SymphoniE1!',
  database: 'ninetynineblag'
})

module.exports = connection