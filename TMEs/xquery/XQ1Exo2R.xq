for $e in //book 
where $e/publisher/text() = "Addison-Wesley" and $e/@year > 1991
return 
<bib>
<book year="{$e/@year}">
{$e/title}
</book>
</bib>

(: for $e in //book/publisher
return $e :)