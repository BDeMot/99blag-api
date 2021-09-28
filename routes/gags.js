const express = require('express')
const router = express.Router()

const gagsCtrl = require('../controllers/gags')
const multer = require('../middleware/multer-config')
const edit_auth = require('../middleware/edit_auth.js')

router.post('/', multer, gagsCtrl.createGag)
router.get('/', gagsCtrl.getGags)
router.get('/:id', gagsCtrl.getOneGag)
router.delete('/:id', edit_auth, gagsCtrl.deleteGag)

module.exports = router