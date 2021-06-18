// module.exports = [
//    {
//       "type": "postgres",
//       "host": "db",
//       "port": 5432,
//       "username": process.env.DB_USER,
//       "password": process.env.DB_PASSWORD,
//       "database": "edugo",
//       "synchronize": true,
//       "logging": false,
//       "entities": [
//          "src/database/entity/**/*.ts"
//       ],
//       "migrations": [
//          "src/database/migration/**/*.ts"
//       ],
//       "subscribers": [
//          "src/database/subscriber/**/*.ts"
//       ],
//       "cli": {
//          "entitiesDir": "src/database/entity",
//          "migrationsDir": "src/database/migration",
//          "subscribersDir": "src/database/subscriber"
//       }
//    },
//    {
//       "name": "test",
//       "type": "sqljs",
//       "database": new Uint8Array(),
//       "location": "database",
//       "logging": false,
//       "synchronize": true,
//       "entities": ["src/database/entity/**/*.ts"]
//    }
// ]