for $var1 in doc("/db/books.xml")/biblio/author[name="Jeff"]/book/title
   for $var2 in doc("/db/books.xml")/biblio/author[name!="Jeff"]
      order by data($var1)
      return if($var2/book/title = $var1)
             then <book>
               <title>{data($var1)}</title> 
               <name>Jeff</name>
               <name>{data($var2/name)}</name>
               </book>