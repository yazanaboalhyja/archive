const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const mysql = require('mysql');
const bcrypt = require('bcrypt');

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

// Sign-in route for admins
router.post('/signin_admin', (req, res) => {
  const { username, password } = req.body;

  const SELECT_USER_QUERY = 'SELECT * FROM users WHERE username = ?';

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
        const CHECK_ADMIN_QUERY = 'SELECT * FROM admins WHERE user_id = ?';

        db.query(CHECK_ADMIN_QUERY, [user.id], (err, adminResults) => {
          if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ message: 'Internal server error' });
          }

          const isAdmin = adminResults.length > 0;
          const token = jwt.sign({ userId: user.id, isAdmin }, 'AdminPage', { expiresIn: '30d' });

          res.status(200).json({
            message: 'Sign-in successful',
            token,
            username: user.username,
            name: user.name // Assuming the name field exists in the users table
          });
        });
      } else {
        return res.status(401).json({ message: 'Invalid username or password' });
      }
    });
  });
});

module.exports = router;
