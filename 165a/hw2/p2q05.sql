select B1.country_a
from borders B1, borders B2
where B1.country_a = B2.country_a
and B1.country_b not in (B2.country_b)
