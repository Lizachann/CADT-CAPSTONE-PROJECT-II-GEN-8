const mongoose = require('mongoose');

function dropDb() {
  const url =
    'mongodb://127.0.0.1:27017/capstone-server?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.2.5';

  console.log('Connecting to db');
  const conn = mongoose.createConnection(url);

  console.log('Dropping db...');
  conn.dropDatabase().then(() => {
    console.log("Db drop successful")
    conn.close();
  });
}

dropDb();
