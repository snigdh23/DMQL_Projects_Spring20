let $books := distinct-values(doc("/db/books.xml")/biblio/author/book/title)
let $temp1 := for $r5 in $books
  let $price := xs:integer(distinct-values(doc("/db/books.xml")/biblio/author/book[title=$r5]/price))
  return ($price)
let  $global_price := avg($temp1)

let $temp2 :=for $dt1 in distinct-values(doc("/db/books.xml")/biblio/author/book/category)
let $avg_price := avg(distinct-values(doc("/db/books.xml")/biblio/author/book[category=$dt1]/price))
order by $dt1 ascending
return (<tots>
        <category>{$dt1}</category>
        <price>{$avg_price}</price>
        </tots>)

let $temp4 := for $temp3 in $temp2
    let $m1 := $temp3/price
    let $m2 := $temp3/category
    return if ($m1 > $global_price)
           then data($m2)

let $mopi1 := for $lp1 in $temp4
    let $yup1 := xs:integer(max(doc("/db/books.xml")/biblio/author/book[category=$lp1]/price))
    let $yup2 := distinct-values(doc("/db/books.xml")/biblio/author/book[price=$yup1]/title)
    return $yup2
    
return <result>{ for $mopi2 in distinct-values($mopi1)
    let $rty1 := doc("/db/books.xml")/biblio/author[book/title=$mopi2]/name
    let $rty2 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$mopi2]/price)
    let $rty3 := distinct-values(doc("/db/books.xml")/biblio/author/book[title=$mopi2]/category)
    return <categories>
           <output>
           <category>{$rty3}</category>
           <title>{$mopi2}</title>
           <price>{$rty2}</price>
           {$rty1}
           </output>
           </categories>
}</result>