select I.rname
from river_into_lake I, river_from_lake F
where I.lname = F.lname 
and I.rname = F.rname
