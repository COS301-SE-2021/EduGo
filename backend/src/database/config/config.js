module.exports = {
  "development": {
    "username": process.env.DB_USER,
    "password": process.env.DB_PASSWORD,
    "database": "edugo",
    "host": "db",
    "dialect": "postgres"
  },
  "test": {
    "username": process.env.DB_USER,
    "password": process.env.DB_PASSWORD,
    "database": "edugo",
    "host": "db",
    "dialect": "postgres"
  },
  "production": {
    "username": process.env.DB_USER,
    "password": process.env.DB_PASSWORD,
    "database": "edugo",
    "host": "db",
    "dialect": "postgres"
  }
}
