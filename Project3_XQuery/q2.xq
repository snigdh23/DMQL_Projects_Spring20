for $author1 in doc("/db/books.xml")/biblio/author
  for $author2 in doc("/db/books.xml")/biblio/author
    let $rando1 := $author1/book[title=$author2/book/title]
        where $author1/book/title = $author2/book/title and $author1/name != $author2/name and count($author1/book[title=$author2/book/title])>1 and $author1/name < $author2/name
               return 
                     <coauthor>
                        {
                          for $temp1 in $rando1 
                             return <output>
                                  <name>{data($author1/name)}</name>
                                  <name>{data($author2/name)}</name>
                                  {$temp1}
                             </output>
                        }
                     </coauthor>