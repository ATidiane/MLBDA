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

let $e:=//person[not(homepage)]
return count($e)

