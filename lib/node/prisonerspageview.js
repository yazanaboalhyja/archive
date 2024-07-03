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

// Route to get prisoners by views
router.get('/prisoners', (req, res) => {
  const SELECT_PRISONERS_QUERY = `SELECT m.*, u.name AS submitted_by_name   FROM prisoners m JOIN users u ON m.submitted_by = u.id  ORDER BY views  DESC LIMIT 9`;

  db.query(SELECT_PRISONERS_QUERY, (err, results) => {
    if (err) {
      console.error('Error retrieving prisoners:', err);
      res.status(500).json({ message: 'Error retrieving prisoners' });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: 'No prisoners found' });
      return;
    }

    // Modify photo_url to include the full path
    const prisonersWithFullPhotoUrl = results.map(prisoner => ({
      ...prisoner,
      photo_url: prisoner.photo_url ? `${req.protocol}://${req.get('host')}/uploads/${prisoner.photo_url}` : null
    }));

    res.status(200).json({ prisoners: prisonersWithFullPhotoUrl });
  });
});

// Route to search prisoners by name
router.get('/search_prisoners', (req, res) => {
  const name = req.query.name;
  if (!name) {
    return res.status(400).json({ message: 'Name query parameter is required' });
  }

  const SELECT_PRISONERS_BY_NAME_QUERY = `SELECT m.*, u.name AS submitted_by_name   FROM prisoners m JOIN users u ON m.submitted_by = u.id WHERE m.name LIKE ? ORDER BY views  DESC LIMIT 9`;

  db.query(SELECT_PRISONERS_BY_NAME_QUERY, [`%${name}%`], (err, results) => {
    if (err) {
      console.error('Error retrieving prisoners:', err);
      res.status(500).json({ message: 'Error retrieving prisoners' });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: 'No prisoners found' });
      return;
    }

    // Modify photo_url to include the full path
    const prisonersWithFullPhotoUrl = results.map(prisoner => ({
      ...prisoner,
      photo_url: prisoner.photo_url ? `${req.protocol}://${req.get('host')}/uploads/${prisoner.photo_url}` : null
    }));

    res.status(200).json({ prisoners: prisonersWithFullPhotoUrl });
  });
});


module.exports = router;
