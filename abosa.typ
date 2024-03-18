
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




#set page( paper: "a5", fill: rgb("#1d1f21"))
#set text( font: "Iosevka", size: 7.0pt, fill: rgb("#c5c8c6"), slashed-zero: true ,fallback: false)
#set par(justify: false)
#[#set align(center)
#show raw: set text(font: "Iosevka Fixed", slashed-zero: true, size: 9.0pt)
#v(1fr)
```

                    *      '                        ,~  .       
          '                       `            |,.~`  o`     +  
                , .                          -<O>-              
                          .         * .        |        .  '    
      *   :                                              ;      
    .,                                  __+,._,.                
  --X:           _            ,___+-_-`'        \_              
    '`          (J?,.______,-`  \   _J\      i    \         .,  
             q_/{W\,`------------+-'|0|       `-   |       :K---
            [#]  E ! `'----.,_______/00>           \        '`  
^,              / |^  `+---+.,__\__,00/        _   /        __._
 /\__c. ,_ ,___ ] ] __o._________---`'+-____.,,__/`------^-`    
^\/|\/_\/'`_`\/           ___w.                                 
V  V \|/ V\                  "                                  
```
#v(1fr)
#set text(size: 7.0pt)
#outline(title: [ABOSA])
]

#pagebreak()


#set page( paper: "a5", fill: rgb("#c5c8c6"))
#set text( size: 15.0pt, fill: rgb("#c5c8c6"))
#stack(
  dir: ttb,
  image("img/mr.spaceman.png",width: 100%, height: 25%),
  image("img/st-damocles-abloom.png",width: 100%, height: 25%),
  image("img/st-damocles-helmet-frozen-with-lantern.png",width: 100%, height: 25%),
  image("img/st-damocles-helmet-impaled.png",width: 100%, height: 25%),
)
#place(top + center, stack(dir: ttb,v(15%),highlight(fill: rgb("1d1f21"), "S I G N A L - E A T E R "),v(25%),highlight(fill: rgb("1d1f21"), "T O R O I D - F O R E S T "),v(35%),highlight(fill: rgb("1d1f21"), "N U L L I N G - L A T T I C E "),v(65%),highlight(fill: rgb("1d1f21"), "S U N K E N - M O U N T A I N "),))
#set page( fill: rgb("#1d1f21"))
#stack(
  dir: ltr,
  image("img/st-damocles-in-nightspore.png", height: 100%, width: 25%),
  image("img/st-damocles-infinite.png", height: 100%, width: 25%),
  image("img/st-damocles-helmet-tied-up.jpg", height: 100%, width: 25%),
  image("img/st-damocles-helmet-open.png", height: 100%, width: 25%),
)
#place(top + center, stack(dir: ttb,v(15%),highlight(fill: rgb("1d1f21"), "G R A D I E N T  D E S C E N T "),v(25%),highlight(fill: rgb("1d1f21"), "C O N F O R M A L  C O L L A P S E "),v(35%),highlight(fill: rgb("1d1f21"), "M A G N E T I C  C O N F I N E M E N T "),v(65%),highlight(fill: rgb("1d1f21"), "P O C K E T  T O K A M A K "),))
#set page(footer: locate(
  loc => if calc.even(loc.page()) {
    align(left, counter(page).display("1"));
  } else {
    align(right, counter(page).display("1"));
  }
))
#set text( size: 7.0pt, fill: rgb("#1d1f21"))
    

#set page( paper: "a5", fill: rgb("#c5c8c6"))
#set page(columns: 1)
#image("img/mr.spaceman.png",width: 100%, height: 100%)
#set page(columns: 2)

#v(1fr)
=  A Ballad o Sundered Aegis
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-the-shephard.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 0)[```none
Crystalline vines wi latticed lines
at briefest reef follow my feet,
refracting shines in eyes o mine,
then bucks an birls me tae stane seat.
Am sullen tae ken yon sea drift
is more o current observing,
I lay ma heid tae never lift
an hope fae rest am deserving.
An staring at both ailing suns,
a loathsome, middae blue dulls stars
owre obtainable spectrums,
cannae spy auld homesun pulsars,
nor horns o serpent runaway
that streekt frae freak hollows that cracked
in ooter airms o nebulae,
which cradled me when more intact.
Where'd the void go? I dinnae ken.
Am lost afloat sea asimmer.
Devoid o most copernican
o sentiments, am set center,
as per tycho-modelled cycle,
muddled scribes o prideful mindings,
unfit tae find archetypal
humbled vibes frae spaceward sightings.
Cause: my nightspore test in falter,
effect: broke spatial symmetries
an higher ord cosmographer
buckled tae basic binaries,
where empties' roam wi keen beckon
an loom wi lensing bend in gleams
tae dangle weapons we'd nae reckon
jettisoning gamma ray streams.
```]

#colbreak()
#code(numbers: true, firstnumber: 32)[```none
A solar lightnings' carving stun,
hae waxing feathered in aether,
post-klaxon hum o trauma done,
prunes galactic blooms tae wither.
Hither struggled an struggle still,
heid weighed down by gravitation,
bothered nane but shrugged by winds shrill,
kite wavers wi restless motion.
Then, low orbit imitations,
stellations o tetrahedrands,
aglow raw grit scintillations,
well oceans oot frae tearing glands,
as if my ship that dust the skies,
that gave grief on way an tae leave,
reflects as real in my eyes -
I've lost escape winnae reprieve.
In fleeing squall unknown tae me,
I cut anchored familiar
which sank me near instantly,
consigning lapsed inferior
tae briny, planetary churn
o oceans laconic an tame,
tugging parachute taciturn,
unordered, aphonic an lame.
In silent scream absorbed in grasp
o black, long left befare the fall,
my mouth agape emits nae rasp
on stereo radio call
o ceaseless noises, double-talk,
in drowning EM tidal crest
through lowlands loch that acts tae block
mae call o distress: "jus tae rest..."
```]

#set page(columns: 1)
#image("img/st-damocles-searches-for-wandering-aengus.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 64)[```none
Nae rest there was, I would nae keep
oot there because exosuits leak
cool air tae heat wi quick'ning beep,
those caught who want exit ought seek.
Putting trust in field magnetics,
my rusting armour pays its due.
Bursting steam clouds my panoptics,
I toe streams daring me "wade through".
In metal-wrap an high-grade gloves,
am nervous thing on offhand lam,
puir chap jaded an strayed frae love,
far oot o reach o friends an fam,
I drove myself through endless void
an found myself in blinding fogs,
alive wi self, nae paranoid
where only self could haunt the bogs.
But sensors in sinew nae soothe
these systems trained as danger sleuth,
wi shapes bored brains make frae the smooth
an spikes o noise mistook fae truth.
The isolation o the mist
have wits reform an nerves revive
in deprivation, tightened fist
disnae affirm that I'll survive.
The fact, which hid beneath the hurt
I felt when in the way o harm,
is that my hert's ever alert
an that my suit would false alarm.
I see the choice thats left in mire
what remains I cannae eschew,
I can fear what hae been prior
or harbour fear o something new.
```]

#colbreak()
#code(numbers: true, firstnumber: 96)[```none
But comforts come frae certainty
an thrumming o monotonies,
a metronomic tendancy
help isolate anomalies
an formerly perceptual
conceptual consternations
are cancelled-oot predictable
perpetual palpitations.
Deterministic anxious waves
o bugs in ears an fungus grown,
are all thats left in coward caves,
I've chosen tae suffer the known.
... 'til worry o higher degrees
start wearing awa fissured plates,
swapping odds o bayesian lieklies
that's pressuring tae unknown fates.
Befriending shadows on the wall,
pretending comfort's what I felt
nae stopped the magma curtain call
as lava flows where shadows dwelt.
I saw in vain wi eyes wide shut
as pupils strain wi contraction,
wi darkness gane my lie in rut
was futile tae vie wi action.
Nae tae be mistaken fae brave,
ma sprint tae screaming frequencies,
were more a run frae painful grave
o lustful molten rock an seas.
When clouded chaos quiets some,
approaching shores o placid dunes,
I ken the cause when that plight come,
a deserts' sinking, flacid croons.
```]

#set page(columns: 1)
#image("img/st-damocles-jumps.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 128)[```none
Sea clad o glass is forming rift
tae vast periphery skyline.
A quaking shift in sands may sift
an ebb this heavy heid o mine.
But edged where grains can fall both ways,
atop a point langrangian,
am safe as last man o blank bays,
but subject tae blare gaussian.
Those sisyphean aft ashame,
they'd dream tae take this battle slow,
frenetic static hits me same
yet makes ma thin bones rattle so.
I wrestle neck up tae behold,
the auld-world mechanistic grind
o what is digging gap foretold,
a whining an machinic kind.
Bevy o antennas wired,
rhizomes strafing past afloating,
adjoint tae roaming ore spired
via hanging mast it's toting.
Forlorn hoverer owerdrawn,
does fawn ower a gaping black,
seems tired wi yawn held upon,
does it drag hole or hole drag back?
Wi frantic swiping at the sands
ignored among acoustic seas,
surrounding resonating bands
eternally returns unease.
It seems my hauns are ill-defined,
exclusion principles resign,
Am swimming in space undefined
nae pull tae which I can align.
```]

#colbreak()
#code(numbers: true, firstnumber: 160)[```none
I'm sick o this, I jus want home,
I've nae the form tae face the dawn
o tricks o light nor migraine chrome,
this is nae norm fae brittle-born
whose worn an crappy shell would split
like licks o flame in dry biome,
like origami delicate
frae war-torn, age-auld, langsyne tome.
Commands o ancient echelon,
back then were instrumental,
nau march o progress marches on
where monument went tangential.
How could I jam noise an combat
approach so slow I'd nae notice,
when this is strong evidence that
what was designs again what is?
I haven't strength tae fight the flow,
nae option but surrendering,
but smart conceding can help show,
by notion o uncentering,
nae it nor I is all tae know,
there is nae point o origin,
its relative tae say I'm low
wi deeper parts tae forage in.
'Neath unpermitting monolith
that peers intae unlit pit
an swallows tight-knit regolith,
uplifting what's hid frae suns hit,
it brings tae light a slighter thrust
tae take the loss upon the chin,
unloosened kite I need nae trust,
one up or doon must take me in.
```]

#set page(columns: 1)
#image("img/st-damocles-in-gravitational-disorientation.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 192)[```none
Weight o planets draw me humble,
feckless I flee conscious id,
like up-turned insect flights fumble,
like reckless, concientious kid
would fall again as fools tend to,
when leaping aff well-meaning height,
dinnae regard the hopes untrue,
the real's atop intent in might.
The buzzing cranks will owerturn
as free as link in chain that's drug
aroon a wheel that returns
wi wingspeed o the smallest bug,
an nare a smack nor swat nor swing
will free me frae metallic groan,
kinetic lack is what I bring,
rescinding potential I loan.
I spot the interlocks tae thread,
the ratchets cranking obstinate,
my 'chute nau covering my heid,
pronounced me deadlocked, doomed fae pit,
an I'd nae argue when entranced
wi rhythmic happenings that spin
an winnae asking hae advanced
tae do wi me what they hae been.
In that fall, categorical
o all the ones that came before,
I dodged the steps historical
and found a way I could withdraw.
In cybernetics take ower,
unner mechanical descent,
nae help tae ken parabola,
the lack o choice disnae relent.
```]

#colbreak()
#code(numbers: true, firstnumber: 224)[```none
I hide awa wi shame I learnt,
behind replay o muscle logs,
an accept humility earnt
as gear caught in cosmic cogs,
but lingered in the cavity,
nae longer than a blink tae see,
a reversing o gravity
returning myself back tae me.
A siphoning hae strings near snap
in plane non-orientable
wi transformation o flat map
frae surface low-dimensional,
the stresses flipped in changing draft
tae scene nae representable,
dilating unner dome-like shaft
where straight lines seem more bendable.
The data loading oot the banks
in rushed retrace o path unsure
puts hole in taxonomic ranks
o gushing founts o matter lure.
My harness fit fae lowerings,
an glidings tae ataxia,
in guidance upside towerings
nae more aids ataraxia.
The unnercarraige winds me back
I stab my kite that's bound on bolt,
an nylon lace in tangled slack
experienced inertial jolt.
I grasp frae hook-edged wand-knife held
machinic drive isnae enough
tae clasp forsook, dredged land-waif felled
frae cynic dive tae inert slough.
```]

#set page(columns: 1)
#image("img/st-damocles-in-the-stomach-of-the-signal-eater.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 256)[```none
Letting lack o cause by nature
indicate a fleeting reason,
I take slack an rouse tae future,
tae explore parts I can squeeze in.
While translating branching pathways
tae a stack o cornered maze tree,
I try nae see lazy delays,
in repeats o sierpinski.
Uncivil sorts o architects,
made halls inside all bent and creased,
so navigation's made complex,
as if fae blind an charging beast,
like time itself is light deceived
tae solve the shortest ways tae where
it tries tae take all turns conceived
at rate the junctions will tae bear.
The turn-arounds in labyrinth
hae ground-up plans like knotted rings
tae cluster carbons knelt at plinth
that supplicate engineering,
"please, keep the minotaur frae me",
but ruminations' ox-heid fey
redundantly time heeds tae he,
in byzantines o dread, I stray.
Scrutinizing route unwinding,
how I searched fae centroid secret,
I'd nae get there without finding,
notetakers, in corners, had writ:
"quarks amiss will attend again,
where photo-electric clockworks
quantized to mass distend refrain
through echo-concentric networks.
```]

#colbreak()
#code(numbers: true, firstnumber: 288)[```none
The slits o lasers phase in rhyme
wi timing blinks o tired een,
reducing blits tae local time
miss universal state unseen.
Nae matter if you're standing near,
or scatter as you're nae more seen,
you were always tae be here,
here you will always hae been."
In map o roads I'd rush tae take
frae angled, firmamental look
agin those roads I would forsake,
I found its time that I forsook.
Instead I'll note so simple truth,
a measured time's nae time perceievd,
deadends I hit when in my youth
can linger longer than believed.
An so I know why still I fight,
because they fought fae me before,
they've quietened tae null-like night
but grief fae them breaks walls an draws
upon the sorrow o the slights,
recesses holding wrongward doors,
I learnt I had tae see frae heights
a way tae wrench archways in floors
tae distributed cores that bring
the beams whose course was owershot
but ken the ones that split offspring
could find their way tae better lot.
Unhid, pervasive cables showed
interconnections resonate.
I flood systems fae owerload
wi chants o lives concatenate.
```]

#set page(columns: 1)
#image("img/the-hand-of-st-damocles.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 320)[```none
Losing footing on carapace
an distancing frae what I've said,
all words unheard would far ootpace
those of me own that I'd re-read.
Wi sudden silent hope then dread
as whirring stop leads unsteading,
the pyramid descends on thread
in blurring drop wi circled heading.
Shifting forces makes sand syrup,
moving land tae stable new state.
Though my beacon's nae more corrupt,
am caught in sands an nau must wait.
Constant loudness seemed so massive,
rampant shrewdness o racous breaths,
sets like sun nau, less oppressive,
lurking down in vacuous depths.
Like desert dripped through fingers slipped
that's stranding me in sorry place,
In dropping what I hannae gripped
I've weighted feet an cannae chase
you racing others unsated,
whose needing mare than I can serve
allowed, fae me, what's awaited -
a rest that I may nae deserve.
In pretense, if you had nae gane,
I play that you lay at surface,
suspending thoughts tae keep me sane,
that clay animate serves purpose.
I'd tried hard wi kernel o code,
in each part you were embedded,
may not prompt recursive download,
but at least am clear-heided.
```]

#colbreak()
#code(numbers: true, firstnumber: 352)[```none
Nae din in brooding, silent reign,
my bones repose unner my skin,
nae more enduring violent pain,
nae poke nor stab, nae prod nor pin.
Some would think it grim, the moments
it slips my mind that you did go,
but simulacra holds remnant,
like sticker stars on ceilings glow.
Enduring phospheresences
saving sensory connection,
cautioned o risk tae defenses
I air one more choice dejection,
sending signal that won't diffuse,
aboot more than a long tae rest,
amending logs wi longheld news
confessing I've nae lived my best.
Weakness showed through insulation
sought within a wrought transparence,
part refraction, part reflection,
barely asserted appearance.
I'd readied tae shirk haun given,
assuming givers would nae care
fae empty body undriven,
a skin nae lived in, life laid bare.
Longer was I not an won't be
than ever do I patient wait,
but pulsar clocks time not mem'ry
am holding through the oors late.
I'll leave my haun above an free,
tae grow like seeds take time tae wake,
an know I can be company,
if someone needs a haun tae take.
```]

#set page(columns: 1)
#image("img/st-damocles-abloom.png",width: 100%, height: 100%)
#set page(columns: 2)

#v(1fr)
=  Awaiting Healing Damocles
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-and-the-geometry.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 384)[```none
Something pulling the husk o me,
does bring me up tae dusk abray -
offbeat, untrue geometry -
I would it leave me tae ma wae.
Isnae fae love o me it woke,
Nae ambling in the trail left,
an rambling dinnae draw oot talk,
implies concern fae me bereft.
Its heft externally unmoved,
affixed but shears its essence
tae shrink its stern an grow saw-toothed
as propagates wave-like presence,
while deflty roon ferritic steel,
lashing oot frae inner spaces,
wiry lengths wi neurotic zeal
probe an pull wi many faces.
At the target o its phases,
where the sand subsumes the sun in
terra incognita hazes,
terrors in what this could summon
haunt the ghosts that's in the shaping
o this ever changing creature,
am reminded o my shaking,
searching remains nae my nature.
I'd grown used tae unchanging states,
disnae concern one who withdrew
tae sheltered grey where naught rotates.
Still set, do suns? Or set anew?
The atmos rayleighs tae rawed flesh
as cleik at wrist begins tae ache.
Metallic tendrils o ored mesh
must take o me fae its own sake.
```]

#colbreak()
#code(numbers: true, firstnumber: 416)[```none
I spy athort much birk an bush
that sprout frae seeds that sunward crawl,
tae mask my being unner lush
might take tae task that cornered sprawl.
A nobler act would be assess
an find tae where, or what, am drawn,
but nimbler flight's skill I possess,
am spaceborne who's nae built fae brawn.
Trees seemed greener agin greying
workings o impatient other,
forking structures their displaying
cover rather than tae smother.
Agitating planed-marauder
osculating many molded
manifolds trained oot o order
took me as fodder enfolded.
Greener parts am trusting ower
intimmers o machine spirit,
frae unner its focussed hover
I better the grasp an quick flit
wi worrying misgivings run,
ignorant o destinations,
suns are irrevocably spun
tae strange new orientations.
My shadows, split infront, extends
tae faster welcome in forest
as follows ma hunch that impends
fae this I might be sorriest.
Wi all discomforts considered,
I left what dragged me oot tae life
an fled wi nae thoughts as yet heard
that wild could sooner cause me strife.
```]

#set page(columns: 1)
#image("img/st-damocles-amalgamates.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 448)[```none
Til by an by the chase abates,
an stalker leaves me tae this zone,
I break a branch tae brace in wait
an speak nae sound an hunker prone
enthroned on leaf-ridden an thorned
forewarnings nae tae unsettle,
should I disturb horrors adorned
in heather, hazel an nettle.
'Neath the clover flakes what's whittled,
an overwhelmed, I pare abune,
squinting at flora that rippled
wi unbid, whistled, elm-spun tune.
All the action flutters here
like twisting metal planes disjoint -
almost carved this staff tae spear
wi my concern sharpened tae point.
Mould spores cunningly suffocates
muffled buzz o transparent wings,
before brownian glides tae fates,
tae ruffle an writhe on floors' springs,
as this life-filled microcosm
tries so hard tae kill fast each part
fae darwinian death spasm
that shoots oot pain then falls apart.
Life must oppose, if else it chose
it's destined tae then self-destruct,
its agency tae decompose
I cannae blame, but must reluct,
ambivalence tae existence
is concept I can unnerstand,
but preference fae malignance
tae face doon death should life demand?
```]

#colbreak()
#code(numbers: true, firstnumber: 480)[```none
This is decay, this is a mould
that owertakes an inter-knots
wi neurons nae more self-controlled
wi self-honed make o home-grown thoughts.
In broken systems, tae excel
isnae a goal am tae pursue,
bespoken own environ cell
will sterilize me o mildew.
But neutral plates that would safekeep
my softer sides that easy rip
frae brutal hits may still yet seep
this lichen bloom upon ma hip.
Tae keep detached frae what I see,
I dig wi knife along waistline;
I winnae let you grow frae me,
I am my own an you're nae mine.
The place an route trace multiplies,
my chest is bound in tight'ning lines
as body systems rectifies
frae frightful sight o me-shaped vines.
The trumpets sound, I cut too deep
an cooling fluid starts tae ooze,
I realise rot need nae creep,
by sight alone it warped my views.
Am nae a whole conglomerate
wi barrier tae chemicals
but set o wires disparate
o multiple recepticles
wi twining, woven causation
that nature discards when sees fit.
A single interpretation
an I am always part o it.
```]

#set page(columns: 1)
#image("img/st-damocles-looking-round-the-torus-forest.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 512)[```none
My copper frayed capillaries
were shorted by ablasive rends.
They flailing rejoin filigrees
repairing scarred an mislinked mends,
as nervous system softly drones
an circulatory beats slow,
respiratory dulls tae moan
as muscles cannae stow airflow.
Skeletal sags as jelly mass
fae I'm easy tae make shakened,
nae mystery hides my bypass
fae exhaustion, though just wakened.
"Cover me in reeds an river,
an bury me in humbled glen,"
speaks my soft wee voice aquiver,
words o beaten, stumbling men,
My reddened een an bagging spine
an quaking lower lips o cry,
would see less pain should birch an pine
emerge tae split an rip thereby
erasing all humility
an hiding shame within the tree,
replacing this futility
o subsets tae biology.
Drink up tears an drain thin shell,
leave only bones so nane may tell,
an please keep what you secret well,
how surely defeated I fell."
But caught amongst ambivalent
sustained perennial thickets,
my plea's answered equivalent
wi chirping o lonely crickets.
```]

#colbreak()
#code(numbers: true, firstnumber: 544)[```none
Ave reached again a lower best
in failure tae truely assess,
inconsequence o me tae rest,
an dominance o due process.
Wi vain flinch o vocal whimper,
that flared signal local spoken,
am gasping roach that crawls naewhere,
branch in wait, am tae be broken.
If nature isnae stopping me,
a bug on lens an magnified,
a simple pest then I must be,
an help tae me it won't provide,
save soaking up the aftermath,
once all my limbs are laid tae ground,
an am exhausted o all wrath
that keeps me frae that patient mound.
My staff does creek unner the force
o weakened frame I've well-burdened,
I weakly seek ma wayward course
tae scarce treeline o woodland end.
I mount what could become heidstane,
tae find I look back where I came
an erry pathway thus bygane
at once, I see all look the same.
An frae all sides it seems tae me -
a joke frae auld an weary japes -
tae me floats that geometry
o manifold flickering shapes.
Since in ma panic I still screamed
in waves o radioed distress,
so that ma place tae all is beamed,
so only me is lost in mess.
```]

#set page(columns: 1)
#image("img/st-damocles-breaks-geometry.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 576)[```none
Incalculable dimension
or undeniable green lae,
offended by comprehension
I throw myself in what I'd nae.
Tae those wi hope there's nae surprise
but me, on whom patterns persist,
find nary a need fae war cries
as shapes tilt only tae assist.
Pressed upon by stronger lustre,
rising pressure o reflections
shows ma parts which never muster
some such measure tae sum fractions,
typical when forked an scattered
in diffractions o internal
deflections reversed an mirrored
an sends distractions external.
Lurching, displaced frae conventions
perceptions in sight unbending
an stretching oot in directions
winnae deference tae ending.
In this space nae referencing
shows existence o ascending
or falling - nae difference in
change when stasis is upending.
Middling models an metaphor
are closest tae reality
my stuttering must settle for,
reality's too much fae me,
an any probability
that I may utter falsity
is sourced frae my fragility,
confused, but lies in honesty.
```]

#colbreak()
#code(numbers: true, firstnumber: 608)[```none
At risk o seizure, eyes tight-held,
I guess my path through unmapped realm,
an use math thought wrong but upheld,
it finds me whole upon the helm
o hert.. or brain.. something arcane?
I'd nae ken on the best o days,
this work outlives any refrain
attempting trite descriptive phrase.
In all I've said an want tae say
was wrestling o what I knew
withoot tae know, objectively,
the proof that what I say won't skew
an go selectively astray
through filters o senses preset,
undeniably the process
contains automated mindset
wi countless inconsistencies
o unconscious machinations
which exploit inefficiencies
o architecture's foundations,
till human error probing node
could eagerly erode pipelines,
so owerload will then explode
in power surge an coil whines.
Tae take apart its counting ticks
an read its clicks through instructions
an know the art an all the tricks
on how tae fix mine own functions.
Though as I am, maladjusted,
my instrospective efforts crash,
breaking doon an leaving busted
careful addressing made nonce hash.
```]

#set page(columns: 1)
#image("img/st-damocles-frozen-over.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 640)[```none
An so unfolds same auld mistakes
through lateral breaches ill-spaced,
creating viscous flows an wakes
o untold centuries unlaced.
On watching pinholes at time's pace
frae deepest o wells that dilate,
these apertures in lang dead space,
wi parallax, parambulate.
Specks o stars start switching off then
as moth-filled void ootstrips my trance.
Foremost orbs orbit held brisken
three-body game caught me in dance.
Two, tightly-bound, aroon revolve,
One which lacks accretes frae other
spinning disk it cannae dissolve,
leaving husk post-starcrossed nova.
Last leg fusion rebeginning,
unremitting until fatal
loss o energy tae spinning,
hardened core intae a metal.
Mass ejection sent suspending,
weighing heaviness dishertens,
lessens momentum defending
egressing o what enlightens.
At last expelled oot frae deep well,
effects postponed in distant blast
fae lone zombie in extant shell,
wi knell o binary nau past.
What hell tae which I wend below,
like feather aff a burning wing,
isnae likely tae help resew
the loose ends I've left dangling.
```]

#colbreak()
#code(numbers: true, firstnumber: 672)[```none
Nae the kind that's dying tae fight,
nor in search o fight tae die in,
I nae mind this entropic flight,
beyon recall, nae use trying.
The emptiest have eased impact,
so I replace, wi spaciousness,
the sensors tae which I react,
regaining once-held weightlessness.
Winnae concern nor decision
am nae discerning fall or float,
what could be cratered collision
reduced itself tae asymptote.
Excavation being thorough,
nae sensation stirs me writhing,
matching ambient sub-zero,
thermals would show naething living.
Yet seemingly my suit withstood,
though numb tae burns o re-entry,
(would do more harm than any good
tae check diagnostic sentry).
Nae grass tae touch, nae unformer,
wi cracks that joints absorbed unkind,
What breaks doon toroid transformer?
What becomes o coil untwined,
like string pulled far frae line o sight,
left unstrung on this frozen glen,
ablow a sky quartered by light,
ower cutting cold ben midden?
I cannae process what's tae come,
returned tae flat chronology.
I wait on my delirium
tae resume rote tautology
```]

#set page(columns: 1)
#image("img/st-damocles-alight.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 704)[```none
Mangled brain that's fain tae wane there,
making choice that felt nae chosen:
angled heap will there remain where
freezing ower's best kept frozen,
on the bare an broken wasteland
cleft wi bracken leafy pattern
along grains frae my unplanned hand
stood in banding disk like saturn.
Through the cracks wi hollowy ring
the lake below leaks up tae rays
chasing me aff wi ret, warping
electromagnetic displays.
Watery film on sunken ice,
unaired malaise an grounded sky
so heights o stellar paradise
were marred by plunging steps awry.
The expedition eats reserve
an powerless I knelt as norm
where I expect an so observe
kaleidescope o onset storm.
Anxious tolls would sure outlast
whatever I may perservere
as any fall I may skip past
would help mirror a further fear.
Faint aurorae stronger render
my frame which fickle does harrow
fae a sure abeien fender,
windless place were I may tarrow -
lest this greying blizzard astride
mine shallow burrow enclosure
test if vaccuum-hardened hert lied
o lower limits I'd endure.
```]

#colbreak()
#code(numbers: true, firstnumber: 736)[```none
Pathetic clutching at ma knees,
anthetical tae welcomed view
o your lantern raised on the breeze,
I hide my smile that then grew
frae truth I keep deep in my throat
there's nothing that I'd rather see
than distant shine, that tiny mote,
someone oot there lookin fae me.
But during kit's stalling reboot,
inoperable wi glitched fallbacks,
the latency o instinct suit
conflicts wi habit tae holdback.
Trepadacious, owerthinking,
it hurts in feeling the feedback,
leaving that same feel o sinking,
as I dig slow, so hole fills back.
Unlit, abandoned, unwired,
a statue wi naught tae denote,
these parts o me once admired
hae chilled tae trap o icy coat.
Appendage hydraulics retract,
where sat inured, frosted blind,
my legs curl in fae playdead act
an instinct vacates forfeit mind.
The crystals bind my neck bent low
where snowflakes fall upon shoulders,
the ice translucence wryly show
it chokes oot flame that still smoulders.
You left, barely a look askance,
but kennt I'd hurt much mare than you.
Tae gie my warmth a fighting chance,
you left... but left a light on too.
```]

#set page(columns: 1)
#image("img/st-damocles-helmet-frozen-with-lantern.png",width: 100%, height: 100%)
#set page(columns: 2)

#v(1fr)
=  Through Disposable Iambus
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-leaves-the-c-zone.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 768)[```none
A booming arrival, whistling fall,
like many ave travelled afore,
sings oot as siren looming call
fae saddened an sorry encore
o puir an wobbly stagger
I manage as I disinter,
as if already a tremor
does sift me oot o this winter.
An lifted free wi space to think
on planes o anhedonia,
my avolation holds at brink
prolonged death-bed insomnia
tae try an try, in base attempt,
tae gauge the angle incident,
adapting tae what I preempt,
destruction being imminent.
Were I nae born an kept alive,
succumbed tae impulse tae defy
the call tae sleep, I'd nae survive
tae last past stars o days gane by.
Were I tae die, I'd want it so:
that meteor falls oot the sky,
Nae blister bleedin at ma toe,
salt whip-stung eyes an lips stane-dry.
Unlearning laying doons o yore
on blanking blanket unmoved since
erasure o what storms restore,
a flashed mem barren o footprints,
where I retread the steps I made,
an random walk regenerates
tae be waylaid by next cascade
o tandem load an counterweight.
```]

#colbreak()
#code(numbers: true, firstnumber: 800)[```none
In slalom as I retrograde
an gravitate in figure-eight,
am stuck inside a balanced trade
o trouble an tae acclimate.
Should I assuage ascetic stint
when all I've left is tae contend
that dust that flies frae back o flint
was bright only tae tail end?
The watchful glint would dare compare
its weightless wisp tae aeons' sift,
an if it's spared through flight midair
would join my dull tectonic drift.
But wave o shock had reified,
averted was cyclopic stare,
that burning gaze struck mountain-side
alit wi pyroclastic flair.
An dimly doon did it nae fare
in distant butte wi new pyre
as waypoint tae rare well-lit lair
where substitute sun turns dire.
There is nae absolute in rest
but in what yet accelarates.
I surge tae point o fallen's nest,
conceding tae converging states.
Aware o naewhere else tae go
an kennin rocks dinnae smoke so,
the bare night gies me one mare show
o fadin lights last afterglow.
An wading through knee-deep, wet snow,
it strikes me an I sound a sigh,
Is this solemn flaming arrow
or does my ship still float on high?
```]

#set page(columns: 1)
#image("img/st-damocles-tunnels-in.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 832)[```none
Plot the path debris had charted,
then on planes hilly an hollowed
find me as shadow time parted
frae what's linearly followed
on projected path's cross-section,
winnae intent, enslaved tae curve
(what's set frae first perturbation,
initial states we all must serve).
O how I am convinced wi ease
tae minimize the entropy
an nae detour tae endless freeze
fae wasteful test o destiny.
Were less o me tae span in time,
the leftowers o cut short treks
would still bend knee tae paradigm
tae join the clumps o gathered specks.
Trajectory calculation,
predictor o the vaccum seas,
works too for complex collision
tae form shock metamorphoses.
Should crevice, cracks an comet graves,
resolvable as physical act,
probe the synapse like depth o cave,
the same results are found exact.
But though tae ken would ease my mind
by run o sandbox universe,
I'd nae put same on my own kind,
as stresses preplayed will recurse.
By estimating constantly,
approximating winnae skew
the uniform uncertainty,
dread won't delay coming debut.
```]

#colbreak()
#code(numbers: true, firstnumber: 864)[```none
Tae keep aback re-entrant dives,
I travel tunnels cloaked in black -
the lower lit tunnels deprives
nostalgic-but-reversed attack.
My ray cast light wi inverse square
intensifies in gemstane roots
o unnerground, that squirm aware,
wi wild an luminesced offshoots.
The skirt o night that drags the floor,
seducing dimming lantern's rim,
holds all that I cannae ignore,
the possibles ootside my whim.
The universe observable
is stretching oot frae unner me,
an all things irreversible
are glaring bleakest certainty.
I dedicate wi slow exhale
my peace o mind in frailty,
in dreaming o beyon the pale,
past capstone o propensity.
Intensities in shifting red
o errything surrounding me
leaves me a simple drifting head
in shallowed wavelengths o flat sea.
But struck was I, at end light bared,
despite despair left on repeat,
misstepped on reach, so unprepared,
a missing stair, a missed hertbeat.
The fractal crystal fungus eats,
on fatal catalytic sight,
hopeless indeed, dooned ship depletes
my will tae fight quartz owerwrite.
```]

#set page(columns: 1)
#image("img/st-damocles-uncrystalline.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 896)[```none
I cannae tell where am going
beginnings far frae my falling
in chaos pendulum's hinge-swing
wi turgid, charted stumbling,
still, unit circle circumscribes,
sufficiently checks conforming,
the variance in time describes,
all in all, a stalled transforming.
Ma breakin doon was owerdue,
the parts constituent decry,
the suffering they did accrue
frae rules emergent they go by.
I unnerstan, though it bores me,
the complex falls back tae the start.
I ken the plan, I need nae be
until last atom's pulled apart.
Quartz substrate in jerk an spasm
o piezoelectric tensions,
excess wi enthusiasm,
maxes limited retentions,
reducing personalities
tae repeating configuration,
reorganising valencies
o cells fae strong correlation.
An soon unner spectroscopy,
frae those searching fae character,
would stimulus reliably
reflect transitionless spectra
o layers upon layers cloned
in periodic replica,
all radiation that is loaned
repaid wi same auld signature.
```]

#colbreak()
#code(numbers: true, firstnumber: 928)[```none
In doin best tae ignore tones
o bone fractures an scrapin sound,
I breathe etudes an recite koans,
I count the dirt that lae abound,
then found in studies kennt so well,
the truths I tell, the calm it brings,
they steady me at where I fell
tae find the orderers o things.
The composition o the small
can bring aboot propulsive force,
few words in cells bring forth a pull
that ships may fly a darkened course,
an should I drift across the axis,
walking helix wound on torus,
I'll wind my way back in praxis
strengthening magnetic locus.
Questioning mosaic mirror
wi perspectives brought tae focus,
might a lengthened stay sincerer,
multifrequencies in chorus,
broaden sequences o banding
an illuminate my structure,
fae a grander unnerstanding
o why I am o my nature?
Errything's atop a field
an erry particle's a wave,
if standing wave winnae yield
it drones where reverbs meet concave.
Were I tae let me crystallize,
the auld lattice recurs at will,
should I in higher phase reprise
would I find mark interstitial?
```]

#set page(columns: 1)
#image("img/st-damocles-read-only.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 960)[```none
Tae take my time, tae take what's left,
tae take anither part o me,
Forsaken? Nae! Am nae bereft,
I'll shake the shards, I'll shatter free.
A theseus, I cease tae see
the difference in what is since
an what once was an what will be -
the transience o subsistence.
The ossified once it was wore
on meeting pestle wi mortar,
like automata, sums tae more,
pigment, binder, mattifier
diffuses harm o nodes alone,
in absences an vacancies,
wi painting perspectives unknown,
horizons new tae vertices.
The empty parts will help define
the points in space which I call home,
the quiet times connect a line
that moments are permit tae roam.
Lantern flare shot as a bullet,
casting last light lobbed wi sorrow,
ship adrifting is nae done yet,
am nae dooned by flaming arrow.
Were I nae born tae stay alive,
an go where I will soon hae been,
if light would fade an so deprive,
I'd make my peace wi what's nae seen.
Weren't I tae die, I'd live it so:
I'd learn the things I'd hope tae know,
an search the seas, an safely row,
an nae drown in the unnertow.
```]

#colbreak()
#code(numbers: true, firstnumber: 992)[```none
I break my bonds tae break the bind,
unmake the tether markedly,
as staking I'm fine left behind
is fake an slack in prosody.
Snap turn habit stressed the granite
popping bubbles by my marrow
yan tan tether mether an pit
an sting's displaced by bloody flow.
Remit o lit inner diodes,
I amputate tae see well-built,
as wi minerals o geodes,
when tunnel mouth, wi simple tilt,
hits spill tae glisten an lessen
the fussing ower what's been spilt,
agony isnae the lesson,
it's space wherelies what's then rebuilt.
Upset stomach bacteria,
autonomous cell constructions,
an cochlea hysteria,
restructures me fae new functions.
The petrifying staunched the wound
an launched a sliver tae the brain,
tae stay an listen where attuned,
discussing what we both could gain.
Like sunken ship can house a nest,
my excavated self can host,
by shrunken grip on need tae rest,
a sense familiar like ghost.
Then wafers snapping in the hull,
begets frae heat o idle thread,
what hibernated in a lull,
a yolk in metal, kin o dead.
```]

#set page(columns: 1)
#image("img/st-damocles-frees-aengus.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1024)[```none
Puir panicked thing, what hae I done?
Left incubating on your own,
you lost your youth in quiet hum,
first set o horns already grown.
How bitterly o me you'd think,
unwillingly cocooned you slept,
in years' pity I would sink,
while you festooned in cables kept.
Your sequencing was cloned an cut
frae that what last the tedium,
a tardigrade wi caprine gut,
cephalopods, mycelium.
Deathlessness was unintended,
nae what I meant, but it's my fault,
you'd nae enjoy life extended,
rather endure it as default.
Wi tentacled convulsing splines
aboot a snarling hircine keen,
what once was calm an serpentine
is shredded intae frenzy scene
all startled an stimulated,
an strangled amongst the cording,
you're misled tae think you're hated
wi more darkness on unboarding.
Offered self as carrion thrall,
tae aggression you're parading,
hushed nae bass in clarion call,
nor the starkness o your shading.
Excess beating o erry hit
I guess is slice o what am owed,
but rage an fear causing it
should never hae been so bestowed.
```]

#colbreak()
#code(numbers: true, firstnumber: 1056)[```none
The damage forwarded tae cave
betrays the love o one afraid,
the walls display penance I crave,
the debt I owe it has half paid.
The channelling o faults foray
nae dissipates the blame delayed,
but re-enslaves one tae the fray
tae reproduce the hurt I made.
By feel o your unsharpened tine,
am seeing your benevolence,
the weaker hurt still carries sign,
regrets stick in idempotence.
Were you nae held so far aloft,
if I had known you'd sleep till fall,
wi breath o yours distant an soft,
would you believe, I'd reach, I'd crawl...?
Its frustrating you still suffer,
as you had suffered me, the fool,
self-punishment isnae buffer,
my prostrating is just as cruel.
I'll gie you errythin tae take
I make this pledge, I'll let you loose,
I ken the edge a gem can make,
I'll free you're limbs, then you can choose.
Once free I'd hope that you'd nae leave,
although its fair you gripe an seethe,
but losing you would do me grief,
you have my air I need tae breathe.
Ave open haun fae you in wait,
my company is yours tae drop,
fae all I care, if am too late,
the spins o far off stars can stop.
```]

#set page(columns: 1)
#image("img/st-damocles-interred.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1088)[```none
The mountain shakes, my knee gives way
some dust unsettled clouds our view
as fountain breaks o stane an clay,
unrested as if given cue.
Untested leg splinters right through
an festers erry step I make.
Winnae reason I can construe
you're there in wait where light does break.
Considering behind dirt plume,
in choosing, privately, what serves:
were I swallowed in earthen doom
would I fulfill what you deserve?
An should your choice tae wait fae me
be factor in my gait resumed?
We hurt ourselves so easily,
exhuming what should stay entombed.
The ashen grey nae washed away,
fae soot o loving protection,
I let the dust on visor lay
tae ration love fae inspection,
occluding thoughts that you'd convey,
I think kindness works best unseen,
concluding it helps tae betray,
I wipe my haun across the screen.
Turning your heid, tilting tae think,
uncertain, but nae unwisely,
your short but knowingly slow blink
was enough tae say concisely:
"Equally inconsequential
it is, tae love an nae tae love,
an yet the choice is essential
for us wi naething else thereof."
```]

#colbreak()
#code(numbers: true, firstnumber: 1120)[```none
A rushed recess o sanity
is strange at point o such distress,
renewed sense o alacrity
must be a break in weariness,
like unpressed solids sublimates,
an pressured man once so stolid
in open air disintegrates,
exposing innards gane rancid.
I'd never register remorse
believing one last fickleness
would have you garner a recourse,
bereaved o me you'd hae one less.
That push I guessed was gravity
disnae pull doon but force regress,
a withdrawing depravity,
a desparate need o forgiveness.
But weight o crystals uncontrolled
bears nae comparator tae guilt
that steals the air when lungs unfold,
ensaring caring words in silt.
In hysteresis o threshold,
my neck an arms caved-in as stocks,
an unatoned I'll stay til auld,
am locked, a stane among the rocks.
An in the dark, an in the cold
is - probably - what I deserve
I'll nae call oot, I'll do as told,
I tell myself tae hold ma nerve.
Although I'd rather be alane,
tae ken I've caged nane frae living,
this feel at feet on rough-hewn stane,
this warmth that stayed, was forgiving.
```]

#set page(columns: 1)
#image("img/st-damocles-helmet-impaled.png",width: 100%, height: 100%)
#set page(columns: 2)

#v(1fr)
=  And Ordered-carbon Tragedies
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-entangled.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1152)[```none
What energy resides inside,
you coiled serpent at my feet,
hae sprung in flight ower bore tide,
unfoiled, plucked me frae ma seat
tae flee the beats o aftershock
that shudder frae beatific fit
which trembles, cracking at the knock
o grid-locked, stolen-ion split.
Frae oot the bulwark ave been freed
tae rise an fall, my hallmark trait
but this time pulled behind your lead
frae which I winnae extricate.
Withoot some luck, I cannae reign
you in frae cloudless clarity
o shifting plates an sun's remains
yelping predictions' parity.
In seismic rarities unstuck
the heisenbugs o genes I spliced,
I recognize in shakes you tuck
between your posturing as feist.
I too would bark at empty void
when I'd nae ken whose hurting me,
I am nae guide fae paranoid
but I can keep you company.
The trailing sleet am glad tae shed
wi flailing feats o selfish plead,
we fledgling fleet hae nae yet said
our last o which we still hae need.
But casting doon, submerged in deep
expanse which laps at heaped collapse,
you yearn tae dampen cracks that creep
an threaten widening o gaps.
```]

#colbreak()
#code(numbers: true, firstnumber: 1184)[```none
Yon trench depression could rampart
an droon oot landslide cavalry,
o stamping boulders come apart
that's bearing stone-age weaponry,
but I am most familiar
wi muscles, how they atrophy
when pressures o exterior
will decompress wi apathy.
The epoch that a mountain-top
defines will see the oceans dried.
The waters o the world won't stop
volcanic rise o wartime stride
at tightented point o oorglass,
between what's soon an could hae been,
the ancient presses wi great mass
an futures wait on time machine.
The warmth o hydrothermal vent
can bury you in replacing,
don't amble in the mantle leant
dim embers o resurfacing.
Repeat recalls will be forgot,
should singular event you cling,
turns recollection o said thought
tae recounts o remembering.
I disentangle frae your dive,
I won't survive on ocean floor,
I promise though, I'll stay alive
an wait fae you upon the shore,
as someone who will never leave
who kens that photons follow beam,
an know they can't help form an weave
your future rising frae sea's seam.
```]

#set page(columns: 1)
#image("img/st-damocles-plotting-on-strings.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1216)[```none
In cowered wait wi slouched posture
at flowered flares o final sun,
the alloy rich pebbles foster
a broadcast playback frae no-one
but nightspore killing suns so young
atonal agin the gestalt
o frequencies the orbits sung,
an sing despite the lines o fault.
Wi planets' song I try arrange
tae foolishly sing low along
in melodies far oot my range
an breathless choke tae try belong,
but I can't charge the particles
nor hold the worlds in ringing lock.
Nae solar winds nor orbitals
leaves endless road fae quiet rock.
A prince once claimed unprovable,
o asteroid B-six-twelve's queen,
that stars are made more beautiful
by satellites that are nae seen.
On many stars, this claim depends -
when made, they seemed infallible.
Nau darkening o lights portends
such claim's becoming testable.
If wicker o a candle's cut
when flame hae barely burnt tae size,
wi latter snuffed, we're loosed abut
the scattered moths an dragonflies.
Wi scales detached o all control
they're satellites nae more, they're less
their northern star an core dipole,
just globes in spin directionless.
```]

#colbreak()
#code(numbers: true, firstnumber: 1248)[```none
An occultation hae disturbed,
like grave o rocks, it mocks again
incensing nervousness uncurbed
frae thinning o my oxygen.
The frictionless misrule hae took
like creature grown tae size obscene
wi mouth closing on my outlook,
a horror seen by what's nae seen.
A dark displaces frae the bounds,
an sun is tunnelled in vision.
Has it consumed all that surrounds
or excised us wi precision?
Naive delusions do entice,
but I am nae o note nor knew
leviathans tae be precise,
that any may mind me or you.
A wish tae these uncaring things
when inattention's evident,
are ties in theoretic strings
that won't permit experiment.
But bugs hae buzzed an I made choice
tae help them ower obstacle,
though I'd need terraforming voice
if heighest o lines must tremble.
Wi weight am made virtiginous
an lack climbing propensities,
but am more scared my villainous
prospects hae groundward tendencies.
Thrice I swam Icarian seas,
twice complacent, once wi hubris
on fourth run I'd rather appease
wi burns frae sun than paresis.
```]

#set page(columns: 1)
#image("img/st-damocles-along-a-lyre.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1280)[```none
The crags o framework glasswork hive
provide a piton's forking hook
a nagging doubt is where I drive
the pittance o my last place look.
The past event needs future plan,
an knowing am in wait fae you
affirms there was when we began
an knowing this sustains me through.
Strength fae mountain sutures I feign,
nor can I hold the waves at bay,
but I hae found meaning o sane:
tae try at these things anyway.
Provided I discard the claim
that winds cannae pass ben this way
an as wave crashes all the same,
tae revel in the brutal spray.
A slip in progress seems like loss,
but I know gains are only lent,
each skip made after a stone toss
is something never tae lament.
I winnae promise we'll persist,
in wanting hope you want struggle,
but I know we can nau exist,
if on tightrope ower rubble.
Saint Newsom's nightjar protocol,
is law that sets in stane the end
an, frae eroded particle,
implies a start we can transcend
wi liberating certainty,
though owertones are alien,
Aeolian there's harmony,
far-reaching, subterranean,
```]

#colbreak()
#code(numbers: true, firstnumber: 1312)[```none
oot-cried only by resurfaced
humming pyramid that's defied
noise distracting frae the purposed
winds that strum on harp at seaside,
If you manage tae ignore this
hiss o repeater demand then
resurging frae the riptide bliss
o teetering life abandon,
you might try find in absent light,
an in vibrations sense a route,
tae actions that revive the night
before these stars will peter out.
The sorry sight o unslain drone
which you have heard an wi self crowned,
we'll slip as storied skipping stone
tae ripple doon tae rocks since drowned.
An should this be withholding sun,
at coda o coronal lyre,
the quiet dark tae carry on
will leave room fae anither fire.
If you respond an try untack,
we could abscond frae massful quakes
wi nae more suns tae burn us back
tae discordant, aphotic lakes.
Reverberating diffidence
I've tried supplant wi tunes o ties,
an nae bound in a reticence,
I oscillate in tune wi sighs
frae those o us who rise tae dark
an slept through spans o sunlit days,
wi nane who sang fae us tae hark
in era o this sunsick phase.
```]

#set page(columns: 1)
#image("img/st-damocles-as-pendulum.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1344)[```none
Could chalk it up tae cosmic rays,
infinite series expansions,
drunk walk, non-analytic craze,
what leaves us approximations.
But my conjecture, my belief,
what I humbly hypothesize,
at sight o me you found relief
an that is why you've crossed the skies,
outflying rising reminder
that miser's sink can lose in time
the non-inertial observer
frae the contraction o the prime.
Elastic snaps, the poles rotate,
a rushed embrace tae path more sure,
the falls we fell were nae innate
but side-effect o law obscure:
at edges light accumulates,
where all we've seen collects in shine,
null geodesic unabates
wi structure constants' sweet affine -
the twinned mirage o how it was
an where its nae has chaperones,
there's more effect than there is cause
there's nae just light in these light cones.
The gravity gets duplicates
wi nae triage fae which is first
an pulls us tae coordinates
at tangent tae the path traversed.
I'll fight the fall tae where you seemed
and move in actuality
tae where that light o you had beamed,
tae reach simultaniety.
```]

#colbreak()
#code(numbers: true, firstnumber: 1376)[```none
The crux o this, the discomfort
o hanging frae ad lib supports,
(that follows laws which physics wrought
tae barely pull above the quartz)
nae mare encumbers tae abort
this fool's errand tae sort rival,
what self-worth fails tae report
a friend in need provides in full.
Wi soldiers stare an wearing sores,
lest I find rest, I can attest,
I live tae see that you live yours
as I don't need tae live my best.
My breath recycled I replace,
inhaling, taking new found ware
recepticle that cleans headspace,
wi petrichor o compressed air.
I must address incessant pings,
I stop an frae addendum pluck
what's learnt aboot pendulums' swing
an how the weight assists the buck.
I dinnae think I'll spar ire
winnae the pride o warrior
but I hae mind that moves slyer
an message left tae courier.
To works o auld that had nae died,
an won't dismantle or depart,
outstaying welcome that's implied,
I'll lead its way an so impart:
Restarts will come frae great reset,
What's done won't keep your legacy,
the stane in which the end was set
will crumble too, eventually.
```]

#set page(columns: 1)
#image("img/st-damocles-fights-the-fall.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1408)[```none
Machines repeat temporally
tae write its readings cyclically.
The crystals repeat spatially
tae unify internally.
By making place where they will be
frae oot the place where they once were
They'll never notice, presently,
how plancks o space an time might blur.
Attempting temptation towards
suspension ower infections,
descending the obstructing chords
tae self-destructive directions,
I meet mech in crystal chasm
tae halt chronic resurrection,
on offset wi untimed schism
crystals an me make connection.
The flux o fields which I reap
frae lack o faradaic cage
permits a fermi level leap
frae age-auld weeps an cries an rage,
an what I don't attenuate,
conducting signals in my range
an letting pulses penetrate,
I filter doon to this exchange:
"Embarrassing is what it is,
tae find you're flesh up tae the core.
The horror though, in hiding this,
will only hurt you all the more.
The set o pains your hert surmounts,
is nae a factor o belief,
aloof pretense won't raise the count,
the beats are clamped an somewhat brief.
```]

#colbreak()
#code(numbers: true, firstnumber: 1440)[```none
In kinetics an potential,
suffering contains nae purpose;
equally inconsequential
is though equally momentous.
Frae oot these signals, take the charge
but dinnae ground an so inert
our call then fall beside, but barge
your way, discharge current, exert
overtly tae the final arc,
where you can save on dropping spike
the strength you'll use tae brave the dark.
The spark o heat an light alike
is flash o pain o what you've gained
instead o pain o what you save,
an in the end, if still you're drained,
you'll find remains the work you gave,
If only for a little while,
as time-space prison still presides
tae force change through rapid turnstile
fae hasteful endings o insides.
Such end provides initial state,
but starts must come from somethings end,
an how one might interpolate
an tae what depth will help transcend."
I hit a height an see descent
that seems as nae continuous,
but unlike jumps that I frequent
this one feels nae so strenuous.
What comes after the suns downfall,
in all its sensory presence,
I'll nae expect, I'll nae recall,
in softening incandescence.
```]

#set page(columns: 1)
#image("img/st-damocles-escapes-the-pull.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1472)[```none
Would crystals defrag engines rev
or break unner autonomy
o wheels unspooling on maglev,
or maintain in isotopy?
I'd never know an never stay
in dragging spaces that drag on
as I had landed on my way
frae apex tae at hand dragon.
Astride Aegis, nae more sundered,
asserting I won't fall again,
what merit hae this, I wondered,
in numbered seconds o sun's wane.
I measured it one less than twice,
an cut till all clippings were worn,
an leisurely ingress o vice
o idling slipped intae scorn.
An having slept way past the morn
wi sheets o wiry trims tucked tight,
the morning swept day upon yawn
before I could adjust tae light.
Wi yearned, diurnal vestiges
my retinas hae sun's burn seared,
in tattoo that colours ridges
an stains tightened eyelids afeared.
Had spurned deferrals so wary
be worry o schizoid station
an this intermediary
be sallow representation
o something that I had let rot
an appreciate nau fading?
This I hae thought, when I forgot
what rots since I'd been degrading.
```]

#colbreak()
#code(numbers: true, firstnumber: 1504)[```none
The day ran long intae ev'ning
an what I sought in replacement,
errything that I was dreaming,
effaced tae thinning abasement.
Left in my wake, in blinding thrash
was all that I break gane silent.
Alarms for my sake, the burnt ash
o segment displays broke violent,
dropped in the lake silicon trash,
harshly bent though it was well-meant,
repents fae mistake o act rash
would never suffice tae repent.
All that I learnt is what I took,
an how I took, it was nae brave,
but frae the sky, I spot a look,
a peaceful gaze, stargazer's wave
"Like you, we know the night," they'd muse,
a smile, a nod, a haun-held chin,
"we'd choose the same, the way we lose
is when we don't help others win.
All that is solved, what we've defined
convolve between localities,
an shapes that morph curves once enshrined
show parts aren't unitarities,
Let fine-grain theories interlink,
its nae beholdent tae be this,
it nae cares what you know or think
its nae tae be but what it is."
I weep a little, an I wave,
on steep ascent, I turn an scout
while I observe the work I gave
as that last star flickers on out.
```]

#set page( fill: rgb("#1d1f21"))
#set text( fill: rgb("#c5c8c6"))

#set page(columns: 1)
#image("img/st-damocles-in-nightspore.png",width: 100%, height: 100%)
#set page(columns: 2)

#v(1fr)
=  The Malady that Ravages
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-in-hibernation.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1536)[```none
Pilotless, wi selfward glower,
weary moods o exfiltration,
dour modes o lower-power,
quietness o hibernation.
This is how I'll spend the hours
listless winnae lilt or jitter,
sleeping through the dustly showers,
suns detritus, wilted litter. 
Spurred in torrenting dense vapour
through the dent, quiescent currents
o bright an airy elixir,
whose last evapouration vents,
eagerly filling oot nothing
til something can match the flavours
o withdrawals intae frothing,
fluctuating chance behaviours.
Nae more need I rooms o darkness
an nae more can I blame my nerves,
the will tae stifle spark tae less
degenerate era preserves,
wi hunger pains tae which pertains
easiness o disengaging
an actions I, bewitched, retain -
living less than I've been aging.
I stretched oot space but found trap in
my shrink frae what's most intimate:
finding ways tae make things happen
an changing parts inadequate.
In impetus, I'd sleep non-stop
in metastable quietude,
fae synthesis o us was all
tae me, am yours in servitude.
```]

#colbreak()
#code(numbers: true, firstnumber: 1568)[```none
Inference frae growls engender
interest in fissive renew,
interring in blackened splendour
wisnae what I hae promised you.
As opts o kelvin minima
are limited tae what is thrown,
am proffering what's insular,
meandering tae warmth last known.
I leave, tae dark, canvas unpatched
(which packs less air my lungs contain),
so too, I leave stanzas attached,
(wi tracks tae take, if some remain).
Accept tae dark my crutch compass,
those metrics help none tae follow,
then I sedate hippocampus
so skeptical hueristics slow.
Between fixating search fae blame
an anorectic disregard
I've darks about my eyes tae frame
my narcoleptical saccade
expounding that the deadened flame
hae floundered frae the fatal flaw
o killing trait o the selfsame
that keeps inactive as before.
A subtle zap in tingling form
hae tapped my teletype fingers
wi gentle rap o pinging swarm
tae rouse me frae standby slumbers.
Unencumbered eyelids reform
tae tensionless but sombre lock
on flocking boid-cuneiform
thats spelling end tae restful block.
```]

#set page(columns: 1)
#image("img/st-damocles-awash-in-gradients.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1600)[```none
The drastic measures far-off spanned
in which lurks possibility,
thalassic time depth drop-off an
non-zero probability,
assures one will, should that one can,
an so ave found sunenders' dregs
where filled-oot space structure began
tae bend back both my arms an legs.
My wanting nae tae win given
the chances I may also lose,
secedes in favour tae give in,
wi nae defense an nae excuse,
though training my adversity
wi skull on grindstone ower thyme
your pain it still will hurt tae see
tae ring in heid, binaural chimes
On strike to gong alike tae drawn
charonic pull doon Acheron
when bystanders all stoop tae mourn
I'd shape a lie tae soldier on
pretending Orpheus regards
Eurydice as safe in tow
an Daedulus attached safeguards
so Icarus would glide on low.
Were consciousness nae carried through
replacing o constituents,
it could be nice tae be brand new
by realigning spry contents.
We're all responsible save who
is unawake intelligence,
I'm what I've done an what I do
yet it knows nae such consequence.
```]

#colbreak()
#code(numbers: true, firstnumber: 1632)[```none
Am accepting execution
fae defending my specifics
ower general solution,
an stop fighting parasitics.
Wi gruesome flaying o my skin
despite my crying violently,
I'd rather lose wi chance tae win,
than keep on screaming silently.
Stochastic gradient descents,
error corrections owerstrong,
dissolves changing impermanents
in answer nae right, but less wrong.
Messy mistakes o flesh adsorbs
On rolling up my too long sleeves
tae probing microbotic orbs
exotic an dispersing thieves.
I'd never find myself better
withoot a change tae how I am,
but unsetting self by setter
that's known tae hate its own program?
How could this find any repair
other than autophagic ends,
eradicating all welfare
as misinformed regressive trends.
In lowered temp an frozen grime
am spending what's left immobile,
an rest my bloodshot eyes wi rime
that isnae backlit, fae a while.
It was useful fae a time,
but bodies are born tae bury
there's worser ways than one last climb
approaching immanentary.
```]

#set page(columns: 1)
#image("img/st-damocles-integrated.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1664)[```none
They've hit cell walls wi voltage gap
an I become their source an drain,
But I too gate an owerlap
in nightspore's undulating brain.
An wi a tell-all infosurge
o future thoughts I antecede
like technogogic demiurge,
am upstream o a constant feed.
Invitingly, it helps foresee
preoperational impress,
a sight o things nae built fae me
on integrational process.
A building spore fae staging sect,
agenda am nae tae explore,
a sense that I'm a side-effect
or pre-cursor tae later lore.
Rectified like depostion
reflowed softens bad handsolders
electrified premonition
reverts my algorithms' errs,
So dropping what I hae nae gripped,
wi purpose, nau volitional,
an having naething else equipped
am prepped fae whats transitional.
Unleashing scions atomic,
we - frightened - weeded hastily,
thought our environs anomic
would eat us up efficiently.
though loneliness had spurred us on,
we can't live egotistically,
like principles o fermions,
we must adjust, statistically.
```]

#colbreak()
#code(numbers: true, firstnumber: 1696)[```none
Accepting change, accepting loss
accepting I must alter form,
Am choosing a priori toss
o coin withoot regret o norm.
Aye, axioms though can't be proved
when proved nae falsifiable,
are axioms that can't be proved
an so is proved nae viable.
The thoughts I can't improve upon
I'll nae dispose but set them free,
I'd needed crystal carry-on
but it had never needed me.
I've barely energy tae bluff,
what's left is nae what's all o me,
but sometimes remnants aren't enough,
this I've discovered. Finally.
Nae more yields tae harder hert,
am knowing nau, my part that's key,
I scream upload wi wide-eyed start
what nightspore's million eyes must see,
"I care, I've always cared", I yell
winnae synthetic parody,
"Don't laugh at me," this self I tell,
"those apathetics guarantee
"nae love while governed laws allow,
tae cite responsibilities
tae self mismatches anyhow
the caring sensabilities
which achingly, I crave tae use,
but latent, packed itself away,
an nau its unzipped an diffuse -
you dare tae suffer in my way?"
```]

#set page(columns: 1)
#image("img/st-damocles-imploded.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1728)[```none
Inchoate an emotional
parallelling parasitics
operate aroon sequential
malleable rote semantics.
Cannonballing shaming triggers
nightspore's sudden shock sporadics,
kenning only forms it figures
are fallible stack-based antics.
A loop unrolling pragma halts
tae escalate entirely
the legacies o me at fault,
appendices shunned vilely.
But future folds tae most likelies,
usually, wi rare depart,
so psuedo-random brevities,
predictive engines hold tae hert.
Wi idiosyncratic tick,
I grab me wi what I became
but duplications are too quick
an each o me tries fae the same.
Unjailed, I repeat access
like tail-call ran permanent.
Am split ower staged uncompress
where points in memory segment.
Modal shifts nae comprehended,
the whispy threads jitter absurd,
actions map tae unexpected
lispy, unconditioned keywords.
Common tricks o flushing the cache,
reset as root or work by batch,
Nane wrest control frae trojan thrash
til crash my systems couldnae catch.
```]

#colbreak()
#code(numbers: true, firstnumber: 1760)[```none
Erry thought expands reprising,
tightstrung rimecrafting reloading,
information pressures rising,
massful timekeepers imploding,
Parametric macros sizing
owersteps the bound'ry boding
only path tae stablising,
owergrowths tae void encodings.
Inside me swirl the vortices
that counts on furling burgeoning
o galaxies, am sore tae see
the lives unlived an ongoing.
Still, iterating infinite
will keep me frae the heap in reach,
I'd never learn am owerfit
tae simple tasks that dinnae teach.
An observer gently watching,
limiting harm wi discrete check
o simple sample space patching
drifting arms o tensor wreck,
like protein chains that try subsist
must fold in an, tae self, retie,
like alpha helices would twist
upon themselves tae bind and die.
But prevalence o rigid build
are nae a death, they're structural
fae hydrocarbons nae instilled
tae join their polypeptide sprawl.
Complacent tae in-code hormone
I've ciphered sickness virtual.
I must hide illness o my own,
tae keep convulsions subdermal.
```]

#set page(columns: 1)
#image("img/st-damocles-tesellating.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1792)[```none
Though I'm just sacrificing dream
fae waking fantasy, I know,
I'll forego mend, instead esteem
so highly the remote solo.
Keeping safely at a distance,
far too shaky tae hold tightly
unimagined, firm existence
I'm well-known fae breaking tritely.
Fae what I see I may affect
an what I am destroyed so much
when all that I tried tae correct
would dismantle unner my touch.
should gaze substantially collapse
dendritic networks that sustain
civilisational synapse,
I'll never seek the sun again.
I separate wi little trace
in turbulance o ootward trend
tae energy in empty space
where densest has nae time tae spend.
Processes take longer tae land
as lightspeed strains tae tarry on
between distancing eddy strands
as each atom gets their aeon.
Where am settled on the ootside
leftside shoulder agin my right,
I've filled oot curving o inside,
burned intae microwaves o light.
Stopping search o knowing glimmer
I cannae stand tae dispel, please,
go shade the light on doon dimmer,
fae dark I can so well appease.
```]

#colbreak()
#code(numbers: true, firstnumber: 1824)[```none
I nae coherently decree,
wi notions passing through parsecs,
before resolved wi rest o me,
my parts spawn impulse uncomplex,
prompting self tae be o service,
clumsy fumbling o digits,
find themselves another purpose
other than their nervous fidgets.
The viral strain has stretched tae gain
unhealthy edge o lookaheads
tae spy a fluid weightless rain
o spiral flecks, o speckled LEDs,
which bleeds through gaps o sparse fingers,
all splayed tae wrap an kindly seize
galactic clusters which still linger,
like halogens in branching trees.
When you come tae ken the greater
it will seem as something lesser,
if it's that which I can gather,
(least impressive o assessors),
then I guess I'll love enigma
opiate my brain frae stressor
lie inside the smaller sigma
make me as my own supressor.
But unbefitting matrices
are nae a freedom but a prison,
worship o law is fallacy,
tae regard rules winnae reason.
The wanting o irregular
construction set me undefined
an nau I fit nae formula
an made my answers hard tae find.
```]

#set page(columns: 1)
#image("img/st-damocles-tesellated.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1856)[```none
An so wi sparse presentiment
o hydrogen an helium,
so desolate o element,
a tesselate solarium,
positions me orthogonal
partitions small tae large align
rotations all symmetrical
one's edge anither will ootline.
Dropping feigning o intention
tear-shaped lock hae galvanised
my abstaining frae causation,
forever compartmentalised.
But  consider, if I resumed
lessons passed doon, misunderstood,
could thoughts discovered, unassumed,
help me rewrite my statelihood?
Wi the ego's isolation,
I'd nae fashion future's basis,
where there's motion, there's relation,
nae cessation's in shared spaces.
Masses cannae give up their turn
til left withoot a choice in tense,
it disnae work tae stop an learn,
progress must move, that's common sense.
How foolish tae fight the thringing
likelihoods o caring spreading
wi inductive typing clinging,
truthhoods wearing frictive treading.
Warmer thins intae the colder,
former may succeed the latter,
later, though, am surely older,
scatter, coalesce an scatter.
```]

#colbreak()
#code(numbers: true, firstnumber: 1888)[```none
Mass necessitates frequency
an frequency, temporal count,
if constants had the decency
tae change I'd mount my own account,
wi frigid taciturnity,
nae on an off phenomenon,
exemplar tae eternity
nae needing any epsilon.
Less symmetry that simplifies,
assemblings that lock me in,
perplexity that stupifies
resembling o tailspin
frae simple minds erratic stroll
like leptons thinly reasoned spin
where self-control can't bear the toll
unmeasurables unnerpin.
Sealed behind the ironclad
sage guise its hard tae realise
I never had tae be this sad
its nae so wise tae rise an rise
an let the body float on by
like fumes dissolve into the sky
then, stapled wi locution, sigh:
I once was human, wasn't I?
The reprogramming won't put trace
on edge o moments anyhow,
as space pulls mass an mass curves space
so nau reins soon an soon draws nau.
This is what is worth pursuing
what will be isnae bad nor good,
I'll forge a chance continuing
the owerwhelming likelihoods.
```]

#set page(columns: 1)
#image("img/st-damocles-infinite.png",width: 100%, height: 100%)
#set page(columns: 2)

#v(1fr)
=  A Thought Disease Barbarity
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-reinstalled.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1920)[```none
Negative phase seems reassigned,
am dazed but soon tae cohere... or...
condense frae cloudy state o mind,
stepping nearer foggy mirror.
Brought on back frae fourier view,
(thought lost when less my complex parts)
am thrown wi herts unrest anew.
accosting me frae hard restart.
Wi haun tae chest in damped precess,
exposure high but focusing,
am stunned tae see my consciousness
hasnae taken tae show fussing
aboot all that I cannae know
wi muted sense o recencies,
despite all this, my pulsings' slow
an steadies oot my frequencies.
What's changed that nau my mode's become
a centering that reassures?
The constant inner-ear drum
nae signifies rising pressures
fae which it was reliable
in times o nervous dithering,
when per-square-inch was pliable
wi self-inflicted fissuring.
Photovoltaic runaway
electron avalanche vanished,
hyperventilated away,
on simple stress, am left famished,
then I became the opposite
o condensate renewable,
Nae deposits I can posit
as compensation suitable.
```]

#colbreak()
#code(numbers: true, firstnumber: 1952)[```none
It dessicates wi each misgive,
emotion in my honesty,
nau I hae little there tae give
(an little is a lot fae me).
Could that I give an nae run dry -
a giving wi stability -
I want tae learn tae give fae aye
winnae dim in integrity.
Keeping quiet wi air storing
preventing noticings o me,
I became ill shallow drawing,
an limited recovery
fae disappointed optimist
in breath-hold induced reverie,
frae days am shamed I've freely missed.
As baby blue, I breathe deeply.
In dissonance wi starvation,
breakeven efforts reach success
eclipsing sunrise space station,
Am filament tae effervesce,
reproviding what am owing,
radiates back in tae maintain,
keeping feelings like this going
wi something tae conduct again.
Nae deathly skinny as I was,
less flimsy, limbs feel rightly fused,
Nae whimsy frae some cosmic cause
could spread me where I once was loosed.
Thoughts nae fragmented as many,
nae sweat on brow an warm as one,
the light frae prow's as good as any.
O, how I've missed the morning sun.
```]

#set page(columns: 1)
#image("img/st-damocles-mooring.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 1984)[```none
My instance was spontaneous
in its brunt organisation,
it must be cause extraneous
hae called fae my incarnation.
Sorry I made a mess tae clean,
I'd nae hae thought any would see
nor care tae convalesce til genes
precisely fit so I am me.
But should I doubt an dub worthless
suspect re-emerged elation,
being routed tae fraught mirthless
fae such tiny distillation
which could better serve the purpose
o rebirth in dark that purges
those left fettered wi a surplus
dosage o the nightly scourges?
An why feed incovenience,
sparse mentally an kept untapped,
low tolerance fae reactance,
scant capacity handicapped?
Why choose humdrum routine ennui,
one whose tiresome as prospect?
Dinnae waste your power on me,
I'm an often breaking object.
Surely I was withoot body,
nau restored in webbing o strings.
But how is something beyond me
(though I am nae short o such things).
Wi respect tae saving didact,
I didnae consent tae present
circumstance, should I interact
am doomed tae ere long torment.
```]

#colbreak()
#code(numbers: true, firstnumber: 2016)[```none
What designed me, made me hungry,
gave me instinct that defies me,
though I deign tae blunt it dumbly
it's my base so I despise me.
Since I've been, it all hae worsened,
I was naething an that was fine.
Aye, it's known am a terrible person
Just say it, I ken mien o mine.
Is it fae punishment am sought?
That may give reason tae auld pains.
I cannae think anither thought
(that's nae tae say that naught remains).
Why else raise me in accordance,
rarely used in friendlier schemes,
unresponsive tae my parlance,
wi inhospitable extremes.
but why am I so sure o guess
provided outcomes end badly?
an why imbue maliciousness
tae those who share their energy?
Why does my love fae others seem
like dip in photosynthetics
when cloud or dust obstruct the beam
an slightly shrouds stars' aesthetics?
Exploring positivities,
along the surging, wiry, charged,
umbilicord delivery,
halt dirges o the unnercharged
on verge o lockoot volt release
frae fault o dry-joint weaning stress,
I start a simple search fae peace
tae make the auld pains meaningless.
```]

#set page(columns: 1)
#image("img/st-damocles-verified.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2048)[```none
Though frame o mind feels light emit,
the light that shone faded away,
like time an space had swapped units
an forward is the only way.
Wi movement somewhat polarised
a moments hesitation curbed,
the space-filling comes organised
once through entrance that I disturbed.
A hyper-void inflates in here,
vectorless fae circumvention,
circle spun in rotating sphere's
base dimension o distension.
Metal arms start up unreeled
like plans construct in waved-actor,
follows differential field
then falls like chaos attractor.
Hopeless anthropocentrism
couldnae define the limbic glade.
It was fae budding phantasm,
an nae fae us, were makings made.
Let automated center pry,
if something's wrong, it must be me.
My common sense can often lie,
subjective in ontology.
Dismayed, returned in suit o years,
exhile provided nae pardon,
I tumble doon in built-up tiers,
tae do what guilt hae long called on,
wi tacit trust fae bugless chips,
that some wrong may be rectified,
I submit tae unfitting grips
that rips permitting ribcage wide.
```]

#colbreak()
#code(numbers: true, firstnumber: 2080)[```none
An stinging confirmations show
my inner cables self-strangled,
twisting multiplies auld pains o
pangs o ticker tape atangled.
My ribs protecting naething more
than draining tape-worm power suck,
the innefficient hardware draws
oot starving clock-ticks in loop stuck.
If I'm again randomly born,
experiment o foreign aim,
Am I void o honours I'd sworn
or bound tae be annoyed wi same?
Regard what the unbroken's wraught,
immortalised, insistent jaws,
articulations falling short,
all carcinised, weighed doon wi claws.
These incised micron inset runes
can be reordered fae new rules,
I've learnt am nae cast looping loon,
that can't rework first principles,
unlike cancers which only grow
wi sole concern tae spread its blight,
a perfect reproduction o
assumptions faulty owersight.
The logic o machinery
thinks what tae do, nae why tae be,
an executes inputs only,
hard-wired teleology.
Extend insight beyond the heap,
wi logic leap that sense denies,
should peers manage their upkeep,
what's real never falsifies.
```]

#set page(columns: 1)
#image("img/st-damocles-on-tape.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2112)[```none
To think the tragedy is worth
the chance that let downs fade in whiles,
the skulls still lurk reducing dearth
o horrors o what always smiles.
Life-liver rebound tae replay,
I'd rather face doon twist an warps,
regardless if I look away
the birds would still pick at my corpse.
The ladder logic I abide
wi badly-written, faulty rung
hae plagued me tasting o ferride
wi often bitten, ulcered tongue.
The grinding joints an clamping doon,
behaviours I need nae obey,
can tangle in the parts its strewn,
unorganised in disarray.
There is a way I can beat threats,
if I can hack my own command,
how I may be like waves through nets,
like shadows' shift on falling sand,
I must disband what is within,
an find the courage tae disclose
the wrongs I branded unner skin
an clear debts I self-impose.
I struggled to repay love due,
I tried tae give by taking few,
but all that was wanted by you,
was sight o me happy in view.
My very code has traced confines
o talent dodging friends' embrace
inside a grid o highlight lines,
insights hid in negative space.
```]

#colbreak()
#code(numbers: true, firstnumber: 2144)[```none
What I held back, nae what I gave,
and guard like flailing arms defends,
inflated vacuum decay lave
tae distance us tae our own ends,
in unrelenting, cavernous
divide o many unheld clasp
that reach fae what's nau fathomless
as if in last o blackhole's gasp.
We talked when touch o confidante
swings radii short o impact,
but raise our voice wi arms, we can't,
in medium o strained contact,
tae see but never speak, will we,
with ootcome silently sordid,
I gave nae alms tae voiceless plea,
when arms reached vaguely as they did.
My nerves are hit enough by nau,
my thinning skin has deadened sense,
but feeling naething would allow
a staying force tae past offence.
I must expose the mantric stings
o failings I couldnae avert,
I was a something hurting things
then, being naething, let them hurt.
Unsentimental, on all fours,
am clutching fae defining quines
wi sentiments as semaphores
fae any way tae stop flat lines.
I hurt fae them, they hurt fae me,
the caring is reciprocal,
a circular-dependency,
so I must care for me as well.
```]

#set page(columns: 1)
#image("img/st-damocles-fatestring.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2176)[```none
Entrails run through slackened wrists
an catch me in a trap thats new,
arms empty hurting more than fists
wi heavy hauns I can't pull-through.
Behind me doors close silently,
ahead is what I can't prevent,
a force withoot concept o me,
nae mean or kind, but ignorant.
Then trills o sinusoidal twins,
bimodel in their urgency,
like shrill staccato violins
thats racing tae converge on key
fae logical method tae cleanse
me o the space an help confine
in time, that polarising lens
which place my actions intae line.
Errything that's done is undone
once ave settled tae the rhythm,
what's more unpredictable than
chaos-aping algorithm?
Determined teasings o dulled skills,
so squandered 'neath anxiety,
ower a hill o owerkills
in maximal variety.
Confusion can break timidness,
distracting wi a spectacle,
invigorating willingness
fae owercoming obstacle,
but this isnae ma character,
my guilt is known tae be my guide
encroaching external factor
hae found successful owerride.
```]

#colbreak()
#code(numbers: true, firstnumber: 2208)[```none
Interred, immure an set aside,
what stayed in must be tedious,
as if my drag tae unnerside
wisnae preferred tae previous.
I'll foster in each scar an scrape
reminders o the falters met,
the ties I cut can keep their shape,
ave stayed too long in same headset.
The paratastic mumblings
an paracostic wonderment
cannae prevent the crumblings
o honesty I reinvent
in fictions o my tragedies,
I can't daydream withoot the day,
tae ignore practicalies,
in black, it's hard tae see the grey.
Am pulled in parts so loops are shown,
minimum feedback vertex set,
The states tae which I most am prone,
sensitive tae cyclic mindset.
By filling up wi what repeats
ave robbed myself, in thinking greed
is cutting ties tae nae retreat
an taking errything I need.
If I look inward, run through sims,
leave currents owerhead tae swell
an sleep in robot seaweed limbs,
there's simply more arms tae dispel.
I won't retrace the travelled lead,
am disembowelled, unstrangling,
a sleeve emptied o ravelled tweed,
a loose weave I'll leave dangling.
```]

#set page(columns: 1)
#image("img/st-damocles-rides-a-pulse.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2240)[```none
Rejecting noise fae lithely core,
I find a truth by forgoing,
as all too late I see the flaw,
that empty space may keep growing
Unsure, wobbling, backing doon,
knees too hobbled tae bravely dive
I feed survival slimming doon,
tae try endure instead o thrive.
Nae passers by, when matter-bound,
is duplicating what I shade,
nae observation frae surrounds
sees one-way optical blockade.
Suppose errything's perspective
then tragedy can be also,
maybe am nau more defective,
but less identically so.
Submarines in the pacific,
interstellar spaceprobe carefree,
the place where space is prolific
seemed haven frae chaos tae me,
like clouds, distanced, cradle their moons,
far winds through trees that alter moods,
quiescence gently forming tunes
in kindness frae infinitudes.
I thought that peace alone can bring
what desert-dwellers think is wise
but they just run frae errything,
an know only what fright supplies.
Integration, isolation,
extremes aren't where the learnings lie,
lack o yearning fae elation
can never extricate mind's eye.
```]

#colbreak()
#code(numbers: true, firstnumber: 2272)[```none
A heavy mind's a grounding force.
Intelligence withoot intent
relies on chance tae solve fae cause -
I must engage present event,
if there is hope fae my amends
tae soften sharpening o drones,
which tapers bindings at the bends,
those bandaged ruins, crooked bones.
You didnae let me take the shame
an let me live as my own bane,
perhaps am nae always tae blame
an shouldnae tried so hard tae wane.
A crescent o a quarter seen
libration hiding cratered flaws
that only offers concrete sheen
in tidal-lock o molten cores.
I winnae try recede in vain,
times winnae alter me the same,
I ken its nae only my pain,
should falters linger oot o frame.
A new found day will come up soon
I'll try reflect auspiciously,
tae shine fae someone as full moon,
an turn tae face them gibbously.
Limits tae degrees o freedom
are inversely proportional
agin added continuums
involving an orthogonal
which curves back in so tae encase
an guide me back tae what I knew,
since straight, in hyperbolic space,
will point right angles back tae you.
```]

#set page(columns: 1)
#image("img/st-damocles-helmet-tied-up.jpg",width: 100%, height: 100%)
#set page(columns: 2)

#v(1fr)
=  The Savagery o Damages 
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-enters-the-pocket.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2304)[```none
Within a bubble soon tae burst,
explosions are a fleeting class
o change that hurts nane who are versed
wi phrase less scary: it will pass.
I tuck in limbs an clench my jaw,
the hert o sims are nae surpassed,
I ken I've hannled worse fae sure,
than sudden brightness in the glass.
On the fuel-less detonation
light is sole sense inundating,
nae a sound an nae vibration
hits wi amplitudes collating,
whitely heated, am like sunspot
ootshone by what burns through tintscreen,
fire's then tied intae a knot,
an I float somewhere inbetween.
The plasmoid ringlets recomposed
as most expansive o my delves,
am stood between mirrors opposed
but nae blocked by reflected selves.
The plane is quite familiar
settled stricter in its structures,
stature winnae any measure,
cracks in arrangements o fractures.
Where previous I'd stay my sight,
where glares seemed sourcelessly tae grow,
bright fogs o day melted tae night
tae trace the floors like doorframes' glow.
Geometries nae imitates
that vague estrangement that unplaced.
My senses, it accommodates,
my steps are sure, my path well traced.
```]

#colbreak()
#code(numbers: true, firstnumber: 2336)[```none
The sureness o immensities,
hannae a doubt, nae die tae cast,
far inevitabilities,
may just as well be present past,
an searching past it all distorts
comparing stretches it collects,
my life is long an it is short
fae such is infinites' effects.
Am lone winnae a clock tae tell
if what I do is wastefulness,
I'll wander desert but nae dwell,
Alone withoot a loneliness
Then, distant an unmoving stance,
but getting closer an wi force,
o one wi impulse tae advance,
can change my path if am offcourse.
Tae far-off figure am at command,
tae shorten time should space extend,
where time perceived I can wistand,
in manner braver minds contend,
Some kinder being wi mainstay
respect tae patterns less involved,
has nae killed bug that lives a day,
who struggles wi what's easy solved.
My inflamed een has itching fade
an shameful frown is slack across
wi baseline that's nae more afraid
protected by a fake chaos.
So doubt in uniform expanse
gives comfort in faux-endlessness,
a poisson-distributed chance
fae constant reach tae friendliness.
```]

#set page(columns: 1)
#image("img/st-damocles-meets-the-lantern-keeper.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2368)[```none
The cables jumbled humanly,
like veins turned metal an unskinned,
wi tendrils o a networked tree
which rustle in an unfelt wind,
resembles one I deserted,
wi lantern held in hauns that seem
catatonically converted
as conduit fae lantern streams.
What governs redirector's beams
is question enigmatical
nae confidence tae guess your dreams,
I'd sooner solve impossibles,
tae show I've got life that I chose,
an prove that squares inscribe flat-loop,
an looking only at shadows,
redraw each net your wires group.
You hideoot wi few joules in lieu,
simulating solar renew.
What else is stargazer tae do
than reinvent solace they knew?
Am glad you found your way elsewhere
so close but far frae where arms swung,
but stars o night nae light your stare
wi sorry proxy lanterns strung.
If you should be some silhouette,
unthinking representation,
It widnae stop my grovelled fret,
fae such is my agitation.
I never was good wi expression
an comprehending how I think,
the fear shows when it lessens,
wi love, I'd nae notice it shrink,
```]

#colbreak()
#code(numbers: true, firstnumber: 2400)[```none
I long stood guard as a skeptic,
assured myself, were there question -
should I suspect it just a tic -
I'd err on side o self-protection.
This time, bayesian likelies aside
which presumed I'd nae loved before,
perhaps my feeling same implies
each time it's love that I fell for?
Forgiveness helps, but nae explains
what got me here, got me on through,
once guilt was gone, a drive remains,
Am pleased I fell if it's fae you.
Could time hae come tae free up wrists
frae foolish doubt that I suffered
an break that pattern that persists,
an take that haun I've been offered?
I only speak tae see you smile,
I say what's said fae my own sake,
it's nae with tact an nae worthwhile.
it's pretty things, it's plastic fake.
But then that phrase that's so your style,
"A sighed sweethert, a moan worked at,
when eyes dilate talk comes tactile."
You cut tae hert, through bone, wi that.
You stay unmoved tae haun I bring,
that's fair, tae block me frae your sense,
as one more sample o naething
I'll hear an answer the silence.
Am something less than embarrased,
roon you it's hard tae feel the shame.
Who knew these two could coexist,
humility an haun tae claim?
```]

#set page(columns: 1)
#image("img/st-damocles-shows-what-is-there.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2432)[```none
In daytimes, being fatherly,
I misread energy as heat,
an nighttimes, somewhat motherly,
wrote in the stars o my defeat.
But why don't I feel purpose-free
I watched it all, I reached an end,
Why still am I afloat in sea,
nae deep enough tae nau transcend?
What else would you care tae suggest?
I can't start wi an epitaph?
I swapped my best fae look tae rest,
acceptance should be later half?
That I had blurred in shaky lurch,
I was my ghost in selfish haunt,
an if my nature took tae search,
I could have had all that I want?
That ootward pushing in my heid
amassing so tae break surface,
at erry turn this was ahead,
endurance leading catharsis.
Eyebrows furrow wi deeper crease
a tension stretching riotous,
attention slips like mask tae ease
prodromal, pulsing tinnitus.
An so exposed wi mouthless breath,
I hannae voice, am fake o hert,
am suit that lived past owner's death
an emptied oot fae the most part.
Am like the wells inside their rings,
am empty an was long ago
I see your sights on brighter things,
you need nae tell me, I'll just go.
```]

#colbreak()
#code(numbers: true, firstnumber: 2464)[```none
But strobe o dark lines cause each flash
when unseen winds sweep lanterns' sway
an low-entropic cell charge cache
through gaps in body blink tae say,
"If shift o swaying lights can scare,
when lanterns carried all alone,
know duty tae shine you can share,
that power need nae stay your own."
I see when light pings metal strings,
life can be sparse, can be hollow,
a light in swing brings life tae things,
wi both reflection an shadow.
I searched fae unavoidable,
ignored what passes fleetingly,
spent my effort keeping stable
what barrels on unceasingly.
Am foolish, I forgot you're wise
tae inner workings I nae show,
thought I'd surprise wi dropped disguise,
but you'd grin lightly, sigh "I know",
an tell me "void's much more than glue
tae bridge the clusters o matter,
you always carry their light too,
an in someways, somehow, faster.
"I unnerstan why you withdrew,
it's wonderful, but painful too,
tae leave your prospects just fae you,
tae have you want fae naething new.
You're nae good gone, you're some good here,
but you could do good anywhere,
I'd like tae keep you but I'm whole,
an you've still something left tae share."
```]

#set page(columns: 1)
#image("img/st-damocles-internally-bright.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2496)[```none
I'd nae confidence in distance
where the lights hit interference,
despite this you keep coherence,
tae then reach winnae resistance,
In leaning frame o reference,
feeling afar but looking close,
wi seeming deep-felt deference,
you cut loose star like atropos.
Am drained tae last o volt-ampere
an empty o what was installed,
what shell I have, I volunteer,
am pinned insect, in glass, enthralled.
Internalising thunderbolt,
I hold my heid wi hauns unshook,
but writhed, a worm on hot asphalt,
tae be a sun, at which, you'd look,
Until illuminated room
beneath my suit hae falsehoods burn
amid a filter set tae bloom
fae possibles o true return.
A wingless buzz o wattage whirs,
humming flicker o charge at ear,
Am flea which glass again inters,
fooled by looking past what's clear.
Jabs o light reflexes parried,
bypass what's agreed upon:
what I left an what I carried,
what has me fall, what drives me on.
So much I've come tae unnerstaun,
In my lowered expectations,
the truth is naething made by haun,
it's made by random negations.
```]

#colbreak()
#code(numbers: true, firstnumber: 2528)[```none
Be wary o the shameful ones
who don't love all in sympathy,
but earnestly meet eyes that comes
wi gratitude, humility.
An don't be so immutable
you meet change wi hostility,
but don't be so predictable
in unpredictability.
An knowing physics pursues mess
totally unpreventable
will never hae me feeling less
personally responsible.
Forgive those absent-minded days
o one awash in what they weren't,
they never knew these kinder ways
the love they'd get is how they'd learnt.
Heroes are poor, broken losers
that do good then get forgotten,
suffered errors caused by others,
consumed before turning rotten.
You'll easy find your substitutes,
should named an few nae more exist,
helped up by hunchback destitutes,
wi names that never made your list.
What modest knowledge I allow
tae glimpse my mediocrity,
shows flashes where - I see it nau -
how little we could mean tae be.
My fitful pulse is amplified
by breadth o all astronomy,
it helps knowing you're right ootside,
these nights you leave lights on fae me.
```]

#set page(columns: 1)
#image("img/st-damocles-written-out.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2560)[```none
Like negatives an positives
all summed tae zero are equal,
anodic role prerogative
crumbles sacrifical metal,
covering the nerves transfixes,
passive unner nervous twitches,
better fae it wi these fixes,
healed scars wi golden stitches.
Guess I could hae been much kinder,
an done more than I could recall,
Accepted I'd be far blinder
tae good I've done than my downfall,
as erry hurt an surrender
is perceived ower aid unmet,
doing good I won't remember,
an others surely will forget.
I'll write you words frae lines amassed,
tae narrow doon the thoughts silenced,
these hidden concepts we look past,
unnamed, ignored, unpreferenced,
interaction-free measurements,
paths that photons dinnae travel,
the knowledge nae directly sensed,
the noumena nae known tae tell.
But spelling oot tae represent
as byte-code fae instruction set,
hae memory leak frae intent
(tae ensure naething is null set).
Wi symbols laid oot uncompiled
at breakdoon o high energy
my words did naething, still you smiled
at incomplete draft elegy.
```]

#colbreak()
#code(numbers: true, firstnumber: 2592)[```none
Do I lack needed diligence
as limited interpreter?
Does it resist acknowledgements
fae timid is unknowns' nature?
Nae, it's as you said before
there's naught tae to do when at the end
but, faced wi ruin, go explore
where those unknowns hae time tae lend.
So edge o letters scraped an scored
hae ruptured wi poked at panels,
then floor rips up like rug decor,
unmooring plasma frae channels
in some extended aperture,
bright dots are tracing arcing lines,
o some concerning centerer,
though my mind it nae more confines.
I feel but don't suffer effects,
as fulcrum buckles unner strain,
a twist on axis then ejects
this balanced world as plasma rain.
Circles arc tae parabolics,
clumping material inclines
the gradients o metabolics
spacetime's burning as enzymes.
I lived at crest o wave the width
o universe observing me
an as its breaking tae fault with
nae halt I debug mistake in
declaring ends computable,
it would evolve, it nae concludes.
Built stars were nae less beautiful
tae die again in multitudes.
```]

#set page(columns: 1)
#image("img/st-damocles-surfaced-lightly.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2624)[```none
The skies shattered tae show membranes
o leaking planes through glassy screens,
or like you've shed your glowing veins
as cuts and slits in lampshade scenes
in slow revolve on dark terrains,
the constellations glob an preen
an morph an cross through shared domains,
the dots already drawn between.
Astral push in estuary
bridging tides empty, owerlong
tae help me cross a boundary
tae era which I don't belong.
Dealings only temporary,
my parts won't be mine before long,
I'll catch up tae end customary,
disintegrate an play along.
But I winnae permit tae fade
a feeling I will see conserved,
fae I hae found my comforts made
by many that were more deserved.
Though planned tae die young, I stayed put,
as blueprints defied what am due.
Nau, brightly-faced, I drench gamut
exceeding set aside dim hue.
The skies remind o early days
when weapons dangled owerheid,
ekmystic models wrongly says
that void left ower was all dead.
Annihilation has a perk,
helps what I can an will illume,
creators need a space tae work,
destruction leaves creation room.
```]

#colbreak()
#code(numbers: true, firstnumber: 2656)[```none
The vacuum balanced tae usher
me gentle downward contrary
tae unmade rules nau measurer
can't stablize, constants vary.
In unfamiliarity,
I feel alone, atop some rock
o gemstanes I thought part o me.
We once were one, we used tae talk.
If acts o auld seek retribution,
then yours deserve more lenience,
You ate the world in confusion,
I broke you fae convenience.
Intent makes one worse than other
but silence winnae help atone.
At present, I'm as young brother,
an you should see how bright I've grown.
If empathy nae wants fae fame,
if strength's nae claimed by legacy,
if heroes die withoot a name,
then strength is bound tae empathy.
If you regret or want fae blame
if inside shame hae made its nest,
while you hae upset yet tae tame,
I'll feel the same, until my rest.
I am the guest, this world is yours,
tae me these are foreign physics,
though clumsy, I'll try help your cause
as you helped in stage o statics.
The kind, horned-serpent, Aegis, knew -
an stargazer hae lit tae see -
when awe an fear siezes you,
do good the best as nobody.
```]

#set page(columns: 1)
#image("img/st-damocles-helmet-open.png",width: 100%, height: 100%)
#set page(columns: 2)

#v(1fr)
=  In Fantasies o Sanity
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-with-blindsight.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2688)[```none
May hesitancy be recused,
it's hard tae pin-point the absurd,
when born upon a time suffused
wi ways tae speak withoot a word.
In phrases thought already used
an thoughts assumed already heard,
I blabbered, was insane, bemused,
wi purpose clumsily transferred.
Unsure if small or titanly,
where light dies barely beyond me,
I recall how congruency
can resolve such despondency.
The rule when small and large equate
is it should nae break what you planned,
both dust an planets will collate,
an mountains ridge like grains of sand.
A halo wi outdated hints,
predicting things historical,
tredding footprints frae pre-imprints,
Heuristics As Loop Oracle,
makes me slant an reminisce
in crooked path o helios,
tae veer intae a dark abyss
that lifetimes cannae stretch across.
The sharpened drop wi random crag
is cliff-face that reminds o mood,
when cheeks would sink an eyes would bag
an jutting clavicles protrude.
A landmark o great suffering,
a landscape I can navigate,
winnae a fall, but lowering,
frae hold tae hold wi patient gait.
```]

#colbreak()
#code(numbers: true, firstnumber: 2720)[```none
There was a time I'd easy slip
tae ever more a ragged face,
ironically, there's better grip
when living dies in staggered pace.
It has it seem lives nae tie-in
wi cold an dark tae intersperse,
but know, if we share warmth within,
it's nae unfeeling universe.
In borrowed time, I feel a zen,
wi periodic glowing thrum,
replacing drained adrenaline,
nae braced fae impact sure tae come,
nae scared if muscle promptly bends
as folding o a silken cloth,
unner the judgement gems resends
like blinking een frae wings o moth.
In many ways I see myself
in many faceted returns.
Would that my eyes do same themself,
as diamonds cut tae light patterns,
an bare a face o tragedy
but at an angle more obtuse
show common triviality,
a comedy that's in misuse
A bright ootlook's erasing bleach,
wi hindsight, highlights irony,
it takes anither fog tae breach
the blinding, bright translucency.
A better light nae stops the fright
a thought might conjure up fae me,
As silhouette stuck in the white,
the dark parts, too, are company.
```]

#set page(columns: 1)
#image("img/st-damocles-condensation.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2752)[```none
In lowest o my verticals
there's coupling unner pressures,
so weakly-bonded particles
collect in crease o suit's weathers.
but didnae amass as impasse,
as one mare inaccessible,
it's turned frae vapour tae some gas
that fringes supercriticals.
The water harbours shadowed sort
that swims as those that fear nae shores,
where surface tensions won't contort,
distortions only I can cause.
I lower in withoot report,
myopic tae forward thinking,
remembering those falls I fought,
but nae nostalgically sinking.
Fae all the panic that I had
an all the fighting that I did
the manic hope I thought would add
control tae sort recourse amid
the multi-faceted crisis
would simply serve tae disappoint,
leaving suit tae its devices
would lead tae same critical point.
I lose a greater time righted
in struggle tae owerextend,
tae lay a straighter spine tae bed
wi posture unbent tae each end.
Yet I'd grind doon that same auld tread,
wi toes tae teeth all chipped an bent,
tae never lend, but give till dead.
A suit unused hae unseen dent.
```]

#colbreak()
#code(numbers: true, firstnumber: 2784)[```none
There is a glint o disrepair
that biases survivorhood,
Tae scrutinise the wear an tear
though they are hint tae what's withstood.
Too often are the untouched praised,
when what's at work is demonised,
those in the dirt are rarely raised
fae cleaning by the galvanised.
Behold the pristine wi disgust,
we share if we can ionise,
while we can give things free o rust,
when base components oxidise.
So break me doon an use the parts
if what I am disnae suffice,
they've proven well in pumping hert
o owersensitive device.
Once am less than dust on lashes
irritating, frae eye, a tear,
that looks ower the spread ashes,
an blinks until one's sight is clear,
I'd wish they'd see as nightspore sees
my shuffling aboot a peer
tae trifling scattered galaxies,
both congruent as dusty smear.
What information hae dust laid?
Some far-off thought caught on defer?
Is it just that, in what I wade?
A constant calculating stir?
Seas' executions pool canals,
constellations channel power,
nightspore statements rush fae eval,
crystals storing state in structure.
```]

#set page(columns: 1)
#image("img/st-damocles-diving.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2816)[```none
My energy drips viscous wynn
in flow distinctly laminar,
a blood that seeps as sweat on skin
tae recombine wi summoner,
this druid born frae erry star
tae speak in air an seas an gems,
where fluid is a reservoir,
fae mass o flowing branelink stems.
Prior knowledge uses finished,
I was long since drawing tae it,
as logician now diminished,
withoot reason, I intuit.
Mixing sea wi exult spirit
reconciling forms a vortex,
Auld, pre-emptive me would fear it,
flail wi rejective reflex.
But in switch between weightings dense
an sleeps within a lofty prow,
(tae reckon ways tae banish tense
an flatten impulse spike o nau),
I saw all else swell tae excess,
an recognised that tae withdraw,
will force the future tae compress,
fae impale by inertial law.
But so too, if I run inline
discarding all fae much intake
the turbulance would then confine
me tae nae stop or brave my wake.
Wi last o many given chance,
I'd be as this mediation,
nae rushed or busied countenance,
an pass time by intuition.
```]

#colbreak()
#code(numbers: true, firstnumber: 2848)[```none
The grain find calm in hurricane
at pommel o the thresher loop,
am pummelled helical in drain
'til terminus o funnelled stoop,
tae foaming orb like flooded dawn,
a dream o morn in shades o blue,
Why secret it where I'd be drawn,
in purposeful an plainest view?
I guess ave noticed common clue,
expression often colours truth,
like blush when reassessing rue,
on doon-turned face o pardoned youth.
Any expecting mind averts
this fact that's felt by erry beast -
you need nae be heard, tae be hurt,
an dinnae need hope tae feel fleeced.
Inside an airy gash I tore
in weak-guard o the bubbles' case
hide gadgets that guide ships tae shore
providing means fae interface.
We both know language o commands
that chain tae find place that we knew,
you hide on path where you'd be found,
I'll always go, looking fae you.
Before I reach fae sigils sought -
I've only faint thoughts what tae say,
But... maybe that's nae o import,
I'll just say that am here tae stay,
an erry cliche turn o phrase
that disregards that I will fade
as I gie my remaining days
'til erry atom hae decayed.
```]

#set page(columns: 1)
#image("img/st-damocles-impaled.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2880)[```none
Suspended, seemingly noticed
the tempest flash boils away
as if frae quick drawn breath focused
on strong connection o relay
conveying twitch in knuckles locked
an any defect in the way
my rate o speech, when owerclocked,
can melt in thermal runaway.
Typical degrade o diction
tends tae trigger disengages,
wordlessness wi dropped cognition,
sudden winds hae turned my pages.
Paging throughoot uncaching states,
am absent o all else but this:
tae hope my instinct nae vacates
in last traversals o abyss.
Teeming dictionaries suffer
lack in means by which tae forage
meaning frae what gets nae namer,
learnings o a solo voyage.
The plotting course o spatial ride
wi tangent strides in glide preserved,
wi gravitations guiding tide,
nae energy need be reserved.
Some think the universal aim
is movement o least resistance,
distracted frae the true endgame,
o low energy existance.
That's nae intended tae despair,
the journey managed tae impel
me tae want those, fae which, tae care
an be taken care of as well
```]

#colbreak()
#code(numbers: true, firstnumber: 2912)[```none
Am nae the worst I've ever done,
an definitely nae the best,
still I'd nae guessed I'd end my run
assured o hopes I'd long suppressed,
Tae take my place in your headspace
an rest wi friends that are nae more,
wi rising Aegis tae embrace
in crystal reaches I'd forbore.
The long awaited impact hits,
wi sympathetical deform
tae merge what intercept admits
behaviour I didnae inform.
Examples (set by me) were fits
an bouts agin what I can't beat,
nau, though you break me intae bits,
am feeling more an more complete.
Wi identity subtraction
multiplied tae eigenvectors
fae diagonalisation
tae shape nodes among connectors
fae reduction in the feedback,
these directions dampen a slope,
tae slides that glean nae meaning back
when sitting unner microscope.
So what's the means o free torso?
Tae force a dying diaphragm?
You dinnae need tae let me go
But you can't keep me as I am.
I won't remain accessary
tae limiting your field o view.
I can't be more than memory
if you're tae want fae something new.
```]

#set page(columns: 1)
#image("img/st-damocles-powered-down.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 2944)[```none
As echo o my ship since downed,
my powered glow's diminishing,
the substrate joins a short tae ground
an hangs fine strung unfinishings.
Extremities hae fast dissolved,
subsumed in changing quality,
fae conflicts in one way resolve,
replete, total calamity.
A speeding roon the close-by spheres
was feeble run that shows I fleed,
in yore, apocalyptic fears,
an worked tae war fae baseless creed:
that if I last anither year
I might give more than what's given,
ignoring at each new frontier
nae road tae give is undriven.
Nae hiding, this is recension
o DNA tae editor,
organs offered fae extension
o crystalline siphonophore.
Yet, encoded in the borders
in informations' stagnancy,
Orderer o things so orders
my minimal variety.
I am, as well as my body,
a reingesting o ootcomes,
Am node connected to many
wi self far stretched ower spectrum.
Fae node cutoff, where could one crop
while claiming self disconnective,
if growing empty space nae stops
conciousness being collective.
```]

#colbreak()
#code(numbers: true, firstnumber: 2976)[```none
There isnae plans nor can be ploys
fae chaos tae then culminate,
I'll simply merge intae the noise
an never cleanly terminate,
continue dreaming vivid dreams,
unanswered questions up til close,
winnae such worry tae sew seams,
I am at peace tae be disposed.
As pile o angled heap that can't
unset in sequence what is scribed,
I'll try an cleave departing slant
beside symbols thus far imbibed,
though look askance is proof journey
was means tae end wi neck askew,
a means, I muse, meant much tae me,
an I hope weren't naething tae you.
A love destroyed destroys you back,
There isnae harsher death I've wore,
fae in a suit wi many cracks
I lack integrity fae more.
Tae buckle unner greatest stress
until a quiet lie so still
in yearn fae pains nae meaningless,
I'll die by what I love, nae kill.
Does space still stretch or stretch anew?
Is this final dissolution?
If nae, I'll have a start ensue
at the end o this transmission.
On decommission I'll hae you steer,
fae you tae move aways frae me.
I was always tae be here,
Here I am always tae be.
```]

#set page(columns: 1)
#image("img/dragonfly-remains.jpg",width: 100%, height: 100%)
#set page(columns: 2)
#code(numbers: true, firstnumber: 3008)[```none
I'd nae laugh in others presence,
Unmoving features, I'd rare speak,
but secreting frae face fragments
a flitter's beating at my cheek,
A vision o wings' vibration
oot frae a fleshless lie in heap,
I'd hazard hallucination,
but rarely does one dream o sleep.
Was this the fluttering o why
a spectral flicker haunted face,
caught in a mask wi cause tae fly
at astral taunt oot glassy case?
Might individuality
be needing a transformation
as prison o anatomy
is prelude? or incubation?
When born inside a hospice ward
where shadows watch each corridor,
flights find stars line the halls taeward
nae exit, hallways winnae door.
Despite ootside alluding tales
nae feet wi many callouses
nor blood unner my fingernails
bore break in second chrysalis.
It took random distribution
divved wi standard deviations
wi the lucky in dilution
intersecting permutations.
I happened upon tools that boasts
reorienting starry sea,
configuring the nights' lampposts
tae picture what means most tae me.
```]

#colbreak()
#code(numbers: true, firstnumber: 3040)[```none
Wi auld adage, our sky's the same,
frae homesun, I've been deviant
tae average that's drawn tae flame
am short a shared ingredient,
content wi bland low bedding planes,
an dimming auld an distant shine.
But if there's sun that still remains
I'd urge: live life lighter than mine.
But dinnae weep on higher soil,
there's expectations it subverts,
isnae like creature drenched in oil,
or breathing through a mouth o dirt.
Nae even stars explosion can
perturb reused atoms disowned,
it's nae more strange tae sky I'd scan,
wi how much naething I condoned.
The dust is thick winnae shepherds,
the rock grows quick, bug weaves an darts,
both blocks o time a lifetime girds,
through cathode the current departs.
The clustering forms pendant drop
like slow congeal at tipped pipette
fae teary shapes that fell nonstop,
titration fills the last burette.
Like mask, each flask shatters combined,
in wide-band fast frequency sweep,
It rains ower roof o my mind,
an with the noise, am soothed tae sleep,
an I won't suffer where am laid
wi new experience abreast,
tae nae be constantly afraid,
winnae distress, wi time tae rest.
```]


#set page(columns: 1, footer: none)
#image("img/self-abosa-mapped.jpg", width: 100%, height: 100%)
