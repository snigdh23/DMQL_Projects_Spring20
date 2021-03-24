let $titles := distinct-values(doc("/db/books.xml")/biblio/author/book/title)
for $t1 in $titles
  let $price := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$t1]/price)
  order by xs:integer($price) ascending
  return (<title>{$t1}</title>,
         <price>{data($price)}</price>)