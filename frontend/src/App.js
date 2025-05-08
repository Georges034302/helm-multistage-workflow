import React, { useEffect, useState } from 'react';

function App() {
  const [employees, setEmployees] = useState([]);

  useEffect(() => {
    fetch(process.env.REACT_APP_API_URL)
      .then(res => res.json())
      .then(data => setEmployees(data))
      .catch(console.error);
  }, []);

  return (
    <div>
      <h1>Employee Directory</h1>
      <ul>
        {employees.map((emp, idx) => (
          <li key={idx}>
            {emp.name} – {emp.role} – {emp.department}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
