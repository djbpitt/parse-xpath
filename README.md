# parse-xpath

Goal: Use Gunther Rademacher’s REx Parser Generator (<https://www.bottlecaps.de/rex/>) to
create a parser for XPath 3.1.

Input: XPath 3.1 EBNF file supplied at <https://www.bottlecaps.de/rex/xpath-31.ebnf>.

Settings: `xpath-31.txt -backtrack -xslt -tree -name xpath3.1_parser`
