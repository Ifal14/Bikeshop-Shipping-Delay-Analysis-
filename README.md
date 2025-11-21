## Bikeshop Shipping Delay Analysis – Project Summary
# Overview
This project analyzes shipping delays experienced by Bikeshop, a bicycle retail company, to identify key operational bottlenecks and provide actionable recommendations for improving delivery efficiency. The analysis was conducted using PostgreSQL for data preparation and exploratory analysis, and Tableau for visualizing performance patterns.

# Dataset
Source: Sales and production database
Year: 2017
Size: 4,722 rows, 20 columns
Data prep results: 33 duplicates removed, 0 missing values

# Key Findings & Insights
1. Overall Shipping Performance
Total shipments: 2,067
Delayed shipments: 644
Delay rate: 31.16%
➡️ Indicates a significant operational inefficiency requiring immediate intervention.
2. Delays by Day of Week
Highest order volume: Sunday
Highest delays: Monday
➡️ There is a partial correlation between high volume and delays, but inconsistencies suggest deeper issues such as staffing or process gaps at the start of the week.
3. Delays by Month
March recorded the highest shipping volume and the highest delays.
➡️ A clear monthly peak strain, showing the system cannot scale well during demand spikes.
4. Delays by Store
Baldwin Bikes accounts for 65% of all delays, making it the biggest bottleneck in the network.
➡️ Suggests major internal operational or logistical issues at this store.
5. Delays by Destination City
Routes from Baldwin → Smithtown and Baldwin → Spring Valley experience the most delays.
➡️ Fixing Baldwin’s process will have the highest impact on overall delay reduction.

# Conclusions
Temporal patterns show peaks on Monday and throughout March.
Baldwin Bikes is the critical origin point responsible for the majority of delays.
Specific routes consistently underperform, amplifying customer dissatisfaction.

# Recommendations
1. Fix the Main Bottleneck: Baldwin Store
Run an operational audit: workflow, staffing levels, packaging, dispatch timing
Improve coordination between sales, warehouse, and delivery partners
Introduce performance tracking specifically for Baldwin-origin shipments
2. Improve Capacity on Peak Days/Months
Add temporary staff or shift adjustments on Sunday–Monday
Increase logistics capacity during March
Implement early-week workload balancing to avoid Monday pile-up
3. Optimize High-Delay Routes
Review carrier performance for Baldwin → Smithtown & Baldwin → Spring Valley
Evaluate route planning, delivery partners, and transportation constraints
Apply route-specific SLAs (Service Level Agreements)
