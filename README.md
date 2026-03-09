# TASK A
* Answered inside project => (created) migration, model, controller, routes
* Im using SQL (justified in task B)

# TASK B
* a. When records are millions
1. Indexing: i would add compound index to make searching faster ([:doctor_id, :start_time, :end_time] and [:patient_id, :start_time, :end_time]).
2. Pagination: i would implement cursor pagination since offset is slow in large datasets. it also suit this case because commonly the appointments list should display latest result first (user dont need information older than current day).
3. Query Optimization: i would use .select() to choose necessary fields, and avoid N+1 by using .includes(:doctor, :patient).
* b. IMO, mongoDB is not suitable since we need solid integrity & consistency (in DB-level) and strict rules about double booking (locking). also, we dont need various data type here.

# Task C
* a. Flow (assuming user is logged in):
1. Select doctors
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

# Task D
* a. Production only errors
1. Check errbit / exception notification mails
2. Check the log, manually, since we have no tools :)
3. Filtering the logs by timeframe, and find request ID (copy it to local, then analyze)
4. Trace each transaction and give eyes to DB process time
* b. setup log, warnings if related to business-flow errors, and critical if its system errors. then monitor it (and alerting) using NewRelic
* c. simplest investigation => check APM transaction load / accessing log to gain information about each request (db load, insert time, etc). mitigation => caching / scaling / optimizing

# Task E
* a. add authentication and authorization.
* b. never commit .env / any credentials to repo. modern approach use centralized secret management such as vault or infisical
* c. yes, we need it to prevent abuse / DoS. it's a vital feature, we don't want the real user cant make appointment because the slot is fully filled with bot / fake appointment

# Task F
* a. for this task, no. in office i rarely use AI to maintain my coding sharpness, it's also limited due to company regulation and confidentiality. in my freelance / side project, yes, especially when i want to focus on the 'business' aspects
* b. honestly, i believe this kind of task can be easily solved using AI-generated code. but, something that we should not rely solely on AI is the part of making validation, succes n error response (if we have some agreed standardization), authentication
