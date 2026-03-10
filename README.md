# TASK A
* Implementation => Please refer to the code.
* DB User => SQL, justified in Task B.
* Concurrency => Using pesimistic locking to prevent race conditions.

# TASK B
1. Handling millions of records:
* Indexing => I would add compound indexes to make searching faster (ex: [:doctor_id, :start_time, :end_time] for checking availability and [:patient_id, :start_time, :end_time] for showing patient history).
* Pagination => I would implement cursor-based pagination since offset is slow in large datasets. This kind of pagination also suit this case because commonly the appointments list should display latest result first (user dont need information older than current day).
* Query Optimization => I would use .select() to choose necessary fields, and avoid N+1 by using .includes(:doctor, :patient).

2. I believe, mongoDB is not suitable. My reasoning:
* We need solid integrity & consistency (in DB-level).
* We need strict rules about double booking (locking).
* We need relational data model without various data types.

# Task C
User Flow (assuming user is authenticated):
1. Select doctors & available slot (client-side prevention to overlapping appointments).
2. User press 'Confirm' -> Button will be disabled (client-side preventation to double submission).
4. Send POST /appointments request.
5. Fetch result -> If success, show success message. If error, show error message.

Psuedo-code
 ```javascript
  async function confirmAppointment() {
    const button = document.getElementById('btn-confirm');
    button.disabled = true;
    button.innerText = 'Please Wait...';
  
    try {
     const response = await fetch('/appointments', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ... }) 
     });
     if (!response.ok) throw await response.json();
     alert('Appointment Confirmed!');
    } catch (error) {
      const message = error.errors ? error.errors.join(', ') : 'Something went wrong';
      alert(message);
    }
  }
```

# Task D
1. Investigating unreproducible production errors.
* Check errbit (or other error tracking tools) / exception notification mail.
* If no tools available, I would access application logs on the server.
* Filtering the logs by timeframe, and find request ID (copy it to local, then analyze).
* Trace each transaction while also give eyes to DB process time.
2. Logging & Monitoring.
* Logging => Differentiate between business logic errors (warn) and system errors (fatal).
* Monitoring => Setup alert for indicators such as high error rate, slow transaction, and slow query.
3. Investigation & Mitigation.
* Investigation => Check APM data and identify the bottleneck.
* Mitigation => Immediately: add missing indexes or scale resource. Long Term: Implement caching, set background process for non-blocking operations, code / query optimization.

# Task E
1. Add authentication via session/JWT, then authorize. Patient_id should be obtained from current_user.id, not given params.
2. Never commit credential (.env, keys, etc) to repository, that should only exist on development environment. In production, use centralized secret management like Vault or Infisical, then inject it as environmental variables.
3. Yes, absolutely. We need to prevent DoS and bots from filling or scanning all available appointment slots.

# Task F
1. For this task, no. In office, I rarely use AI because I need to maintain my coding sharpness. It's also limited due to company regulation and confidentiality. In my freelance / side project, yes, especially when I want to focus on the 'business' aspects or eliminating 'dirty works'.
2. I believe this kind of task can be easily solved using AI-generated code. However, for this kind of task, there is something that we should not rely solely on AI. My lists:
* Business flow part such as the making appointment validation (and finding what suits best).
* Contain lot of 'secret' such as API request that has a chance of security leak.
* When we have our own standardization such as for the request and response.
* Authorization, since it need human as the rule-maker.
