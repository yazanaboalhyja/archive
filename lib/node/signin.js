const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const mysql = require('mysql');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'archive'
});

db.connect((err) => {
  if (err) {
    throw err;
  }
});

router.use(bodyParser.json());

router.post('/signin', (req, res) => {
  const { username, password } = req.body;
  const SELECT_USER_QUERY = `SELECT * FROM users WHERE username = ?`;
  db.query(SELECT_USER_QUERY, [username], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    if (results.length === 0) {
      return res.status(401).json({ message: 'Invalid username or password' });
    }

    const user = results[0];
    const hashedPassword = user.password;

      bcrypt.compare(password, hashedPassword, (err, result) => {
        if (err) {
          console.error('Bcrypt error:', err);
          return res.status(500).json({ message: 'Internal server error' });
        }
        if (result) {
          const token = jwt.sign({ userId: user.id }, 'katkot', { expiresIn: '30d' });
          const emailVerified = user.verified == 'yes';
          return res.status(200).json({
            message: 'Sign-in successful',
            emailVerified,
            token,
            username: user.username,
            name: user.name
          });
        } else {
          return res.status(401).json({ message: 'Invalid username or password' });
        }
      });
  });
});

router.get('/user/:id', (req, res) => {
  const userId = req.params.id;

  const SELECT_USER_QUERY = 'SELECT name FROM users WHERE id = ?';

  db.query(SELECT_USER_QUERY, [userId], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: 'User not found' });
    }

    const userName = results[0].name;
    return res.status(200).json({ name: userName });
  });
});

module.exports = router;
