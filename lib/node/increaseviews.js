const express = require('express');
const router = express.Router();
const mysql = require('mysql');

// Database connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'archive'
});

// Connect to database
db.connect((err) => {
  if (err) {
    console.error('Database connection error:', err);
    return;
  }
});

// Function to update views
const updateViews = (tableName, id, res) => {
  const SELECT_QUERY = `SELECT * FROM ${tableName} WHERE id = ?`;
  const UPDATE_QUERY = `UPDATE ${tableName} SET views = views + 1 WHERE id = ?`;

  db.query(SELECT_QUERY, [id], (err, results) => {
    if (err) {
      console.error(`Error retrieving from ${tableName}:`, err);
      res.status(500).json({ message: `Error retrieving from ${tableName}` });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: `${tableName.slice(0, -1)} not found` });
      return;
    }

    db.query(UPDATE_QUERY, [id], (err) => {
      if (err) {
        console.error(`Error updating views in ${tableName}:`, err);
        res.status(500).json({ message: `Error updating views in ${tableName}` });
        return;
      }

      res.status(200).json({ message: `${tableName.slice(0, -1)} views updated`, item: results[0] });
    });
  });
};

// Routes for updating views
router.get('/videos/:id', (req, res) => updateViews('videos', req.params.id, res));
router.get('/news/:id', (req, res) => updateViews('news', req.params.id, res));
router.get('/prisoners/:id', (req, res) => updateViews('prisoners', req.params.id, res));
router.get('/martyrs/:id', (req, res) => updateViews('martyrs', req.params.id, res));
router.get('/villages/:id', (req, res) => updateViews('palestinian_villages', req.params.id, res));

module.exports = router;
