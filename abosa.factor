USING: grouping xml.traversal ;
IN: abosa

: image-paths-ordered ( -- str )
{
    ! "img/mr.spaceman.png"
    "img/st-damocles-the-shephard.jpg"
    "img/st-damocles-searches-for-wandering-aengus.jpg"
    "img/st-damocles-jumps.jpg"
    "img/st-damocles-in-gravitational-disorientation.jpg"
    "img/st-damocles-in-the-stomach-of-the-signal-eater.jpg"
    "img/the-hand-of-st-damocles.jpg"
    ! "img/st-damocles-abloom.png"
    "img/st-damocles-and-the-geometry.jpg"
    "img/st-damocles-amalgamates.jpg"
    "img/st-damocles-looking-round-the-torus-forest.jpg"
    "img/st-damocles-breaks-geometry.jpg"
    "img/st-damocles-frozen-over.jpg"
    "img/st-damocles-alight.jpg"
    ! "img/st-damocles-helmet-frozen-with-lantern.png"
    "img/st-damocles-leaves-the-c-zone.jpg"
    "img/st-damocles-tunnels-in.jpg"
    "img/st-damocles-uncrystalline.jpg"
    "img/st-damocles-read-only.jpg"
    "img/st-damocles-frees-aengus.jpg"
    "img/st-damocles-interred.jpg"
    ! "img/st-damocles-helmet-impaled.png"
    "img/st-damocles-entangled.jpg"
    "img/st-damocles-plotting-on-strings.jpg"
    "img/st-damocles-along-a-lyre.jpg"
    "img/st-damocles-as-pendulum.jpg"
    "img/st-damocles-fights-the-fall.jpg"
    "img/st-damocles-escapes-the-pull.jpg"
    ! "img/st-damocles-in-nightspore.png"
    "img/st-damocles-in-hibernation.jpg"
    "img/st-damocles-awash-in-gradients.jpg"
    "img/st-damocles-integrated.jpg"
    "img/st-damocles-imploded.jpg"
    "img/st-damocles-tesellating.jpg"
    "img/st-damocles-tesellated.jpg"
    ! "img/st-damocles-infinite.png"
    "./img/st-damocles-reinstalled.jpg"
    "./img/st-damocles-mooring.jpg"
    "./img/st-damocles-verified.jpg"
    "./img/st-damocles-on-tape.jpg"
    "./img/st-damocles-fatestring.jpg"
    "./img/st-damocles-rides-a-pulse.jpg"
    ! "img/st-damocles-helmet-tied-up.jpg"
    "./img/st-damocles-enters-the-pocket.jpg"
    "./img/st-damocles-meets-the-lantern-keeper.jpg"
    "./img/st-damocles-shows-what-is-there.jpg"
    "./img/st-damocles-internally-bright.jpg"
    "./img/st-damocles-written-out.jpg"
    "./img/st-damocles-surfaced-lightly.jpg"
    ! "img/st-damocles-helmet-open.png"
    "./img/st-damocles-with-blindsight.jpg"
    "./img/st-damocles-condensation.jpg"
    "./img/st-damocles-diving.jpg"
    "./img/st-damocles-impaled.jpg"
    "./img/st-damocles-powered-down.jpg"
    "./img/dragonfly-remains.jpg"
}
    ;

:: contents-list ( xml -- str-seq )
    8 <iota> [ number>string xml swap get-id children>> second last ] map
    ;

: chapter-list ( xml -- str-seq )
    [ "#" get-id "p" deep-tags-named ]
    [ "##" get-id "p" deep-tags-named ]
    bi
    append
    [ children>> [ tag? ] reject "  " join ] map
    ;

: title-page ( xml -- str )
    [ children>> [ tag? ] filter second children>> [ comment? ] filter first text>>
    "```" "```\n#v(1fr)\n" surround ]
    [ contents-list "#v(1fr)\n" join ]
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




#set page( paper: "a5", fill: rgb("#c5c8c6"))
#set text( font: "Iosevka", size: 7.0pt, fill: rgb("#1d1f21"))
#set par(justify: false)
]]

[[
#pagebreak()
]]
    surround
    ; inline

:: contents-page ( xml -- str )
    [[
#set text( font: "Iosevka", size: 15.0pt, fill: rgb("#c5c8c6"))
#stack(
  dir: ttb,
  image("img/mr.spaceman.png",width: 100%, height: 25%),
  image("img/st-damocles-abloom.png",width: 100%, height: 25%),
  image("img/st-damocles-helmet-frozen-with-lantern.png",width: 100%, height: 25%),
  image("img/st-damocles-helmet-impaled.png",width: 100%, height: 25%),
)
]]

xml chapter-list 4 cut
[
[ rest "highlight(fill: rgb(\"1d1f21\"), \"" "\")" surround ] map
first4
'[ "#place(top + center, stack(dir: ttb" , "v(15%)" , _ , "v(25%)" , _ , "v(35%)" , _ , "v(65%)" , _ , "))" ,
] { } make "," join
] bi@

[[
#set page( fill: rgb("#1d1f21"))
#stack(
  dir: ltr,
  image("img/st-damocles-in-nightspore.png", height: 100%, width: 25%),
  image("img/st-damocles-infinite.png", height: 100%, width: 25%),
  image("img/st-damocles-helmet-tied-up.jpg", height: 100%, width: 25%),
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
#set text( font: "Iosevka", size: 7.0pt, fill: rgb("#1d1f21"))
    ]]

:> ( a b c d e )
{ a b c d e } concat
    ; inline

: end-page ( -- str )
[[
#set page(columns: 1, footer: none)
#image("img/self-abosa-mapped.jpg", width: 100%, height: 100%)
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

: iter-pages ( page-seq -- str-seq )
    image-paths-ordered zip 
    [
        [ second "#set page(columns: 1)\n#image(\"" "\",width: 100%, height: 100%)\n#set page(columns: 2)" surround ]
        [ first iter-stanzas "\n" join ]
        bi
        2array "\n" join
    ] map

    dup length 2 / cut { "#set page( fill: rgb(\"#1d1f21\"))\n#set text( fill: rgb(\"#c5c8c6\"))\n" } glue


    "\n" join

[[
#set page( paper: "a5", fill: rgb("#c5c8c6"))
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
    load-html-poem dup dup
    '[ _ title-page
    , _ contents-page
    , _ group-stanzas group-pages iter-pages
    , end-page
    , ] { } make
    "\n" join 
    P" ~/art/abosa/abosa.typ" swap [ write ] curry utf8 swap with-file-writer ; inline
