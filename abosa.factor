USING: accessors arrays assocs calendar calendar.format grouping
io io.directories io.encodings.utf8 io.files io.pathnames
io.streams.string json kernel libc make math math.parser
multiline namespaces sequences ui ui.gadgets.cells.colonies
ui.gadgets.scrollers xml xml.data xml.tokenize xml.traversal
xml.writer ;
IN: abosa

! overwrite the xml take-comment to allow -- in comments
: take-comment ( -- comment )
    ! "-->" expect
    "-->" take-string
    <comment>
    ! ">" expect
    ;



:: contents-list ( xml -- str-seq )
    8 <iota> [ number>string xml swap get-id children>> second last ] map
    ;

: chapter-paths-ordered-imgs ( -- seq )
{
    "img/faceless-mr-spaceman.png"
    "img/st-damocles-abloom.png"
    "img/st-damocles-helmet-frozen-with-lantern.png"
    "img/st-damocles-helmet-impaled.png"
    "img/st-damocles-in-nightspore.png"
    "img/st-damocles-infinite.png"
    "img/st-damocles-helmet-tied-up.png"
    "img/st-damocles-helmet-open.png"
}
    ;

: chapter-paths-ordered ( xml -- str )
contents-list
chapter-paths-ordered-imgs
zip
    ;

: image-paths-ordered ( -- str )
{
    "img/st-damocles-the-shephard.png"
    "img/st-damocles-searches-for-wandering-aengus.png"
    "img/st-damocles-jumps.png"
    "img/st-damocles-in-gravitational-disorientation.png"
    "img/st-damocles-in-the-stomach-of-the-signal-eater.png"
    "img/the-hand-of-st-damocles.png"

    "img/st-damocles-and-the-geometry.png"
    "img/st-damocles-amalgamates.png"
    "img/st-damocles-looking-round-the-torus-forest.png"
    "img/st-damocles-breaks-geometry.png"
    "img/st-damocles-frozen-over.png"
    "img/st-damocles-alight.png"

    "img/st-damocles-leaves-the-c-zone.png"
    "img/st-damocles-tunnels-in.png"
    "img/st-damocles-uncrystalline.png"
    "img/st-damocles-read-only.png"
    "img/st-damocles-frees-aengus.png"
    "img/st-damocles-interred.png"

    "img/st-damocles-entangled.png"
    "img/st-damocles-plotting-on-strings.png"
    "img/st-damocles-along-a-lyre.png"
    "img/st-damocles-as-pendulum.png"
    "img/st-damocles-fights-the-fall.png"
    "img/st-damocles-escapes-the-pull.png"

    "img/st-damocles-in-hibernation.png"
    "img/st-damocles-awash-in-gradients.png"
    "img/st-damocles-integrated.png"
    "img/st-damocles-imploded.png"
    "img/st-damocles-tesellating.png"
    "img/st-damocles-tesellated.png"

    "img/st-damocles-reinstalled.png"
    "img/st-damocles-mooring.png"
    "img/st-damocles-verified.png"
    "img/st-damocles-on-tape.png"
    "img/st-damocles-fatestring.png"
    "img/st-damocles-rides-a-pulse.png"

    "img/st-damocles-enters-the-pocket.png"
    "img/st-damocles-meets-the-lantern-keeper.png"
    "img/st-damocles-shows-what-is-there.png"
    "img/st-damocles-internally-bright.png"
    "img/st-damocles-written-out.png"
    "img/st-damocles-surfaced-lightly.png"

    "img/st-damocles-with-blindsight.png"
    "img/st-damocles-condensation.png"
    "img/st-damocles-diving.png"
    "img/st-damocles-impaled.png"
    "img/st-damocles-powered-down.png"
    "img/dragonfly-remains.png"
}
    ;

: chapter-list ( xml -- str-seq )
    [ "#" get-id "p" deep-tags-named ]
    [ "##" get-id "p" deep-tags-named ]
    bi
    append
    [ children>> [ tag? ] reject "  " join ] map
    ;

: first-comment ( xml -- str )
    children>> [ tag? ] filter second children>> [ comment? ] filter first text>>
    ;

: title-page ( xml -- str )
    [ first-comment
    "#show raw: set text(font: \"Iosevka Fixed\", slashed-zero: true, size: 9.0pt)\n#v(1fr)\n```" "```\n#v(1fr)\n#set text(size: 7.0pt)\n" surround ]
    [ drop "#outline(title: [ABOSA])\n" ]
    bi
    append

    "#[#set align(center)\n" "]\n" surround 

[[
#let globalcntr = counter("globalcntr")
#let code(
    caption: none,             // content of caption bubble (string, none)
    bgcolor: none, // rgb("#fefae0"),   // back ground color (color)
    strokecolor: none, // 1pt + maroon, // frame color (color)
    hlcolor: none, // auto,             // color to use for highlighted lines (auto, color)
    width: 100%,
    radius: 0pt,
    inset: 0pt,
    numbers: false,            // show line numbers (boolean)
    stepnumber: 1,             // only number lines divisible by stepnumber (integer)
    numberfirstline: false,    // if the firstline isn't divisible by stepnumber, force it to be numbered anyway (boolean)
    numberstyle: auto,         // style function to apply to line numbers (auto, style)
    firstnumber: 0,            // number of the first line (integer)
    highlight: none,           // line numbers to highlight (none, array of integer)
    content
) = {
    if type(hlcolor) == "auto" {
        hlcolor = bgcolor.darken(10%)
    }
    if type(highlight) == "none" {
        highlight = ()
    }
    block(
        width: width,
        fill: bgcolor,
        stroke: strokecolor,
        radius: radius,
        inset: inset,
        clip: false,
        {
            // Draw the caption bubble if a caption was set
            if caption != none {
                style(styles => {
                    let caption_block = block(width: auto,
                            inset: inset,
                            radius: radius,
                            fill: bgcolor,
                            stroke: strokecolor,
                            h(.5em) + caption + h(.5em))
                    place(
                        top + left,
                        dx: 0em,
                        dy: -(measure(caption_block, styles).height / 2 + inset),
                        caption_block 
                    )
                })
                // skip some vertical space to avoid the caption overlapping with
                // the beginning of the content
                v(.6em)
            }

            let (columns, align, make_row) = {
                if numbers {
                    // line numbering requested
                    if type(numberstyle) == "auto" {
                        numberstyle = text.with(style: "italic", 
                                                slashed-zero: true, 
                                                size: .5em)
                    }
                    ( ( 0.1em, 1fr ),
                      ( right, left ),
                      e => {
                        let (i, l) = e
                        let n = i + firstnumber
                        let n_str = if (calc.rem(n, stepnumber) == 0) or (numberfirstline and i == 0) { numberstyle(str(n)) } else { none }
                        (n_str, raw(lang: content.lang, l))
                      }
                    )
               } else {
                    ( ( 1fr, ),
                      ( left, ),
                      e => {
                        let (i, l) = e
                        raw( lang:content.lang, l)
                      },
                    )
                }
            }
            table(
                stroke:none,
                columns: columns,
                rows: (1fr,),
                gutter: 0pt,
                inset: 1pt,
                align: (col, _) => align.at(col),
                fill: (c, row) => if (row / 2 + firstnumber) in highlight { hlcolor } else { none },
                ..content
                    .text
                    .split("\n")
                    .enumerate()
                    .map(make_row)
                    .flatten()
                    .map(c => if c.has("text") and c.text == "" { v(1em) } else { c })
            )
        }
    )
}




// #set page( width:6.88in, height:10.50in, margin: (inside: 1in, outside: 0.5in), fill: rgb("#1d1f21")) // paper: "a5", 
#set page( paper: "a5", fill: rgb("#1d1f21")) // paper: "a5", 
#set text( font: "Iosevka", size: 7.0pt, fill: rgb("#c5c8c6"), slashed-zero: true ,fallback: false)
#set par(justify: false)
]]

[[
#pagebreak()
]]
    surround
    ; inline

:: contents-page ( xml -- str )
    [[
#set page( fill: rgb("#c5c8c6"))
#set text( size: 15.0pt, fill: rgb("#c5c8c6"))
#stack(
  dir: ttb,
  image("img/faceless-mr-spaceman.png",width: 100%, height: 25%),
  image("img/st-damocles-abloom.png",width: 100%, height: 25%),
  image("img/st-damocles-helmet-frozen-with-lantern.png",width: 100%, height: 25%),
  image("img/st-damocles-helmet-impaled.png",width: 100%, height: 25%),
)
]]

xml chapter-list 4 cut
[
[ rest "highlight(fill: rgb(\"#1d1f21\"), \"" "\")" surround ] map
first4
'[ "#place(top + center, stack(dir: ttb" , "v(15%)" , _ , "v(20%)" , _ , "v(20%)" , _ , "v(20%)" , _ , "))" ,
] { } make "," join
] bi@

[[
#set page( fill: rgb("#1d1f21"))
#stack(
  dir: ltr,
  image("img/st-damocles-in-nightspore.png", height: 100%, width: 25%),
  image("img/st-damocles-infinite.png", height: 100%, width: 25%),
  image("img/st-damocles-helmet-tied-up.png", height: 100%, width: 25%),
  image("img/st-damocles-helmet-open.png", height: 100%, width: 25%),
)
]]
swap

[[
#set page(footer: locate(
  loc => if calc.even(loc.page()) {
    align(left, counter(page).display("1"));
  } else {
    align(right, counter(page).display("1"));
  }
))
#set text( size: 7.0pt, fill: rgb("#1d1f21"))
    ]]

:> ( a b c d e )
{ a b c d e } concat
    ; inline

: end-page ( -- str )
[[
#set page(columns: 1, footer: none)
#image("img/self-abosa-mapped.png", width: 100%, height: 100%)
]]
    ; 

: extract-stanzas ( xml -- tags-seq )
    "span" deep-tags-named [ children>string ] map
    ;

: extract-image-src ( xml -- img-seq )
    "img" deep-tags-named [ attrs>> alist>> first second ] map
    ;

: group-stanzas ( xml -- stanza-seq )
    extract-stanzas 8 <groups>
    ;

: group-pages ( stanza-seq -- page-seq )
    8 <groups>  ! [ [ "\n" join ] map ] map
    ;

INITIALIZED-SYMBOL: cntr [ 0 ]

: iter-stanzas ( stanzas-seq -- str )
    4 cut

    cntr get number>string  '[ "#code(numbers: true, firstnumber: " , _ , ")[```none" , ] { } make concat '[ { { _ } } prepend { { "```]\n" } } append ]
    cntr get 32 + number>string  '[ "#code(numbers: true, firstnumber: " , _ , ")[```none" , ] { } make concat '[ { { _ } } prepend { { "```]\n" } } append ] bi*
    cntr get 64 + cntr set
    { { "#colbreak()" } } glue
    [
        "\n" join
    ] map
    ;

:: iter-pages ( page-seq xml -- str-seq )
    page-seq image-paths-ordered zip
    6 <groups> xml chapter-paths-ordered zip
    [
        [ second [ second "#set page(columns: 1)\n#image(\"" "\",width: 100%, height: 100%, fit: \"cover\")\n#set page(columns: 2)\n" surround ]
                 [ first "#v(1fr)\n= " "#v(1fr)\n" surround ] bi 2array "\n" join ]
        [
            first
            [
                [ second "#set page(columns: 1)\n#image(\"" "\",width: 100%, height: 100%, fit: \"contain\")\n#set page(columns: 2)" surround ]
                [ first iter-stanzas "\n" join ]
                bi
                2array "\n" join
            ] map
        ] bi
        swap prefix "\n" join
    ] map
    dup length 2 / cut { "#set page( fill: rgb(\"#1d1f21\"))\n#set text( fill: rgb(\"#c5c8c6\"))\n" } glue


    "\n" join

[[
#set page( fill: rgb("#c5c8c6"))
]]
    prepend
    ;

: load-html-poem ( -- xml )
    P" ~/art/abosa/index.html" utf8 [ io:read-lines ] with-file-reader
    rest "\n" join string>xml
    ;

: write-extracted-stanzas ( path xml -- )
    group-stanzas  [ "\n" join ] map "\n\n" join
    [ write ] curry utf8 swap with-file-writer
    ;

: gen-typst ( -- )
    load-html-poem dup dup dup
    '[
    _ title-page ,
    _ contents-page
    , _ group-stanzas group-pages _ iter-pages
    , end-page
    , ] { } make
    "\n" join 
    P" ~/art/abosa/abosa.typ" swap [ write ] curry utf8 swap with-file-writer ; inline

: gen-typst-cover ( -- )
    load-html-poem first-comment
    "```" "```" surround

[[
#set page( width:13.81in, height:10.50in, margin: 0in, fill: rgb("#1d1f21"))
#show raw: set text(font: "Iosevka Fixed", slashed-zero: true, size: 9.0pt, fill: rgb("#c5c8c6"))
#grid(columns: (10fr,0.31in,10fr), rows: (auto),
                image("./img/self-abosa-mapped.png",width: 100%, height: 100%),
                grid(columns: (1fr,auto, 1fr), rows: (1fr, auto), h(1fr),```
   
 | 
\|/
\Y/
(X)
                ```, h(1fr), h(1fr), ```
 A
 B
 O
 S
 A
   
                ```, h(1fr)),grid(columns: ( 1fr, auto, 1fr ), rows: (1fr,auto,1fr), h(1fr), v(1fr), h(1fr),
h(1fr),]]
[[
,h(1fr),h(1fr),v(1fr),h(1fr)))
]]

    surround
    P" ~/art/abosa/abosa-cover.typ" swap [ write ] curry utf8 swap with-file-writer ; inline

! ------------------------------------------------------------------
: meta-time ( -- str )
    now dup '[ _ YYYY-MM-DD "T" write _ hh:mm:ss "Z" write ] with-string-writer
    ;

: add-metadata ( xml -- )
    "package" deep-tag-named
    dup
    children>>
    V{ } "metadata" V{ { "xmlns:opf" "http://www.idpf.org/2007/opf" } }
    V{ } "dc:title" V{ { "id" "t1" } } V{ "ABOSA" } <tag> suffix
         "dc:creator" V{ { "opf:role" "aut" } } V{ "inivekin@gmail.com" } <tag> suffix
         "dc:identifier" V{ { "id" "db-id" } } V{ "isbn" } <tag> suffix
         "meta" V{ { "property" "dcterms:modified" } } V{ } meta-time suffix <tag> suffix
         "dc:language" V{ } V{ "en" } <tag> suffix
    <tag> suffix
    append
    >>children
    drop
    ;

: add-manifest ( xml -- )
    "package" deep-tag-named
    dup
    children>>
    V{ } "manifest" V{ }
    V{ } "item" V{ { "id" "toc" } { "href" "toc.xhtml" } { "media-type" "application/xhtml+xml" } { "properties" "nav" } } V{ } <tag> suffix
         "item" V{ { "id" "ncx" } { "href" "toc.ncx" } { "media-type" "application/x-dtbncx+xml" } } V{ } <tag> suffix
         "item" V{ { "id" "cover" } { "href" "cover.xhtml" } { "media-type" "application/xhtml+xml" } } V{ } <tag> suffix
         ! add segment as just a number as id fucks ebook-viewer
         8 <iota> [ "item" swap number>string dup '[ "segment" _ append "id" ,, _ ".xhtml" append "href" ,, "application/xhtml+xml" "media-type" ,, ] V{ } make V{ } <tag> ] map append
         "item" V{ { "id" "back" } { "href" "back.xhtml" } { "media-type" "application/xhtml+xml" } } V{ } <tag> suffix

        image-paths-ordered <enumerated> [ first2 '[ "image" _ number>string append "id" ,, _ "href" ,, "image/jpeg" "media-type" ,, ] V{ } make [ "item" ] dip V{ } <tag> ] map
        append

        chapter-paths-ordered-imgs <enumerated> [ first2 '[ "chapter-image" _ number>string append "id" ,, _ "href" ,, "image/png" "media-type" ,, ] V{ } make [ "item" ] dip V{ } <tag> ] map
        append

         "item" V{ { "id" "backimage" } { "href" "img/self-abosa-mapped.jpg" } { "media-type" "image/jpeg" } } V{ } <tag> suffix

         "item" V{ { "id" "stylesheet" } { "href" "stylesheet.css" } { "media-type" "text/css" } } V{ } <tag> suffix

    <tag> suffix
    append
    >>children
    drop
    ;

: add-spine ( xml -- )
    "package" deep-tag-named
    dup
    children>>
    V{ } "spine" V{ { "toc" "ncx" } }
    V{ } "itemref" V{ { "idref" "cover" } { "linear" "yes" } } V{ } <tag> suffix
         "itemref" V{ { "idref" "toc" } } V{ } <tag> suffix
         8 <iota> [ "itemref" swap number>string '[ "segment" _ append "idref" ,, ] V{ } make V{ } <tag> ] map append
         "itemref" V{ { "idref" "back" } } V{ } <tag> suffix
    <tag> suffix
    append
    >>children
    drop
    ;

: add-guide ( xml -- )
    "package" deep-tag-named
    dup
    children>>
    "reference" V{ { "type" "toc" } { "title" "ABOSA" } { "href" "toc.xhtml" } } V{ } <tag>
    suffix
    >>children
    drop
    ;

: gen-content.opf ( -- xml )
[[ <?xml version="1.0" encoding="UTF-8" ?>
<package xmlns="http://www.idpf.org/2007/opf" xmlns:dc="http://purl.org/dc/elements/1.1/" unique-identifier="db-id" version="3.0">
</package>
]]
    string>xml
    dup add-metadata
    dup add-manifest
    dup add-spine
    dup add-guide
    ;

: gen-toc-head ( -- xml )
[[ <?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
</html>
]]
    string>xml
    dup dup
    children>>
    V{ } "head" V{ } V{ }
         "link" V{ { "href" "stylesheet.css" } { "rel" "stylesheet" } { "type" "text/css" } } V{ } <tag> suffix
         <tag> suffix
    append
    >>children
    drop
    ;

: gen-toc ( -- xml )
    gen-toc-head dup dup children>>
    load-html-poem chapter-paths-ordered 8 <iota> zip 
    [
        [ first second '[ _ "src" ,, "toc-img" "class" ,, ] V{ } make [ "img" ] dip V{ } <tag> ]
        [ second "a" swap '[ _ number>string ".xhtml" append "href" ,, ] V{ } make ]
        [ first first 3 head* V{ } swap suffix ]
        tri
        <tag>
        [ "li" V{ { "class" "toc-entry" } } V{ } ] dip suffix <tag>
        swap over children>> swap suffix >>children V{ } swap suffix
    ] map
    [ "ol" V{ { "class" "contents" } } ] dip <tag>
    [ "nav" V{ { "id" "toc" } { "epub:type" "toc" } } V{ } ] dip suffix <tag>
    [ "body" V{ } V{ } ] dip suffix <tag>
    suffix
    >>children
    drop
    ;

: gen-ncx-head ( -- xml )
[[ <?xml version="1.0" encoding="UTF-8" ?>
<ncx version="2005-1" xml:lang="en" xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
]]
    string>xml
    dup dup
    children>>
    V{ } "head" V{ }
    V{ } "meta" V{ { "content" "isbn" } { "name" "dtb:uid" } } V{ } <tag> suffix
         "meta" V{ { "content" "48" } { "name" "dtb:depth" } } V{ } <tag> suffix
         "meta" V{ { "content" "0" } { "name" "dtb:totalPageCount" } } V{ } <tag> suffix
         "meta" V{ { "content" "0" } { "name" "dtb:maxPageNumber" } } V{ } <tag> suffix
    <tag> suffix
    "docTitle" V{ } V{ } "text" V{ } V{ "ABOSA" } <tag> suffix <tag> suffix
    suffix
    >>children
    drop
    ;
    
: gen-ncx ( -- xml )
    gen-ncx-head dup dup children>>
    
    load-html-poem chapter-paths-ordered 8 <iota> zip 
    [
        [ first first 3 head* [ "text" V{ } V{ } ] dip suffix <tag>
        [ "navLabel" V{ } V{ } ] dip suffix <tag> ]
        [ second dup "content" swap '[ _ number>string ".xhtml" append "src" ,, ] V{ } make V{ } <tag> swap ]
        bi
        dup '[ "segment" _ number>string append "id" ,, _ 2 + number>string "playOrder" ,, ] V{ } make
        [ 2array V{ } like ] dip
        "navPoint" spin <tag>
    ] map
    "navPoint" V{ { "id" "cover" } { "playOrder" "1" } } V{ } "navLabel" V{ } V{ } "text" V{ } V{ "ABOSA" } <tag> suffix <tag> suffix <tag> swap suffix
    "navPoint" V{ { "id" "cover" } { "playOrder" "8" } } V{ } "navLabel" V{ } V{ } "text" V{ } V{ } <tag> suffix <tag> suffix <tag> swap suffix
    [ "navMap" V{ } V{ } ] dip suffix <tag>
    suffix
    >>children
    drop
    ;

:: gen-chapter-head ( chapter-head -- xml )
[[ <?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
</html>
]]
    string>xml
    dup dup
    children>>
    V{ } "title" V{ } [ chapter-head first , ] V{ } make <tag> suffix
         "link" V{ { "href" "stylesheet.css" } { "rel" "stylesheet" } { "type" "text/css" } } V{ } <tag> suffix
    [ "head" V{ } V{ } ] dip suffix <tag> suffix
    >>children
    drop
    ;

INITIALIZED-SYMBOL: :^) [ 0 ]

:: gen-epub-chapter ( stanzas-seq chapter-head -- xml )
    chapter-head gen-chapter-head dup dup children>>
    V{ } stanzas-seq [
        [
            second "img" swap '[ _ "src" ,, ] V{ } make V{ } <tag>
        ]
        [
            first [ [ [ "li" V{ } ] dip V{ } swap suffix <tag> ] map ] map concat
            [ "ol" [ :^) get number>string "start" ,, ] V{ } make ] dip <tag>
            :^) get 64 + :^) set
        ] bi
        2array
    ] map concat append
    [ "p" V{ } ] dip <tag>
    [ "body" V{ { "epub:type" "bodymatter" } } V{ } ] dip suffix <tag>
    suffix
    >>children
    drop
    ;

: gen-epub-chapters ( pages-seq -- )
    0 :^) set
     image-paths-ordered zip 6 <groups> load-html-poem chapter-paths-ordered zip 8 <iota> zip
    [
        [ second number>string "epub/OEBPS/" ".xhtml" surround ]
        [ first first2 gen-epub-chapter ]
        bi
        [ utf8 ] dip [ pprint-xml ] curry with-file-writer
    ] each
    ;

: gen-cover-head ( -- xml )
[[ <?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
</html>
]]
    string>xml
    dup dup
    children>>
    V{ } "title" V{ } V{ "ABOSA" } <tag> suffix
         "link" V{ { "href" "stylesheet.css" } { "rel" "stylesheet" } { "type" "text/css" } } V{ } <tag> suffix
    [ "head" V{ } V{ } ] dip suffix <tag> suffix
    >>children
    drop
    ;

: gen-cover ( str -- xml )
    [ gen-cover-head dup dup children>>
      "body" V{ { "epub:type" "frontmatter" } } V{ } "section" V{ { "epub:type" "titlepage" } { "class" "titlepage" } } V{ }
     "pre" V{ } V{ } ] dip
    suffix <tag> suffix <tag> suffix <tag>
    suffix >>children drop
    ;
    
: gen-back-head ( -- xml )
[[ <?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
</html>
]]
    string>xml
    dup dup
    children>>
    V{ } "title" V{ } V{ } <tag> suffix
         "link" V{ { "href" "stylesheet.css" } { "rel" "stylesheet" } { "type" "text/css" } } V{ } <tag> suffix
    [ "head" V{ } V{ } ] dip suffix <tag> suffix
    >>children
    drop
    ;

: gen-back ( -- xml )
    gen-back-head dup dup children>>
    "body" V{ { "epub:type" "backmatter" } } V{ } "img" V{ { "src" "img/self-abosa-mapped.jpg" } } V{ }
    <tag> suffix <tag>
    suffix >>children drop
    ;

: gen-container ( -- xml )
[[ <?xml version="1.0"?>
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
  <rootfiles>
    <rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml"/>
  </rootfiles>
</container>
]] string>xml
    ;

: gen-stylesheet ( -- str )
[[
.titlepage { font-family: monospace; text-align: center; margin: auto; overflow: hidden; }

.toc-img { width:100%; height: 20%; object-fit: cover; }

body { line-height: 1.5; }

body * { line-height: inherit; }

]]
    ;

: gen-epub ( -- )
    P" /home/inivekin/art/abosa/" current-directory set
    { P" epub/OEBPS/"
      P" epub/META-INF/" }
    [ make-directories ] each
    P" img/" P" epub/OEBPS/img/" copy-tree

    P" epub/mimetype" utf8 [ "application/epub+zip" write ] with-file-writer
    P" epub/META-INF/container.xml" utf8 [ gen-container pprint-xml ] with-file-writer

    P" epub/OEBPS/content.opf" utf8 [ gen-content.opf pprint-xml ] with-file-writer
    P" epub/OEBPS/toc.xhtml" utf8 [ gen-toc pprint-xml ] with-file-writer
    P" epub/OEBPS/toc.ncx" utf8 [ gen-ncx pprint-xml ] with-file-writer
    load-html-poem group-stanzas group-pages gen-epub-chapters
    P" epub/OEBPS/cover.xhtml" utf8 [ load-html-poem first-comment gen-cover xml>string write ] with-file-writer
    P" epub/OEBPS/back.xhtml" utf8 [ gen-back pprint-xml ] with-file-writer

    P" epub/OEBPS/stylesheet.css" utf8 [ gen-stylesheet write ] with-file-writer

    "cd ~/art/abosa/epub; zip ../abosa.epub -r *" system drop

    P" epub/" delete-tree
    ;

: display-cells ( -- gadget )
    load-html-poem [ group-stanzas group-pages image-paths-ordered zip
    6 <groups> ] [ chapter-paths-ordered zip ] bi
    [
        [ second [ second "USE: images.viewer.scaling P\" ~/art/abosa/" "\" absolute-path 3 head* \"jpg\" append load-image <autoscaling-image-gadget> 1 >>fill gadget." surround 1array ]
                 [ first 1array ] bi 2array flip ]
        [
            first
            [
                [ second "USE: images.viewer.scaling P\" ~/art/abosa/" "\" absolute-path 3 head* \"jpg\" append load-image <autoscaling-image-gadget> 1 >>fill gadget." surround 1array ]
                [ first [ >array [ 1array ] map 1array ] map 1array ! iter-stanzas 
                ]
                bi
                2array flip
            ] map flip
        ] bi
        swap prefix
    ] map
   json-matrix>cells f >>pair [ grid>> [ [ startup-metabolize ] each ] each ] [ <scroller> ] bi ;

MAIN-WINDOW: abosa-gui { { title "abosa" } } display-cells >>gadgets ;

