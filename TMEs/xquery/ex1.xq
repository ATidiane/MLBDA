(: for $p in //person
where $p/@id eq "person0"
return $p/name :)

(: let $a := //open_auctions/auction/initial
for $b in ( $a[1], $a[2], $a[3] )
return <result id="{$b/parent::*/@id}">
      {$b}
      </result> :)

(: let $a := //open_auctions/auction/initial
for $b in ( $a[1], $a[2], $a[3] )
let $c := $b/parent::*/bidder/increase
return <result id="{$b/parent::*/@id}">
      <first> {$c[1]} </first>
      <last> {$c[last()]} </last>
      </result>  :)
       
(: let $p := //auction[price>480]
return $p/price :)

(: for $a in //africa/item/name
return $a :)

(: for $a in //africa/item
let $p := //auction/itemref[@item=$a/@id]
where $p/parent::*/price
return <res> {$a/name} {$p/parent::*/price}  </res> :)


for $p in //person[count(homepage) = 0]
let $c := count($p/name)
return count($c)
