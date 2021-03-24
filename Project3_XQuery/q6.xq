<biblio2>{ 
let $r3 := doc("/db/books.xml")/biblio/author/book
for $r2 in distinct-values(doc("/db/books.xml")/biblio/author/book/title)
    let $title2 := data($r2)
    let $year2 := distinct-values(data($r3[title=$title2]/@year))
    let $category2 := distinct-values(data($r3[title=$title2]/category))
    let $rating2 := distinct-values(data($r3[title=$title2]/rating))
    let $price2 := distinct-values(data($r3[title=$title2]/price))
    let $authors := data(doc("/db/books.xml")/biblio/author[book/title=$title2]/name)
    let $names := for $i in $authors
                    return <name>{$i}</name>
        return (<book year="{$year2}">
               <title>{$title2}</title>
               <category>{$category2}</category>
               <rating>{$rating2}</rating>
               <price>{$price2}</price>
                 <author>{$names}</author>
            </book>) 
}</biblio2>

(:
---------- ALTERNATIVE 1 ----------
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE biblio2[
<!ELEMENT biblio2 (book*)>
<!ELEMENT book (title,category,rating,price,author)>
<!ELEMENT title (#PCDATA)>
<!ELEMENT category (#PCDATA)>
<!ELEMENT rating (#PCDATA)>
<!ELEMENT price (#PCDATA)>
<!ELEMENT author (name)>
<!ELEMENT name (#PCDATA)>
<!ATTLIST book year CDATA #REQUIRED>
]>

<biblio2>{
  for $r1 in doc("/db/books.xml")/biblio/author
  let $authorname2 := data($r1/name)
  for $r2 in $r1/book
    let $year2 := data($r2/@year)
    let $title2 := data($r2/title)
    let $category2 := data($r2/category)
    let $rating2 := data($r2/rating)
    let $price2 := data($r2/price)
    return (<book year="{$year2}">
               <title>{$title2}</title>
               <category>{$category2}</category>
               <rating>{$rating2}</rating>
               <price>{$price2}</price>
               <author><name>{$authorname2}</name></author>
            </book>)
}</biblio2>
---------------------------------------------------------------------
---------- ALTERNATIVE 2 ----------
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE biblio2[
<!ELEMENT biblio2 (book*)>
<!ELEMENT book (title,authorname,category,rating,price)>
<!ELEMENT title (#PCDATA)>
<!ELEMENT authorname (#PCDATA)>
<!ELEMENT category (#PCDATA)>
<!ELEMENT rating (#PCDATA)>
<!ELEMENT price (#PCDATA)>
<!ATTLIST book year CDATA #REQUIRED>
]>

<biblio2>{ for $r1 in doc("/db/books.xml")/biblio/author
  let $authorname2 := data($r1/name)
  for $r2 in $r1/book
    let $year2 := data($r2/@year)
    let $title2 := data($r2/title)
    let $category2 := data($r2/category)
    let $rating2 := data($r2/rating)
    let $price2 := data($r2/price)
    return (<book year="{$year2}">
               <title>{$title2}</title>
               <authorname>{$authorname2}</authorname>               
               <category>{$category2}</category>
               <rating>{$rating2}</rating>
               <price>{$price2}</price>
            </book>) }</biblio2>
:)