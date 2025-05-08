const express = require('express');
const app = express();
const port = 5000;

app.get('/api/employees', (req, res) => {
  res.json([
    { name: 'Alice', role: 'Developer', department: 'Engineering' },
    { name: 'Bob', role: 'Manager', department: 'HR' },
    { name: 'Charlie', role: 'Analyst', department: 'Finance' }
  ]);
});

app.listen(port, () => {
  console.log(`Employee API listening on port ${port}`);
});
