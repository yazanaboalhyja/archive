const express = require('express');
const path = require('path');
const router = express.Router();
const bodyParser = require('body-parser');
const mysql = require('mysql');
const bcrypt = require('bcrypt');
const nodemailer = require('nodemailer');
const jwt = require('jsonwebtoken');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'archive'
});

const transporter = nodemailer.createTransport({
  service: 'hotmail',
  auth: {
    user: 'palestinearchive@hotmail.com',
    pass: 'xwpkxdkcxdtehjcv'
  }
});

db.connect((err) => {
  if (err) {
    throw err;
  }

});

router.use(bodyParser.json());
router.use(bodyParser.urlencoded({ extended: true }));


router.get('/reset-password', (req, res) => {
  res.sendFile(path.join(__dirname, 'reset-password.html'));
});

router.post('/forgot-password', (req, res) => {
  const { username } = req.body;

  db.query('SELECT * FROM users WHERE username = ?', [username], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }

    if (results.length === 0) {
      return res.status(400).json({ message: 'Username not found' });
    }

    const user = results[0];
    const token = jwt.sign({ username: user.username }, 'katkot', { expiresIn: '1h' });

    const mailOptions = {
      from: 'palestinearchive@hotmail.com',
      to: user.username,
      subject: 'Password Reset',
      html: `
        <!DOCTYPE html>
        <html>
        <head>
          <title>Password Reset</title>
          <style>
            /* Add your custom styles here */
            body {
              font-family: Arial, sans-serif;
              background-color: #f4f4f4;
              margin: 0;
              padding: 0;
            }
            .container {
              width: 100%;
              max-width: 600px;
              margin: 0 auto;
              padding: 20px;
              background-color: #fff;
              box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
              color: #333;
            }
            p {
              font-size: 16px;
              color: #555;
            }
            a.button {
              display: inline-block;
              padding: 10px 20px;
              color: #fff;
              background-color: #007BFF;
              text-decoration: none;
              border-radius: 5px;
            }
          </style>
        </head>
        <body>
          <div class="container">
            <h1>Password Reset</h1>
            <p>Click the link below to reset your password:</p>
            <a href="http://127.0.0.1:3000/reset-password?token=${token}" class="button">Reset Password</a>
          </div>
        </body>
        </html>
      `
    };

    transporter.sendMail(mailOptions, (err, info) => {
      if (err) {
        console.error('Email error:', err);
        return res.status(500).json({ message: 'Failed to send reset email' });
      }
      console.log('Email sent:', info.response);
      res.status(200).json({ message: 'Password reset email sent successfully' });
    });
  });
});

router.post('/reset-password', (req, res) => {
  const { token, password } = req.body;

  if (!password) {
    return res.status(400).json({ message: 'Password is required' });
  }

  jwt.verify(token, 'katkot', async (err, decoded) => {
    if (err) {
      return res.status(400).json({ message: 'Invalid or expired token' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    db.query('UPDATE users SET password = ? WHERE username = ?', [hashedPassword, decoded.username], (err, result) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({ message: 'Internal server error' });
      }

      if (result.affectedRows === 0) {
        return res.status(400).json({ message: 'User not found' });
      }

      res.status(200).json({ message: 'Password reset successfully' });
    });
  });
});

module.exports = router;
