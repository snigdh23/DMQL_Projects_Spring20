for $distinct_categories in distinct-values(doc("/db/books.xml")/biblio/author/book/category)
let $maxrating := max(doc("/db/books.xml")/biblio/author/book[category=$distinct_categories]/rating)
let $title := distinct-values(doc("/db/books.xml")/biblio/author/book[category=$distinct_categories and rating=$maxrating]/title)[1]
order by $distinct_categories ascending
return (<title>{$title}</title>,
        <rating>{$maxrating}</rating>,
        <category>{$distinct_categories}</category>)