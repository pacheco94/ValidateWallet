const express = require('express');
const router = express.Router();
const userController = require('../controllers/userControllers');
const authenticate = require('../middlewares/authenticate');

// Routers
router.post('/addUser', userController.addUser);
router.get('/user/:id', authenticate, userController.getUserById);
router.get('/isvalid/:address', userController.isValidWallet);
router.get('/address/:address', userController.getUserByAddress);

module.exports = router;