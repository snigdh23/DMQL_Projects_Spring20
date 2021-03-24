let $titles := distinct-values(doc("/db/books.xml")/biblio/author/book/title)
for $t1 in $titles
  let $rating := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$t1]/rating)
  order by xs:double($rating) descending
  return (<title>{$t1}</title>,
         <rating>{data($rating)}</rating>)