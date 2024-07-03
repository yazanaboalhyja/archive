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
router.get('/villages', (req, res) => {
  const SELECT_villages_QUERY = `SELECT m.*, u.name AS submitted_by_name   FROM palestinian_villages m JOIN users u ON m.submitted_by = u.id WHERE m.views >= 0 ORDER BY views DESC LIMIT 9`;
  db.query(SELECT_villages_QUERY, (err, results) => {
    if (err) {
      console.error('Error retrieving villages:', err);
      res.status(500).json({ message: 'Error retrieving villages' });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: 'No villages found' });
      return;
    }

    // Modify image_url to include the full path
    const villagesWithFullImageUrl = results.map(villages => ({
      ...villages,
      image_url: villages.image_url ? `${req.protocol}://${req.get('host')}/uploads/${villages.image_url}` : null
    }));

    res.status(200).json({ villages: villagesWithFullImageUrl });
  });
});

// Route to search martyrs by name
router.get('/search_villages', (req, res) => {
  const name = req.query.name;
  if (!name) {
    return res.status(400).json({ message: 'Name query parameter is required' });
  }

  const SELECT_villages_BY_NAME_QUERY = `SELECT m.*, u.name AS submitted_by_name   FROM palestinian_villages m JOIN users u ON m.submitted_by = u.id WHERE m.village_name LIKE ? ORDER BY views DESC LIMIT 9`;

  db.query(SELECT_villages_BY_NAME_QUERY, [`%${name}%`], (err, results) => {
    if (err) {
      console.error('Error retrieving villages:', err);
      res.status(500).json({ message: 'Error retrieving villages' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ message: 'No villages found' });
      return;
    }

    // Modify image_url to include the full path
    const villagesWithFullImageUrl = results.map(martyr => ({
      ...martyr,
      image_url: martyr.image_url ? `${req.protocol}://${req.get('host')}/uploads/${martyr.image_url}` : null
    }));

    res.status(200).json({ villages: villagesWithFullImageUrl });
  });
});


module.exports = router;
