# TASK A
* Answered inside project => (created) migration, model, controller, routes

# TASK B
* a. When records are millions
* 1. Indexing: i would add compound index to make searching faster ([:doctor_id, :start_time, :end_time] and [:patient_id, :start_time, :end_time]).
* 2. Pagination: i would implement cursor pagination since offset is slow in large datasets. it also suit this case because commonly the appointments list should display latest result first (user dont need information older than current day).
* 3. Query Optimization: i would use .select() to choose necessary fields, and avoid N+1 by using .includes(:doctor, :patient).
* b. IMO, mongoDB is not suitable since we need solid integrity & consistency (in DB-level) and strict rules about double booking (locking). also, we dont need various data type here.

# Task C
* a. Flow (assuming user is logged in):
* 1. Select doctors
  2. Select available date
  3. Confirm -> button will be disabled (prevent double submission)
  4. Send POST /appointments
  5. Fetch result -> if 200 {show success message} | if error {show error message}
* b. Psuedo-code
 ```javascript
  async function confirmAppointment() {
    const button = document.getElementById('btn-confirm');
    button.disabled = true;
    button.innerText = 'Please Wait...';
  
    try {
      const response = await fetch('/appointments', { ... });
      if (!response.ok) throw await response.json();
      alert('Success!');
    } catch (error) {
      alert(error.errors.join(', '));
      button.disabled = false;
    }
  }
```
