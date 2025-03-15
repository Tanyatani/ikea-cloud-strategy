
-- Cloud Cost Analysis: AWS Reserved Instances vs On-Demand Pricing

CREATE TABLE cloud_pricing (
    instance_type VARCHAR(50),
    on_demand_price DECIMAL(10,2),
    reserved_price DECIMAL(10,2),
    savings_percentage DECIMAL(5,2)
);

INSERT INTO cloud_pricing (instance_type, on_demand_price, reserved_price, savings_percentage) VALUES
('t3.medium', 0.0416, 0.0264, 36.54),
('m5.large', 0.096, 0.057, 40.63),
('c5.xlarge', 0.17, 0.108, 36.47),
('r5.2xlarge', 0.504, 0.302, 40.08);

SELECT 
    instance_type, 
    on_demand_price, 
    reserved_price, 
    ROUND((on_demand_price - reserved_price) / on_demand_price * 100, 2) AS savings_percentage
FROM cloud_pricing
ORDER BY savings_percentage DESC;

SELECT 
    instance_type, 
    (on_demand_price * 24 * 365 * 3) AS three_year_on_demand_cost,
    (reserved_price * 24 * 365 * 3) AS three_year_reserved_cost,
    ROUND((on_demand_price * 24 * 365 * 3) - (reserved_price * 24 * 365 * 3), 2) AS savings_3_years
FROM cloud_pricing
ORDER BY savings_3_years DESC;

SELECT instance_type 
FROM cloud_pricing 
WHERE savings_percentage = (SELECT MAX(savings_percentage) FROM cloud_pricing);
