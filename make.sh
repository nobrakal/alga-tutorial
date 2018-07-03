#!/bin/sh

pandoc -s -t html5 tutorial.tex > index.html
sed -i '/<style.*>/,/<\/style>/d' index.html
sed -i 's|</head>|</head><style>\n</style>|' index.html
sed -i -e '/<style>/r main.css' index.html
sed -i 's|</body>|<script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js?lang=hs\&skin=desert"></script>\n</body>|' index.html
sed -i 's|<pre class="sourceCode haskell">|<pre class="sourceCode haskell prettyprint">|' index.html
sed -i 's|<code>|<code class="verbated">|g' index.html

INNAV=""

for title in $(grep "<h1 id" index.html | sed -e 's/.*id=\"\(.*\)\".*/\1/')
do
  act=$(echo "$title" | sed "s/-/ /g" |sed 's/.*/\u&/')
  INNAV="$INNAV\n<li><a href=\"#$title\">$act</a></li>"
done

sed -i "s|</header>|</header>\n<nav>\n<ol>$INNAV\n</ol></nav>|" index.html

LST="figspng/connect.png figspng/overlay.png figspng/fmap.png figspng/saturate.png"
for f in $LST
do
  sed -i "s|<img src=\"$f\"|<img src=\"$f\" class=\"big\"|" index.html
done
