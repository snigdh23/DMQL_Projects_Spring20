for $distinct_categories in distinct-values(doc("/db/books.xml")/biblio/author/book/category)
let $minprice := min(doc("/db/books.xml")/biblio/author/book[category=$distinct_categories]/price)
let $title := distinct-values(doc("/db/books.xml")/biblio/author/book[category=$distinct_categories and price=$minprice]/title)
order by $distinct_categories ascending
return (<title>{$title}</title>,
        <price>{$minprice}</price>,
        <category>{$distinct_categories}</category>)