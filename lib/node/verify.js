const express = require('express');
const router = express.Router();
const mysql = require('mysql');
const jwt = require('jsonwebtoken');

// Set up database connection
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

// Route to handle email verification
router.get('/verify/:token', (req, res) => {
  const token = req.params.token;

  // Verify the token
  jwt.verify(token, 'katkot', (err, decoded) => {
    if (err) {
      return res.status(400).send(`
        <html>
          <body>
            <p>Invalid or expired token.</p>
          </body>
        </html>
      `);
    }

    const username = decoded.username;

    // Update the database to mark the email as verified
    db.query('UPDATE users SET verified = ? WHERE username = ?', ['yes', username], (err, result) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).send(`
          <html>
            <body>
              <p>Internal server error.</p>
            </body>
          </html>
        `);
      }

      if (result.affectedRows === 0) {
        return res.status(400).send(`
          <html>
            <body>
              <p>User not found.</p>
            </body>
          </html>
        `);
      }

      // Send HTML response that closes the window
      res.status(200).send(`
        <html>
          <body>
            <p>Email verified successfully.</p>
            <script>
              setTimeout(function() {
                window.close();
              }, 1000);
            </script>
          </body>
        </html>
      `);
    });
  });
});

module.exports = router;
