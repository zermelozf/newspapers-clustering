# Simple stats on the corpus

## Number of articles per domain
```SQL
%spark.sql

select thread.site, count(1) as num_articles
from news
group by  thread.site
```

## Number of articles per month

```SQL
%spark.sql

select concat(first(month(crawled)), ", ", first(year(crawled))), count(1) as num_articles
from news
group by  year(to_date(crawled)), month(to_date(crawled))
order by  year(to_date(crawled)), month(to_date(crawled))
```

## Number of articles per domain per month

```SQL
%spark.sql

select thread.site, concat(first(month(crawled)), ", ", first(year(crawled))) as date, count(1) as num_articles
from news
group by  thread.site, year(to_date(crawled)), month(to_date(crawled))
order by  year(to_date(crawled)), month(to_date(crawled))
```
