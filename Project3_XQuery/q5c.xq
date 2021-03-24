let $book := distinct-values(doc("/db/books.xml")/biblio/author/book/title)
let $resultant := 
  for $l1 in $book
    for $l2 in $book
      for $l3 in $book
        for $l4 in $book
          let $price1 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l1]/price)
          let $price2 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l2]/price)
          let $price3 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l3]/price)
          let $price4 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l4]/price)
          let $cat1 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l1]/category)
          let $cat2 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l2]/category)
          let $cat3 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l3]/category)
          let $cat4 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l4]/category)
          let $rat1 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l1]/rating)
          let $rat2 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l2]/rating)
          let $rat3 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l3]/rating)
          let $rat4 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$l4]/rating)
          let $total_price := $price1 + $price2 + $price3 + $price4
          let $total_rating := $rat1 + $rat2 + $rat3 + $rat4
          return if($l1 != $l2 and $l1 != $l3 and $l1 != $l4 and $l2 != $l3 and $l2 != $l4 and $l3 != $l4 and $cat1 != $cat2 and $cat1 != $cat3 and $cat1 != $cat4 and $cat2 != $cat3 and $cat2 != $cat4 and $cat3 != $cat4 and $total_price=1800)
                 then concat($l1, ",", $l2, ",", $l3, ",", $l4, ",", $total_rating)


let $var1 := for $temp1 in $resultant
    let $book_rating_list1 := tokenize($temp1,",")
    let $db_book := for $rt1 in ($book_rating_list1[1],$book_rating_list1[2],$book_rating_list1[3],$book_rating_list1[4])
                 return if(data(doc("/db/books.xml")/biblio/author/book[title=$rt1]/category) = "DB")
                   then $rt1
    let $pl_book := for $rt1 in ($book_rating_list1[1],$book_rating_list1[2],$book_rating_list1[3],$book_rating_list1[4])
                 return if(data(doc("/db/books.xml")/biblio/author/book[title=$rt1]/category) = "PL")
                   then $rt1
    let $science_book := for $rt1 in ($book_rating_list1[1],$book_rating_list1[2],$book_rating_list1[3],$book_rating_list1[4])
                 return if(data(doc("/db/books.xml")/biblio/author/book[title=$rt1]/category) = "Science")
                   then $rt1
    let $others_book := for $rt1 in ($book_rating_list1[1],$book_rating_list1[2],$book_rating_list1[3],$book_rating_list1[4])
                 return if(data(doc("/db/books.xml")/biblio/author/book[title=$rt1]/category) = "Others")
                   then $rt1
    return concat($db_book, ",", $pl_book, ",", $science_book, ",", $others_book, ",", 
                  format-number(xs:double($book_rating_list1[5]),"###.###"))

let $var2 := for $temp2 in $var1
    group by $temp2
    order by $temp2 descending
    return $temp2

let $var3 := for $temp3 in $var2
    let $book_rating_list2 := tokenize($temp3,",")
        return <book b1 = "{$book_rating_list2[1]}" b2 = "{$book_rating_list2[2]}" b3 = "{$book_rating_list2[3]}" b4 = "{$book_rating_list2[4]}">{$book_rating_list2[5]}</book>

let $var4 := for $temp4 in $var3
    order by $temp4 descending
    return $temp4

let $var5 := $var4[1]
let $var6 := (data($var5/@b1),data($var5/@b2),data($var5/@b3),data($var5/@b4))
for $temp5 in $var6
    let $price := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$temp5]/price)
    let $rating := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$temp5]/rating)
    let $category := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$temp5]/category)
    return (<title>{$temp5}</title>,
           <price>{$price}</price>,
           <rating>{$rating}</rating>,
           <category>{$category}</category>)