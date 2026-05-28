# Customer Service Operations
This dataset was created by Claude.ai. It captures one year of customer support ticket activity across a mid-sized Kenyan retail and e-commerce company. It logs 1,000 service interactions from January to December 2024, spanning seven regional branches, including Nairobi, Mombasa, Kisumu, and Nakuru. 

Each record represents a single customer ticket handled by one of ten support agents across five contact channels, namely: phone, email, live chat, social media, and in-person visits. 

The data covers a range of issue types from billing disputes and refund requests to technical support and product defects. It includes operational metrics such as resolution time and number of customer interactions, alongside a customer satisfaction score (CSAT) collected post-resolution. Ticket statuses reflect the full lifecycle of a support case, from open and pending through to resolved, escalated, or reopened. 

## Project Workflow
### 1. Dataset Columns
1. ticket_id - Unique ticket identifier (TKT-0001 … TKT-1000) 
2. created_date - Date the ticket was raised (2024) 
3. channel - Phone, Email, Live Chat, Social Media, In-Person 
4. issue_type - Billing, Technical Support, Shipping, Refund, etc. 
5. agent_name - Assigned support agent 
6. status - Resolved, Pending, Escalated, Closed, Reopened 
7. region - Kenyan city/region of the customer 
8. csat_score - Customer satisfaction 1–5 (some NULLs) 
9. resolution_time_mins - Minutes to resolve (NULL for unresolved tickets) 
10. num_interactions - Number of back-and-forth contacts on the ticket 

### 2. Key Questions
#### Q1 — New column: Satisfaction Label
Customers have given raw CSAT scores (1–5). Stakeholders want a readable label instead. Write a query that creates a satisfaction_category column: 
scores of 1–2 = 'Detractor'
3 = 'Neutral'
4–5 = 'Promoter'
NULL scores = 'No Response'

#### Q2 — New column: Resolution Speed Band
The ops team wants to tier tickets by how quickly they were resolved.  Create a speed_band column: 
under 30 mins = 'Quick Fix', 
30–120 mins = 'Standard'
121–480 mins = 'Slow'
above 480 mins = 'Breach'
NULL = 'Unresolved'

#### Q3 — Stakeholder report: Channel Performance Flag
Leadership suspects some channels generate harder-to-resolve tickets. 
Write a query that flags each ticket as:
 'High Effort' if num_interactions >= 7
'Medium Effort' if between 4 and 6, and 
'Low Effort' for 3 or fewer 
— then aggregate to show the count per channel per effort level.

#### Q4 — New column: Escalation Risk Score
The QA team wants to proactively identify risky tickets still in progress. Create a risk_flag column that returns:
'High Risk' if the ticket is Pending or Reopened AND has a low CSAT score (≤ 2)
'Medium Risk' if status is Escalated
'Low Risk' if resolved with CSAT ≥ 4
'Review' for everything else.

#### Q5 — Stakeholder report: Agent Performance Tier
For each agent, calculate their average CSAT and average resolution time
Then use a CASE statement to assign a tier: 
'Top Performer' (avg CSAT ≥ 4 AND avg resolution ≤ 120 mins)
'Needs Coaching' (avg CSAT < 3 OR avg resolution > 360 mins)
'On Track' for everyone else.

### 3. Summary
I requested this dataset as a hands-on learning resource for practicing CASE statements in SQL. Rather than working with abstract or generic examples, I wanted a realistic, domain-specific dataset that would mirror the kind of data I might encounter in a professional setting — in this case, a customer service operations context.
The goal was to move beyond simple syntax drills and work with data that actually demands conditional logic. Customer service data is a natural fit for this because it contains a mix of categorical columns (like status, channel, and issue type), numeric metrics (like CSAT scores and resolution times), and missing values — all of which are ideal for writing meaningful CASE expressions.














