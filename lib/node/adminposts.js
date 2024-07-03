const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const mysql = require('mysql');
const jwt = require('jsonwebtoken');
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
  console.log('Connected to database');
});

router.use(bodyParser.json());

// Serve static files from the "uploads" directory
router.use('/uploads', express.static(path.join(__dirname, 'uploads')));

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

function getColumnsFromTable(tableName) {
  return new Promise((resolve, reject) => {
    const query = `SELECT * FROM ${tableName}`;
    db.query(query, (err, results) => {
      if (err) {
        return reject(err);
      }
      resolve(results);
    });
  });
}

function constructPhotoUrl(req, filename) {
  if (!filename) return null;
  return `${req.protocol}://${req.get('host')}/uploads/${filename}`;
}

router.get('/review_prisoners', verifyAdmin, async (req, res) => {
  try {
    const results = await getColumnsFromTable('review_prisoners');
    results.forEach(result => {
      result.photo_url = constructPhotoUrl(req, result.photo_url);
    });
    res.status(200).json(results);
  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
});

router.get('/review_martyrs', verifyAdmin, async (req, res) => {
  try {
    const results = await getColumnsFromTable('review_martyrs');
    results.forEach(result => {
      result.photo_url = constructPhotoUrl(req, result.photo_url);
    });
    res.status(200).json(results);
  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
});

router.get('/review_news', verifyAdmin, async (req, res) => {
  try {
    const results = await getColumnsFromTable('review_news');
    results.forEach(result => {
      result.photo_url = constructPhotoUrl(req, result.photo_url);
    });
    res.status(200).json(results);
  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
});

router.get('/review_videos', verifyAdmin, async (req, res) => {
  try {
    const results = await getColumnsFromTable('review_videos');
    results.forEach(result => {
      result.video_path = constructPhotoUrl(req, result.video_path);
    });
    res.status(200).json(results);
  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
});

router.get('/review_villages', verifyAdmin, async (req, res) => {
  try {
    const results = await getColumnsFromTable('review_palestinian_villages');
    results.forEach(result => {
      result.image_url = constructPhotoUrl(req, result.image_url);
    });
    res.status(200).json(results);
  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
});

// Route to get all data
router.get('/review_all', verifyAdmin, async (req, res) => {
  try {
    const tables = [
      'review_prisoners',
      'review_martyrs',
      'review_news',
      'review_videos',
      'review_palestinian_villages'
    ];

    const results = await Promise.all(tables.map(table => getColumnsFromTable(table)));
    const response = {
      review_prisoners: results[0].map(result => ({ ...result, photo_url: constructPhotoUrl(req, result.photo_url) })),
      review_martyrs: results[1].map(result => ({ ...result, photo_url: constructPhotoUrl(req, result.photo_url) })),
      review_news: results[2].map(result => ({ ...result, photo_url: constructPhotoUrl(req, result.photo_url) })),
      review_videos: results[3].map(result => ({ ...result, video_path: constructPhotoUrl(req, result.video_path) })),
      review_villages: results[4].map(result => ({ ...result, image_url: constructPhotoUrl(req, result.image_url) }))
    };

    res.status(200).json(response);
  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
});

module.exports = router;
