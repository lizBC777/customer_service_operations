#Q1 — New column: Satisfaction Label
-- Customers have given raw CSAT scores (1–5). Stakeholders want a readable label instead. Write a query that creates a satisfaction_category column: 
-- scores of 1–2 = 'Detractor', 3 = 'Neutral', 4–5 = 'Promoter', and NULL scores = 'No Response'.
SELECT max(csat_score), min(csat_score) FROM customer_servicetkt.customer_service_tickets;
-- max = 5 and min = null
SELECT
	case
		when csat_score between 4 and 5 then 'Promoter'
        when csat_score = 3 then 'Neutral'
        when csat_score between 1 and 2 then 'Detractor'
        when csat_score is null then 'No Response'
	end as satisfaction_category,
    agent_name
FROM customer_servicetkt.customer_service_tickets;

#Q2 — New column: Resolution Speed Band
-- The ops team wants to tier tickets by how quickly they were resolved. Create a speed_band column: 
-- under 30 mins = 'Quick Fix', 30–120 mins = 'Standard', 121–480 mins = 'Slow', above 480 mins = 'Breach', and NULL = 'Unresolved'.
SELECT max(resolution_time_mins), min(resolution_time_mins) FROM customer_servicetkt.customer_service_tickets;
-- max = 1436, min = 6
SELECT
	case
		when resolution_time_mins < 30 then 'Quick Fix'
        when resolution_time_mins between 30 and 120 then 'Standard'
        when resolution_time_mins between 121 and 480 then 'Slow'
        when resolution_time_mins > 480 then 'Breach'
        when resolution_time_mins is null then 'Unresolved'
	end as speed_band,
    ticket_id
FROM customer_servicetkt.customer_service_tickets;

#Q3 — Stakeholder report: Channel Performance Flag
-- Leadership suspects some channels generate harder-to-resolve tickets. 
-- Write a query that flags each ticket as:
-- 'High Effort' if num_interactions >= 7
-- 'Medium Effort' if between 4 and 6
-- 'Low Effort' for 3 or fewer 
-- then aggregate to show the count per channel per effort level.
SELECT 
	channel,
	case
		when num_interactions >= 7 then 'High Effort'
		when num_interactions between 4 and 6 then 'Medium Effort'
        when num_interactions <= 3 then 'Low Effort'
	end as Performance_Flag,
    count(*) as ticket_count
FROM customer_servicetkt.customer_service_tickets
group by channel, Performance_Flag
order by channel,ticket_count desc;

#Q4 — New column: Escalation Risk Score
-- The QA team wants to proactively identify risky tickets still in progress. 
-- Create a risk_flag column that returns:
	-- 'High Risk' if the ticket is Pending or Reopened AND has a low CSAT score (≤ 2), 
	-- 'Medium Risk' if status is Escalated, 
	-- 'Low Risk' if resolved with CSAT ≥ 4, and 
	-- 'Review' for everything else.
SELECT 
	case
		 when status in ('Pending', 'Reopened') and csat_score <= 2 then 'High Risk'
		when status = 'Escalated' then 'Medium Risk'
        when status = 'Resolved' and csat_score >= 4 then 'Low Risk'
        else 'Review'
	end as risk_flag,
    status,
    ticket_id,
    csat_score,
    agent_name
FROM customer_servicetkt.customer_service_tickets;

#Q5 — Stakeholder report: Agent Performance Tier
-- HR wants a quarterly performance summary. 
-- For each agent, calculate their average CSAT and average resolution time, 
-- then use a CASE statement to assign a tier: 
-- 'Top Performer' (avg CSAT ≥ 4 AND avg resolution ≤ 120 mins), 
-- 'Needs Coaching' (avg CSAT < 3 OR avg resolution > 360 mins), and 
-- 'On Track' for everyone else.
SELECT 
	agent_name,
	avg(csat_score) as avg_score, 
	avg(resolution_time_mins) as avg_resolution,
    
	case
		when avg(csat_score) >= 4 and avg(resolution_time_mins) <= 120 then 'Top Performer'
		when avg(csat_score) < 3 and avg(resolution_time_mins) > 360 then 'Needs Coaching'
        else 'On Track'
	end as Agent_Performance_Tier
FROM customer_servicetkt.customer_service_tickets
group by 1;






































