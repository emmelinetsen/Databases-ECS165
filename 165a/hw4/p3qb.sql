-- Trigger will be triggered when there are already 5 subparts 
-- within a superpart
create function check_children_function() returns trigger as '
begin
    if(exists (
	select SuperPartId
	From BOM 
	group by SuperPartId 
	having count(SuperPartID) > 5))
    then 
        raise exception ''This part already has 5 subparts.'';
    end if;
    
    return new;
    end;
' language plpgsql;

create trigger check_children
after insert or update
on BOM
execute procedure check_children_function();
