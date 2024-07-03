const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const mysql = require('mysql');
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');
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

const transporter = nodemailer.createTransport({
  service: 'hotmail',
  auth: {
    user: 'palestinearchive@hotmail.com',
    pass: 'xwpkxdkcxdtehjcv'
  }
});

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

function sendEmail(to, subject, text) {
  const mailOptions = {
    from: 'palestinearchive@hotmail.com',
    to: to,
    subject: subject,
    text: text
  };

  transporter.sendMail(mailOptions, (err, info) => {
    if (err) {
      console.error('Error sending email:', err);
    } else {
      console.log('Email sent:', info.response);
    }
  });
}

function getUserEmailById(userId) {
  return new Promise((resolve, reject) => {
    const query = 'SELECT username FROM users WHERE id = ?';
    db.query(query, [userId], (err, results) => {
      if (err) {
        return reject(err);
      }
      if (results.length === 0) {
        return reject(new Error('User not found'));
      }
      resolve(results[0].username);
    });
  });
}

function getColumns(tableName) {
  return new Promise((resolve, reject) => {
    const query = `SHOW COLUMNS FROM ${tableName}`;
    db.query(query, (err, results) => {
      if (err) {
        return reject(err);
      }
      const columns = results.map(column => column.Field).join(', ');
      resolve(columns);
    });
  });
}

function constructPhotoUrl(req, filename) {
  if (!filename) return null;
  return `${req.protocol}://${req.get('host')}/uploads/${filename}`;
}

router.post('/accept', verifyAdmin, async (req, res) => {
  const { table, id, userId } = req.body;
  let mainTable;
  let insertQuery;

  switch (table) {
    case 'review_prisoners':
      mainTable = 'prisoners';
      insertQuery = `INSERT INTO prisoners ( name, date_of_birth, date_of_arrest, place_of_birth, life_story, views, photo_url, submitted_by, created_at) SELECT  name, date_of_birth, date_of_arrest, place_of_birth, life_story, views, photo_url, submitted_by, NOW() FROM review_prisoners WHERE id = ?`;
      break;
    case 'review_martyrs':
      mainTable = 'martyrs';
      insertQuery = `INSERT INTO martyrs ( full_name, date_of_birth, date_of_death, description, image_url, submitted_by, cause_of_death, nationality, place_of_death, created_at) SELECT  name, date_of_birth, date_of_death, description, photo_url, submitted_by, cause_of_death, nationality, place_of_death, NOW() FROM review_martyrs WHERE id = ?`;
      break;
    case 'review_news':
      mainTable = 'news';
      insertQuery = `INSERT INTO news ( name, description, photo_url, submitted_by, created_at) SELECT  name, description, photo_url, submitted_by, NOW() FROM review_news WHERE id = ?`;
      break;
    case 'review_videos':
      mainTable = 'videos';
      insertQuery = `INSERT INTO videos ( description, location ,video_path, submitted_by, created_at) SELECT  description,location, video_path, submitted_by, NOW() FROM review_videos WHERE id = ?`;
      break;
    case 'review_palestinian_villages':
      mainTable = 'palestinian_villages';
      insertQuery = `INSERT INTO palestinian_villages ( village_name, city, historical_context, current_status,image_url,submitted_by, created_at) SELECT  village_name, city, historical_context,current_status,image_url, submitted_by, NOW() FROM review_palestinian_villages WHERE id = ?`;
      break;
    default:
      return res.status(400).json({ message: 'Invalid table name' });
  }

  const deleteQuery = `DELETE FROM ${table} WHERE id = ?`;

  try {
    db.query(insertQuery, [id], (err) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({ message: 'Internal server error' });
      }

      db.query(deleteQuery, [id], async (err) => {
        if (err) {
          console.error('Database error:', err);
          return res.status(500).json({ message: 'Internal server error' });
        }

        try {
          const email = await getUserEmailById(userId);
          sendEmail(email, 'Post Accepted', `Your post has been accepted, you can see the post at your profile page`);
          res.status(200).json({ message: 'Post accepted and moved to the main table' });
        } catch (err) {
          console.error('Error fetching user email:', err);
          res.status(500).json({ message: 'Internal server error' });
        }
      });
    });
  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
});

// Route to decline a post
router.post('/decline', verifyAdmin, (req, res) => {
  const { table, id, userId } = req.body;
  const deleteQuery = `DELETE FROM ${table} WHERE id = ?`;

  db.query(deleteQuery, [id], async (err) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }

    try {
      const email = await getUserEmailById(userId);
      sendEmail(email, 'Post Declined', `Your post has been declined and removed`);
      res.status(200).json({ message: 'Post declined and removed from the review table' });
    } catch (err) {
      console.error('Error fetching user email:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
  });
});

module.exports = router;
