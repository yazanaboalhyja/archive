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

// Route to get news by views
router.get('/news', (req, res) => {
  const SELECT_NEWS_QUERY = `SELECT m.*, u.name AS submitted_by_name   FROM news m JOIN users u ON m.submitted_by = u.id WHERE m.views >= 0 ORDER BY m.views DESC LIMIT 9`;

  db.query(SELECT_NEWS_QUERY, (err, results) => {
    if (err) {
      console.error('Error retrieving news:', err);
      res.status(500).json({ message: 'Error retrieving news' });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: 'No news found' });
      return;
    }

    // Modify photo_url to include the full path
    const newsWithFullPhotoUrl = results.map(news => ({
      ...news,
      photo_url: news.photo_url ? `${req.protocol}://${req.get('host')}/uploads/${news.photo_url}` : null
    }));

    res.status(200).json({ news: newsWithFullPhotoUrl });
  });
});

// Route to search news by name
router.get('/search_news', (req, res) => {
  const name = req.query.name;
  if (!name) {
    return res.status(400).json({ message: 'Name query parameter is required' });
  }

  const SELECT_NEWS_BY_NAME_QUERY = `SELECT m.*, u.name AS submitted_by_name   FROM news m JOIN users u ON m.submitted_by = u.id WHERE m.name LIKE ? ORDER BY views DESC LIMIT 25`;
  

  db.query(SELECT_NEWS_BY_NAME_QUERY, [`%${name}%`], (err, results) => {
    if (err) {
      console.error('Error retrieving news:', err);
      res.status(500).json({ message: 'Error retrieving news' });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: 'No news found' });
      return;
    }

    const newsWithFullPhotoUrl = results.map(news => ({
      ...news,
      photo_url: news.photo_url ? `${req.protocol}://${req.get('host')}/uploads/${news.photo_url}` : null
    }));

    res.status(200).json({ news: newsWithFullPhotoUrl });
  });
});

// Route to search news by type
router.get('/search_news_by_type', (req, res) => {
  const type = req.query.type;
  if (!type) {
    return res.status(400).json({ message: 'Type query parameter is required' });
  }

  const SELECT_NEWS_BY_TYPE_QUERY = `SELECT m.*, u.name AS submitted_by_name   FROM news m JOIN users u ON m.submitted_by = u.id WHERE m.type LIKE ? ORDER BY views DESC LIMIT 25`;
  

  db.query(SELECT_NEWS_BY_TYPE_QUERY, [`%${type}%`], (err, results) => {
    if (err) {
      console.error('Error retrieving news:', err);
      res.status(500).json({ message: 'Error retrieving news' });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: 'No news found' });
      return;
    }

    const newsWithFullPhotoUrl = results.map(news => ({
      ...news,
      photo_url: news.photo_url ? `${req.protocol}://${req.get('host')}/uploads/${news.photo_url}` : null
    }));

    res.status(200).json({ news: newsWithFullPhotoUrl });
  });
});

// Route to search news by source
router.get('/search_news_by_source', (req, res) => {
  const source = req.query.source;
  if (!source) {
    return res.status(400).json({ message: 'Source query parameter is required' });
  }

  const SELECT_NEWS_BY_SOURCE_QUERY = `SELECT m.*, u.name AS submitted_by_name   FROM news m JOIN users u ON m.submitted_by = u.id WHERE m.source LIKE ? ORDER BY views DESC LIMIT 25`;

  db.query(SELECT_NEWS_BY_SOURCE_QUERY, [`%${source}%`], (err, results) => {
    if (err) {
      console.error('Error retrieving news:', err);
      res.status(500).json({ message: 'Error retrieving news' });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: 'No news found' });
      return;
    }

    const newsWithFullPhotoUrl = results.map(news => ({
      ...news,
      photo_url: news.photo_url ? `${req.protocol}://${req.get('host')}/uploads/${news.photo_url}` : null
    }));

    res.status(200).json({ news: newsWithFullPhotoUrl });
  });
});

module.exports = router;
