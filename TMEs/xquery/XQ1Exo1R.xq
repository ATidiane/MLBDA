(: for $r in //person
where $r/@id = "person0"
return $r/name :)

(: for $e in //open_auctions/auction[position() <= 3]
return 
<result id="{$e/@id}">
{$e/initial}
</result> :)

(: for $e in //open_auctions/auction[position() <= 3], 
$first in $e/bidder[position()=1]/increase/text(),
$last in $e/bidder[last()]/increase/text()
return 
<result id="{$e/@id}">
<first>{$first}</first>
<last>{$last}</last>
</result> :)

(: for $e in //open_auctions/auction[position() <= 3]
return 
<result id="{$e/@id}">
<first>{$e/bidder[position()=1]/increase/text()}</first>
<last>{$e/bidder[last()]/increase/text()}</last>
</result>
 :)

(: for $p in //closed_auctions/auction/price
where $p > 480
return $p :)

(: for $no in //regions/africa/item
return $no/name :)

(: for $auction in //closed_auctions/auction
return 
<res>
<name>{
  for $no in //regions/africa/item
  where $auction/itemref/@item = $no/@id
  return $no/name/text()
}</name>
<price>{$auction/price}</price>
</res> :)

(: let $e:=//person[not(homepage)]
return count($e)
 :)
 
 (: Examen 2017 :)
 
(: <résultat>
{ for $l in distinct-values(document("projects.xml")//project/location)
 return {
   for $p in document("projects.xml")//project[location=$l]
   where every $x in document("projects.xml")//project satisfies $x/budget <= $p/budget
   return $l }
}
</résultat> :)


(: <résultat> {
for $e in //employee
let $p:= //project[employee/ln = $e/ln]
where every $pp in $p satisfies $pp/location = "San Francisco"
return $e/ln }
</résultat> :)

(: <résultat>
{
  for $p in //project
  return 
  if (exists($p/duration))
  then <duration project="{$p/@name}"> {$p/duration/text()} </duration>
  else <unknown-duration project="{$p/@name}" />
}
</résultat> :)


<résultat>
{
  for $p in //project
  let $d := $p/duration
  return
    if (exists($d)) 
    then <duration project='{$p/@name}' >{$d/text()}</duration>
    else <unknown-duration project='{$p/@name}'/>
}
</résultat>
