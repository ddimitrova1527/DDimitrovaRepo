-- All customers from United States;
Select * from customers 
Where Country = ‘UnitedStates‘;

-- All customers whose details were not updated from their creation on;
Select * from customer_details 
Where Created_at = Updated_at;

-- The average customer age per country;
Select AVG(customer_details.Age), customers.Country
From customer_details
INNER JOIN customers
ON customer_details.ID=customers.ID
group by customers.Country;


