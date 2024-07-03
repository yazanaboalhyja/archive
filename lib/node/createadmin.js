const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const jwt = require('jsonwebtoken');
const router = express.Router();
// MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'archive'
});

db.connect(err => {
  if (err) {
    console.error('Database connection error:', err);
    return;
  }
 
});

router.use(bodyParser.json());

// Middleware to verify JWT token
function verifyToken(req, res, next) {
    const token = req.headers['authorization'];
  
    if (!token) {
      return res.status(401).json({ message: 'Unauthorized' });
    }
  
    jwt.verify(token, 'AdminPage', (err, decoded) => {
      if (err) {
        return res.status(403).json({ message: 'Forbidden' });
      }
  
      if (!decoded.isAdmin) {
        return res.status(403).json({ message: 'Forbidden: Admins only' });
      }
  
      req.userId = decoded.userId;
      next();
    });
  }

// Route to add user to admin table
router.post('/addAdmin', verifyToken, (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ message: 'Bad Request: No email provided' });
  }

  // Get the user ID from the users table
  const getUserQuery = 'SELECT id FROM users WHERE username = ?';
  db.query(getUserQuery, [email], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: 'User not found' });
    }

    const userId = results[0].id;

    // Insert user ID into admin table
    const insertAdminQuery = 'INSERT INTO admins (user_id) VALUES (?)';
    db.query(insertAdminQuery, [userId], (err) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({ message: 'Internal server error' });
      }

      res.status(200).json({ message: 'User added to admin table successfully' });
    });
  });
});
router.post('/delete-admin', verifyToken, (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ message: 'Email is required' });
  }

  const getUserIdQuery = 'SELECT id FROM users WHERE username = ?';
  const deleteAdminQuery = 'DELETE FROM admins WHERE user_id = ?';

  db.query(getUserIdQuery, [email], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: 'User not found' });
    }

    const userId = results[0].id;

    db.query(deleteAdminQuery, [userId], (err, results) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({ message: 'Internal server error' });
      }

      if (results.affectedRows === 0) {
        return res.status(404).json({ message: 'Admin not found' });
      }

      res.status(200).json({ message: 'Admin deleted successfully' });
    });
  });
});


module.exports = router;