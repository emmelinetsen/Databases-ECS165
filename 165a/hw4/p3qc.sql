--Trigger will be triggered when the new price is larger than the sum of its direct subpart
create function check_price_function() returns trigger as '
begin
    if(exists ( 
select SuperPartId 
from BOM
group by SuperPartId
having sum(Price) < new.Price)
)
    then 
        raise exception ''The super part cannot be cheaper than the sum of its direct subparts.'';
    end if;
    
    return new;
    end;
'language plpgsql;

create trigger check_price
after insert or update of price
on BOM for each row
execute procedure check_price_function();


