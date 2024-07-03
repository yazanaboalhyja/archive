const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const mysql = require('mysql');
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
function verifyAdmin(req, res, next) {
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

router.get('/dashboard', verifyAdmin, (req, res) => {
    const counts = {};
  
    const queries = [
      { key: 'total_prisoners', query: 'SELECT COUNT(*) as count FROM prisoners' },
      { key: 'total_martyrs', query: 'SELECT COUNT(*) as count FROM martyrs' },
      { key: 'total_users', query: 'SELECT COUNT(*) as count FROM users' },
      { key: 'total_news', query: 'SELECT COUNT(*) as count FROM news' },
      { key: 'total_videos', query: 'SELECT COUNT(*) as count FROM videos' },
      { key: 'total_villages', query: 'SELECT COUNT(*) as count FROM palestinian_villages' },
      { key: 'verified_accounts', query: 'SELECT COUNT(*) as count FROM users WHERE verified = "yes"' },
      { key: 'unverified_accounts', query: 'SELECT COUNT(*) as count FROM users WHERE verified = "no"' },
    ];
  
    let completedQueries = 0;
  
    queries.forEach(({ key, query }) => {
      db.query(query, (err, results) => {
        if (err) {
          console.error('Database error:', err);
          return res.status(500).json({ message: 'Internal server error' });
        }
  
        counts[key] = results[0].count;
        completedQueries += 1;
  
        if (completedQueries === queries.length) {
          res.status(200).json(counts);
        }
      });
    });
  });

module.exports = router;
