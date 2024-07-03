const express = require('express');
const router = express.Router();
const mysql = require('mysql');
const path = require('path');

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

router.post('/martyrs/today', (req, res) => {
  const today = new Date().toISOString().slice(0, 10);
  const SELECT_MARTYRS_QUERY = `
    SELECT id, full_name, CONCAT('/uploads/', image_url) AS photo_url
    FROM martyrs 
    WHERE DATE(date_of_death) = ?`;

  db.query(SELECT_MARTYRS_QUERY, [today], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    results.forEach((martyr) => {
      martyr.photo_url = path.join(__dirname, '..', 'uploads', martyr.photo_url);
    });
    res.json({
      count: results.length,
      martyrs: results
    });
  });
});

module.exports = router;
