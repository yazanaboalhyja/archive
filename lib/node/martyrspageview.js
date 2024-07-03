const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const path = require('path');
const router = express.Router();

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

// Middleware to parse JSON bodies
router.use(bodyParser.json());

// Serve the uploads folder as static
router.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Route to get martyrs by views
router.get('/martyrs', (req, res) => {
  const SELECT_MARTYRS_QUERY = `SELECT m.*, u.name AS submitted_by_name  FROM martyrs m JOIN users u ON m.submitted_by = u.id WHERE m.views >= 0 ORDER BY m.views DESC LIMIT 9`;

  db.query(SELECT_MARTYRS_QUERY, (err, results) => {
    if (err) {
      console.error('Error retrieving martyrs:', err);
      res.status(500).json({ message: 'Error retrieving martyrs' });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: 'No martyrs found' });
      return;
    }

    // Modify image_url to include the full path
    const martyrsWithFullImageUrl = results.map(martyr => ({
      ...martyr,
      image_url: martyr.image_url ? `${req.protocol}://${req.get('host')}/uploads/${martyr.image_url}` : null
    }));

    res.status(200).json({ martyrs: martyrsWithFullImageUrl });
  });
});

// Route to search martyrs by name
router.get('/search_martyrs', (req, res) => {
  const name = req.query.name;
  if (!name) {
    return res.status(400).json({ message: 'Name query parameter is required' });
  }

  const SELECT_MARTYRS_BY_NAME_QUERY = `SELECT m.*, u.username  FROM martyrs m JOIN users u ON m.submitted_by = u.id WHERE m.full_name LIKE ? ORDER BY m.views DESC LIMIT 9`;

  db.query(SELECT_MARTYRS_BY_NAME_QUERY, [`%${name}%`], (err, results) => {
    if (err) {
      console.error('Error retrieving martyrs:', err);
      res.status(500).json({ message: 'Error retrieving martyrs' });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: 'No martyrs found' });
      return;
    }

    // Modify image_url to include the full path
    const martyrsWithFullImageUrl = results.map(martyr => ({
      ...martyr,
      image_url: martyr.image_url ? `${req.protocol}://${req.get('host')}/uploads/${martyr.image_url}` : null
    }));

    res.status(200).json({ martyrs: martyrsWithFullImageUrl });
  });
});


module.exports = router;
