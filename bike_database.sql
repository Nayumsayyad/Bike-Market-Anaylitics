-- Find bikes with mileage above average and factory price below average. --
select * from bikes
select brand,model,mileage_kmpl,factory_price_inr from bikes
where (select avg(mileage_kmpl) from bikes) < mileage_kmpl
and (select avg(factory_price_inr) from bikes) > factory_price_inr

-- Find the top 5 bikes with the highest mileage and lowest on-road price. --
select brand,model,mileage_kmpl,on_road_price_inr from bikes
order by mileage_kmpl desc,on_road_price_inr asc limit 5 

-- Find brands whose average CC is greater than 200 and average mileage is above 40. --
select brand,avg(cc) as avg_cc ,avg(mileage_kmpl) as avg_mileage
from bikes
group by brand
having avg(cc) > 200
and avg(mileage_kmpl) > 40;

-- Find segment-wise average factory price, average GST amount, and average on-road price. --
select segment,round(avg(factory_price_inr),2) avg_factory_price_inr,
round(avg(gst_amount_inr),2) avg_gst_amount_inr,
round(avg(on_road_price_inr),2) avg_on_road_price_inr
from bikes 
group by segment

-- Find brands with the highest average GST impact. --
select brand,avg(gst_impact_pct) as avg_gst_impact_pct
from bikes
group by brand
order by avg_gst_impact_pct desc

-- Find bikes where the on-road price increased by more than 30% compared to factory price. --

SELECT brand,model,factory_price_inr,on_road_price_inr,
       (factory_price_inr + (factory_price_inr * gst_rate_pct / 100)) AS on_road_price
FROM bikes
WHERE ((factory_price_inr + (factory_price_inr * gst_rate_pct / 100))
      - factory_price_inr) / factory_price_inr * 100 > 30;

-- Find the buyer behaviour category with the highest average price sensitivity. --
select buyer_behaviour,avg(price_sensitivity) as avg_price_sensi
from bikes 
group by buyer_behaviour
order by avg_price_sensi desc
