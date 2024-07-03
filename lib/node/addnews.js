const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const multer = require('multer');
const path = require('path');
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

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

router.use(bodyParser.json());

// Middleware to verify token
function verifyToken(req, res, next) {
  const token = req.headers['authorization'];
  console.log("token : "+token);

  if (!token) {
    return res.status(401).json({ message: 'Unauthorized' });
  }

  jwt.verify(token, 'katkot', (err, decoded) => {
    if (err) {
      return res.status(403).json({ message: 'Forbidden' });
    }
    req.userId = decoded.userId;
    console.log("userid = " +decoded.userId);
    next();
  });
}

router.post('/add_news', verifyToken, upload.single('photo'), (req, res) => {
  const { name, description, source, type} = req.body;
  const photo = req.file.filename;
  const submitted_by = req.userId; // Get the user ID from the token
  const INSERT_MARTYRS_QUERY = `INSERT INTO review_news ( name, description, source, type, photo_url ,submitted_by) VALUES (?, ?, ?, ?, ?, ?)`;
  db.query(INSERT_MARTYRS_QUERY, [name, description, source, type, photo, submitted_by], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    return res.status(200).json({ message: 'news added to review' });
  });
});

module.exports = router;