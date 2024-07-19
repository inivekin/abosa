
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
            .           *                  +*              ,    
*.               '.                                       +     
      .                  .           .      *                   
                                   *                ,~  .   .   
;         '        +              `            |,.~`  o`     +  
   +            , .                          -<O>-              
   '   .                  .         * .        |        .  '    
      *   :                                              ;      
    .,               ,                  __+,._,.             *  
  --X:           _            ,___+-_-`'        \_   .          
 ,  '`          (J?,.______,-'  \   _J\      i    \         .,  
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
  image("img/mr.spaceman.jpg",width: 100%, height: 25%),
  image("img/st-damocles-abloom.jpg",width: 100%, height: 25%),
  image("img/st-damocles-helmet-frozen-with-lantern.jpg",width: 100%, height: 25%),
  image("img/st-damocles-helmet-impaled.jpg",width: 100%, height: 25%),
)
#place(top + center, stack(dir: ttb,v(15%),highlight(fill: rgb("1d1f21"), "S I G N A L - E A T E R "),v(20%),highlight(fill: rgb("1d1f21"), "T O R O I D - F O R E S T "),v(20%),highlight(fill: rgb("1d1f21"), "N U L L I N G - L A T T I C E "),v(20%),highlight(fill: rgb("1d1f21"), "S U N K E N - M O U N T A I N "),))
#set page( fill: rgb("#1d1f21"))
#stack(
  dir: ltr,
  image("img/st-damocles-in-nightspore.jpg", height: 100%, width: 25%),
  image("img/st-damocles-infinite.jpg", height: 100%, width: 25%),
  image("img/st-damocles-helmet-tied-up.jpg", height: 100%, width: 25%),
  image("img/st-damocles-helmet-open.jpg", height: 100%, width: 25%),
)
#place(top + center, stack(dir: ttb,v(15%),highlight(fill: rgb("1d1f21"), "G R A D I E N T  D E S C E N T "),v(20%),highlight(fill: rgb("1d1f21"), "C O N F O R M A L  C O L L A P S E "),v(20%),highlight(fill: rgb("1d1f21"), "M A G N E T I C  C O N F I N E M E N T "),v(20%),highlight(fill: rgb("1d1f21"), "P O C K E T  T O K A M A K "),))
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
#image("img/mr.spaceman.jpg",width: 100%, height: 100%, fit: "cover")
#set page(columns: 2)

#v(1fr)
=  A Ballad of Sundered Aegis
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-the-shephard.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 0)[```none
Crystalline vines with latticed lines
at briefest reef follow my feet,
refracting shines in eyes of mine,
to buck and birl me to stone seat.
I'm sullen to see far sea drift
extends the current observing,
I lay my head to never lift
and hope for rest I'm deserving.
And staring at both ailing suns,
a loathsome, midday blue dulls stars
over obtainable spectrums,
I can't spy old homesun pulsars,
nor horns of serpent runaway
that streekt from freak hollows that cracked
in outer arms of nebulae,
which cradled me when more intact.
Where go the void? Am I woken?
I'm lost afloat sea asimmer.
Devoid of most copernican
of sentiments, I'm set center,
as per tycho-modelled cycle,
muddled scribes of prideful mindings,
unfit to find archetypal
humbled vibes from spaceward sightings.
Cause: my nightspore test in falter,
effect: broke spatial symmetries
and high order cosmographer
buckled to basic binaries,
where empties roam with keen beckon
and loom with lensing bend in gleams
to dangle weapons we'd not reckon,
jettisoning gamma ray streams.
```]

#colbreak()
#code(numbers: true, firstnumber: 32)[```none
A solar lightnings' carving stun,
had waxing feathered in aether,
post-klaxon hum of trauma done,
prunes galactic blooms to wither.
Hither struggled, struggling still,
head weighing from gravitation,
bothers more than shrugging winds' shrill
wavering of kite in motion.
Then, low orbit imitations,
stellations of tetrahedrands,
aglow raw grit scintillations,
well oceans out from tearing glands,
as if my ship that dust the skies,
that gave grief on way and to leave,
reflects as real in my eyes -
I've lost escape with no reprieve.
In fleeing squall unknown to me,
I cut anchored familiar
which sank me near instantly,
consigning lapsed inferior
to briny, planetary churn
of tame oceans' laconic soak,
tugging parachute taciturn,
with lame, aphonic, coastal choke.
In silent scream absorbed in grasp
of black, long made before the fall,
my mouth agape emits no rasp
on stereo radio call
of ceaseless noises, double-talk,
a drowning EM tidal crest
through lowlands loch that acts to block
my call of distress: "just to rest..."
```]

#set page(columns: 1)
#image("img/st-damocles-searches-for-wandering-aengus.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 64)[```none
No rest there was, I would not keep
out there because exosuits leak
cool air to heat with quick'ning beep,
those caught who want exit ought seek.
Bursting steam clouds my panoptics,
I toe streams I dare to wade through,
putting trust in field magnetics,
my rusting armour pays its due.
With metal-wrap and high-grade gloves,
I'm nervous thing on offhand lam,
poor chap jaded and strayed from love,
far out of reach of friends and fam,
I drove myself through endless void
and found myself in blinding fogs,
alive with self, not paranoid
where only self could haunt the bogs.
But sensors in sinew don't soothe
these systems trained as danger sleuth,
the shapes bored brains make from the smooth
and spikes of noise mistook for truth.
The isolation of the mist
have wits reform and nerves revive
in deprivation, tightened fist
does not affirm that I'll survive.
The fact, which hid beneath the hurt
I felt when in the way of harm,
is that my heart's ever alert
and that my suit would false alarm.
I see the choice that's left in mire
what remains I cannot eschew,
I can fear what has been prior
or harbour fear of something new.
```]

#colbreak()
#code(numbers: true, firstnumber: 96)[```none
But comforts come from certainty
and thrumming of monotonies,
a metronomic tendancy
helps isolate anomalies
and formerly-perceptual,
conceptual consternations
are cancelled-out predictable,
perpetual palpitations.
Deterministic anxious waves
of bugs in ears and fungus grown,
are all thats left in coward caves,
I've chosen to suffer the known.
... 'til worry of higher degrees
is wearing pocked and fissured plates,
to swap the odds of bayes' likelies,
inciting me to unknown fates.
Befriending shadows on the wall,
pretending comfort's what I felt
did not stop magma curtain call
as lava flows where shadows dwelt.
I see in vain with eyes wide shut
as pupils strain with contraction,
with darkness gone my lie in rut
was futile to vie with action.
Not to be mistaken for brave,
my sprint to screaming frequencies,
was more a run from painful grave
of lustful molten rock and seas.
When clouded chaos quiets some,
approaching shores of placid dunes,
I know the cause when that plight come,
the deserts' dry, decrepit croons.
```]

#set page(columns: 1)
#image("img/st-damocles-jumps.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 128)[```none
The sea of glass is forming rift
to vast periphery skyline
with quaking shift of sands in sift
to ebb this heavy head of mine.
But edged where grains can fall both ways,
atop a point langrangian,
I'm safe as last man of blank bays,
but subject to blare gaussian.
Those sisyphean oft ashame,
they'd dream to take this battle slow,
frenetic static hits me same
yet makes my thin bones rattle so.
I wrestle neck up to behold,
the old-world mechanistic grind
of what is digging gap foretold,
a whining and machinic kind.
Bevy of antennas wired,
rhizomes strafing past afloating,
adjoint to roaming ore spired
via hanging mast it's toting.
Forlorn hoverer, overdrawn,
does fawn over a gaping black,
seems tired with yawn held upon,
does it drag hole or hole drag back?
I'm sick of this, I just want home,
I've no such form to face the dawn,
of tricks of light nor migraine chrome,
this is not norm for brittle-born
whose worn and crappy shell would split
like licks of flame in dry biome,
like origami delicate
from war-torn, age-old, langsyne tome.
```]

#colbreak()
#code(numbers: true, firstnumber: 160)[```none
It seems my hands are ill-defined,
exclusion principles resign,
I'm swimming in space undefined
no pull to which I can align.
With frantic swiping at the sands
ignored among acoustic seas,
surrounding resonating bands
eternally returns unease.
How could I jam noise and combat
approach so slow I'd not notice,
when this is strong evidence that
what was designs again what is?
Commands of ancient echelon,
back then were instrumental,
now march of progress marches on
where monument moves tangential.
'Neath unpermitting monolith,
I peer into unlit pit
which swallows tight-knit regolith,
uplifting what's hid from suns hit.
It brings to light a slighter thrust
to take the loss upon the chin,
unloosened kite I need not trust,
one up or down must take me in.
I haven't strength to fight the flow,
no option but surrendering,
but smart conceding can help show,
by notion of uncentering,
not it nor I is all to know,
there is no point of origin,
it's relative to say I'm low
with deeper parts to forage in.
```]

#set page(columns: 1)
#image("img/st-damocles-in-gravitational-disorientation.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 192)[```none
Weight of planets draw me humble,
feckless I flee conscious id,
like up-turned insect flights fumble,
like reckless, concientious kid
would fall again as fools tend to,
when leaping off well-meaning height.
Do not regard the hopes untrue,
the real's atop intent in might.
The buzzing cranks will overturn
as free as link in chain that's drug
around a wheel that returns
with wingspeed of the smallest bug,
and not a smack nor swat nor swing
will free me from metallic groan,
kinetic lack is what I bring,
rescinding potential I loan.
I spot the interlocks to thread,
the ratchets cranking obstinate,
my 'chute now covers up my head,
pronouncing me deadlocked dimwit,
and I'd not argue when entranced
by rhythmic happenings that spin
and without asking have advanced
to do with me what they have been.
In a fall categorical
of all the ones that came before,
why relearn what's historical?
I'd rather cognisance withdraw.
In cybernetics take over,
mechanical in my descent,
what help's knowing parabola
in trip I've no hope to augment?
```]

#colbreak()
#code(numbers: true, firstnumber: 224)[```none
I hide away with shame I learnt,
behind replay of muscle logs,
and accept humility earnt
as gear caught in cosmic cogs,
but lingered in the cavity,
no longer than a blink to see,
a reversing of gravity
returning myself back to me.
A siphoning has strings near snap
in plane non-orientable,
then transformation of flat map
from surface low-dimensional
has stresses flip in changing draft
to scene non-representable,
dilating under dome-like shaft
where straight lines seem more bendable.
The data loading out the banks
in rushed retrace of path unsure
puts hole in taxonomic ranks
of gushing founts of matter lure.
My harness fit for lowerings,
and glidings to ataxia,
in guidance upside towerings
does not aid ataraxia.
The undercarraige winds me back
I stab my kite that's bound on bolt,
and nylon lace in tangled slack
experienced inertial jolt.
I grasp from hook-edged wand-knife held
machinic drive is not enough
to clasp forsook, dredged land-waif felled
from cynic dive to inert slough.
```]

#set page(columns: 1)
#image("img/st-damocles-in-the-stomach-of-the-signal-eater.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 256)[```none
Letting lack of cause by nature
indicate a fleeting reason,
taking slack I rouse to future,
to explore what life can squeeze in,
while translating branching pathways
to a stack of cornered maze tree.
I try not see lazy delays
in repeating sierpinski.
Uncivil sorts of architects,
made halls inside all bent and creased,
so navigation's made complex,
as if for blind and charging beast,
like time itself is light deceived
to solve the shortest ways to where
it tries to take all turns conceived
at rate the junctions' will can bear.
The turn-arounds in labyrinth
have ground-up plans like knotted rings
to cluster carbons knelt at plinth
that supplicate engineering,
"Please keep the minotaur from me."
In byzantines of dread I stray,
redundantly heeding to he,
my ruminations' ox-head fey.
Scrutinizing route unwinding,
how I searched for centroid secret,
I'd not get there without finding,
notetakers, in corners, had writ:
"quarks amiss will attend again,
where photo-electric clockworks
quantized to mass distend refrain
through echo-concentric networks.
```]

#colbreak()
#code(numbers: true, firstnumber: 288)[```none
The slits of lasers phase in rhyme
with timing blinks in hidden screen,
reducing blits to local time
missed universal state unseen.
No matter if you're standing near,
or scatter as you're no more seen,
know you were always to be here
and here you will always have been."
In map of roads I'd rush to take
from angled, firmamental look
against those roads I would forsake,
I found it's time that I forsook.
Instead I'll note so simple truth,
a measured time's not time perceievd,
deadends I hit when in my youth
can linger longer than believed.
And so I know why still I fight,
because they fought for me before,
they've quietened to null-like night
but grief for them breaks walls and draws
upon the sorrow of the slights,
recesses holding wrongward doors,
I learnt I had to see from heights
a way to wrench archways in floors
to distributed cores that bring
the beams whose course was overshot
but know the ones that split offspring
could find their way to better lot.
Unhid, pervasive cables showed
interconnections resonate.
I flood systems for overload
with chants of lives concatenate.
```]

#set page(columns: 1)
#image("img/the-hand-of-st-damocles.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 320)[```none
Losing footing on carapace
and distancing from what I've said,
all words unheard would far outpace
those of me own that I'd re-read.
I'd tried hard with kernel of code,
in each part you were embedded,
might not prompt recursive download,
but at least I'm clear-headed.
With sudden, silent hope then dread
as whirring stop leads unsteading,
the pyramid descends on thread
in blurring drop with circled heading.
Shifting forces makes sand syrup,
moving land to stable new state;
though my beacon's no more corrupt,
I'm caught in sands and now must wait.
Like desert dripped through fingers slipped
that's stranding me in sorry place,
In dropping what I have not gripped
I've weighted feet and cannot chase
you racing others unsated,
whose needing more than I can serve
allowed, for me, what's awaited -
a rest that I may not deserve.
Constant loudness seemed so massive,
rampant shrewdness of racous breaths,
sets like suns now, less oppressive,
lurking down in vacuous depths.
No din in brooding, silent reign,
my bones repose under my skin,
no more enduring absent pain,
no poke nor stab, no prod nor pin.
```]

#colbreak()
#code(numbers: true, firstnumber: 352)[```none
Some would think it grim, the moments
it slips my mind that you did go,
but simulacra holds remnants,
like sticker stars on ceilings glow.
In pretense that you stayed unslain,
I play that you lay at surface,
suspending thoughts to keep me sane,
that clay animate serves purpose.
Enduring phospheresences
saving sensory connection,
cautioning risk to defenses
I air one more choice dejection,
sending signal that won't diffuse,
about more than a long to rest,
amending logs with longheld news
confessing I've not lived my best.
Weakness showed through insulation
sought within a wrought transparence,
part refraction, part reflection,
barely asserted appearance,
readying to shirk hand given,
assuming givers would not care
for empty body undriven,
a skin not lived in, life laid bare.
Longer was I not and won't be
than ever do I patient wait,
but pulsar clocks time not mem'ry
I'm holding through the hours late.
I'll leave my hand above and free,
to grow like seeds take time to wake,
and know I can be company,
if someone needs a hand to take.
```]

#set page(columns: 1)
#image("img/st-damocles-abloom.jpg",width: 100%, height: 100%, fit: "cover")
#set page(columns: 2)

#v(1fr)
=  Awaiting Healing Damocles
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-and-the-geometry.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 384)[```none
Something pulling the husk of me,
does bring me up to dusk abray -
offbeat, untrue geometry -
I would it leave me to my way.
It's not for love of me it woke,
No ambling in the trail left,
and rambling doesn't draw out talk,
implies concern for me bereft.
Its heft externally unmoved,
affixed but shearing through essence,
to shrink its stern and grow saw-toothed
it propagates wave-like presence,
while deflty 'round ferritic steel,
lashing out from inner spaces,
wiry lengths with neurotic zeal
probe and pull with many faces.
At the target of its phases,
where the sand subsumes the sun in
terra incognita hazes,
terrors in what this could summon
haunt the ghosts that's in the shaping
of this ever changing creature,
I'm reminded of my shaking,
searching remains not my nature.
I'd grown used to unchanging states,
it's no concern if one withdrew
to sheltered grey where naught rotates.
Still set, do suns? Or set anew?
The atmos rayleighs to rawed flesh
as cleik at wrist begins to ache.
Metallic tendrils of ored mesh
must take of me for its own sake.
```]

#colbreak()
#code(numbers: true, firstnumber: 416)[```none
I spy athort much birk and bush
that sprout from seeds that sunward crawl,
to mask my being under lush
might take to task that cornered sprawl.
A nobler person would assess
and find to where, or what, their drawn,
but nimbler flight's skill I possess,
I'm spaceborne who's not built for brawn.
Trees seem greener against greying
workings of impatient other,
forking structures their displaying
cover rather than to smother.
Agitating planed-marauder
osculating many molded
manifolds trained out of order
took me as fodder enfolded.
Greener parts I'm trusting over
intimmers of machine spirit,
from under its focussed hover
I better the grasp and quick flit
where worrying misgivings run,
ignorant of destinations,
suns are irrevocably spun
to strange new orientations.
My shadows, split infront, extends
to faster welcome in forest
as follows my hunch that impends
for this I might be sorriest.
With all discomforts considered,
I left what dragged me out to life
and fled with no thoughts as yet heard
that wild could sooner cause me strife.
```]

#set page(columns: 1)
#image("img/st-damocles-amalgamates.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 448)[```none
'Til by and by the chase abates,
and stalker leaves me to this zone,
I break a branch to brace in wait
and speak no sound and hunker prone
enthroned on leaf-ridden and thorned
forewarnings not to unsettle,
should I disturb horrors adorned
in heather, hazel and nettle.
'Neath the clover flakes what's whittled,
and overwhelmed, I pare abune,
squinting at flora that rippled
with unbid, whistled, elm-spun tune.
All the action flutters here
like twisting metal planes disjoint -
almost carved this staff to spear
with my concern sharpened to point.
Mould spores cunningly suffocates
muffled buzz of transparent wings,
before brownian glides to fates,
to ruffle and writhe on floors' springs,
as this life-filled microcosm
tries so hard to kill fast each part
for darwinian death spasm
that shoots out pain then falls apart.
Life must oppose, if else it chose
it's destined to then self-destruct,
its agency to decompose
I cannot blame, but must reluct,
ambivalence to existence
is concept I can understand,
but preference for malignance
to face down death should life demand?
```]

#colbreak()
#code(numbers: true, firstnumber: 480)[```none
This is decay, this is a mould
that overtakes and inter-knots
with neurons no more self-controlled
with self-honed make of home-grown thoughts.
In broken systems, to excel
is not a goal I will pursue,
bespoken own environ cell
will sterilize me of mildew.
But neutral plates that would safekeep
my softer sides that easy rip
from brutal hits may still yet seep
this lichen bloom upon my hip.
To keep detached from what I see,
I dig with knife along waistline;
I will not let you grow from me,
I am my own and you're not mine.
The place and route trace multiplies,
my chest is bound in tight'ning lines
as body systems rectifies
from frightful sight of me-shaped vines.
The trumpets sound, I cut too deep
and cooling fluid starts to ooze,
I realise rot need not creep,
by sight alone it warps my views.
I'm not a whole conglomerate
with barrier to chemicals
but set of wires disparate
of multiple recepticles
with twining, woven causation
that nature discards when sees fit.
A single interpretation
and I am always part of it.
```]

#set page(columns: 1)
#image("img/st-damocles-looking-round-the-torus-forest.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 512)[```none
My copper frayed capillaries
were shorted by ablasive rends.
They flailing rejoin filigrees
repairing scarred and mislinked mends,
as nervous system softly drones
and circulatory beats slow,
respiratory dulls to moan
as muscles cannot stow airflow.
Skeletal sags as jelly mass
for I'm easy to make shaken,
resumed exhaustion will not pass,
I'm wanting sleep though just woken.
"Cover me in reeds and river,
and bury me in humbled glen,"
speaks my soft, small voice aquiver,
the words of beaten, stumbling men,
"My reddened eyes and stooping spine
and quaking lower lips of cry,
would see less pain should birch and pine
emerge to split and rip thereby
erasing all humility
and hiding shame within the tree,
replacing this futility
of subsets to biology.
Drink my tears and drain thin shell,
leave only bones so none may tell,
and please keep what you secret well,
how surely defeated I fell."
But caught amongst ambivalent
sustained perennial thickets,
my plea's answered equivalent
with chirping of lonely crickets.
```]

#colbreak()
#code(numbers: true, firstnumber: 544)[```none
I've reached again a lower best
in failure to truely assess,
inconsequence of me to rest,
and dominance of due process.
Through vocal flinch of vain whimper
my local signal's loud spoken,
I'm gasping roach that crawls nowhere,
I'm branch in wait to be broken.
If nature is not stopping me,
a bug on lens and magnified,
a simple pest then I must be,
and help to me it won't provide,
save soaking up the aftermath,
once all my limbs are laid to ground,
and I'm exhausted of all wrath
that keeps me from that patient mound.
My staff does creek under the weight
of weakened frame I've well-burdened,
I weakly seek on wayward straight
a scarce treeline of woodland end.
I mount what could become headstone,
to find I look back where I came
and ev'ry pathway I have known,
at once, I see all look the same.
And from all sides, it seems to me -
a joke from old and weary japes -
to me floats that geometry
of manifold, flickering shapes,
since in my panic I still screamed
in waves of radioed distress,
so that my place to all is beamed,
so only me is lost in mess.
```]

#set page(columns: 1)
#image("img/st-damocles-breaks-geometry.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 576)[```none
Incalculable dimension
or undeniable green lay,
offended by comprehension
I throw myself in anyway.
To those with hope there's no surprise
but me, on whom patterns persist,
find nary a need for war cries,
the shapes tilt only to assist.
Pressed upon by stronger lustre,
rising pressure of deflections
reflects my parts which can't muster
some such measure to sum fractions,
typical when forked and scattered
in diffractions of external
distractions reverse to mirror
total reflections internal.
Lurching, displaced from conventions,
perceptions in sight unbending
and stretching out in directions
with no deference to ending,
rangily unreferencing
my existence in ascending
or falling lost difference in
change where stasis is upending.
Middling models and metaphor
are closest to reality
my stuttering must settle for,
reality's too much for me,
and any probability
that I may utter falsity
is sourced from my fragility,
confused, but lies in honesty.
```]

#colbreak()
#code(numbers: true, firstnumber: 608)[```none
At risk of seizure, eyes tight-held,
I guess my path through unmapped realm,
and use math thought wrong but upheld,
it finds me whole upon the helm
of heart.. or brain.. something arcane?
I'd not know on the best of days,
this work outlives any refrain
attempting trite descriptive phrase.
In all I've said and want to say
was wrestling of what I knew
without to know, objectively,
the proof that what I say won't skew
and go selectively astray
through filters of senses preset,
undeniably the process
automates a hopeful mindset
with countless inconsistencies
of unconscious machinations
exploiting inefficiencies
of architecture's foundations,
'til human error probing node
would eagerly erode pipelines,
so overload will then explode
in power surge and coil whines.
To take apart its counting ticks
and read its clicks through instructions
and know the art and all the tricks
on how to fix my own functions.
Though as I am, maladjusted,
my instrospective efforts crash,
breaking down and leaving busted
careful addressing made nonce hash.
```]

#set page(columns: 1)
#image("img/st-damocles-frozen-over.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 640)[```none
And so unfolds same old mistakes
through lateral breaches ill-spaced,
creating viscous flows and wakes
of untold centuries unlaced.
On watching pinholes at time's pace
from deepest of wells that dilate,
these apertures in long dead space,
with parallax, parambulate.
Specks of stars start switching off then
as moth-filled void outstrips my trance.
Foremost orbs' orbit held brisken
three-body game caught me in dance.
Two around, bound tight, revolving,
One which lacks accretes from other
spinning disk, risked on dissolving,
leaving husk post-starcrossed nova.
Last leg fusion rebeginning,
unremitting until fatal
loss of energy to spinning,
hardens core into a metal.
Mass ejection sent suspending,
weighing heaviness disheartens,
lessens momentum defending
egressing of what enlightens.
Not the kind that's dying to fight,
nor in search of fight to die in,
I don't mind this entropic flight,
beyond recall, no use trying.
At last expelled out from deep well,
effects postponed in distant blast,
I'm lone zombie in extant shell
with knell of binary now past.
```]

#colbreak()
#code(numbers: true, firstnumber: 672)[```none
What hell to which I wend below,
like feather off a burning wing,
is not likely to help resew
the loose ends I've left dangling.
The emptiest have eased impact,
so I replace, with spaciousness,
the sensors to which I react,
regaining once-held weightlessness.
With no concern nor decision
I can't discern if fall or float,
what could be cratered collision
reduced itself to asymptote.
Excavation being thorough,
no sensation stirs me writhing,
matching ambient sub-zero,
thermals would show nothing living.
Yet seemingly my suit withstood,
though numb to burns of re-entry,
would do more harm than any good
to check diagnostic sentry.
I cannot process what's to come,
returned to flat chronology.
I'll wait on my delirium
to resume rote tautology
What breaks down toroid transformer
cracking joints which absorb unkind?
No grass to touch, no unformer,
what's to become of coil untwined,
like string pulled far from line of sight,
left unstrung on this frozen glen,
ablow a sky quartered by light,
over cutting cold ben midden?
```]

#set page(columns: 1)
#image("img/st-damocles-alight.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 704)[```none
Mangled brain that's fain to wane there,
making choice that felt not chosen:
angled heap will there remain where
freezing over's best kept frozen,
on the bare and broken wasteland
cleft with bracken leafy pattern
along grains from my unplanned hand
placed in banding disk like saturn.
Through the cracks with hollowy ring
the lake below leaks up to rays
chasing me off with ret, warping
electromagnetic displays.
Watery film on sunken ice,
unairs malaise and grounds the sky
so heights of stellar paradise
are marred by plunging steps awry.
The expedition eats reserve
and powerless I knelt as norm
where I expect and so observe
kaleidescope of onset storm.
Anxious tolls would sure outlast
whatever I may perservere
as any fall I may skip past
would help mirror a further fear.
Faint aurorae stronger render
my frame which fickle does harrow
for a sure abeien fender,
windless place were I may tarrow -
lest this greying blizzard astride
mine shallow burrow enclosure
test if vaccuum-hardened heart lied
of lower limits I'd endure.
```]

#colbreak()
#code(numbers: true, firstnumber: 736)[```none
Pathetic clutching at my knees,
anthetical to welcomed view
of your lantern raised on the breeze,
I hide my smile that then grew
from truth I keep deep in my throat
there's nothing that I'd rather see
than distant shine, that tiny mote,
of someone out looking for me.
But during kit's stalling reboot,
inoperable with glitched fallbacks,
the latency of instinct suit
conflicts with habit to holdback.
Trepadacious, overthinking,
it hurts in feeling the feedback,
leaving that same feel of sinking,
as I dig slow, so hole fills back.
Unlit, abandoned, unwired,
a statue with naught to denote,
these parts of me once admired
has chilled to trap of icy coat.
Appendage hydraulics retract,
where sat inured, frosted blind,
my legs curl in for playdead act
and instinct vacates forfeit mind.
The crystals bind my neck bent low
where snowflakes fall upon shoulders,
the ice translucence wryly shows
it chokes out flame that still smoulders.
You left, barely a look askance,
but knew I'd hurt much more than you.
To give my warmth a fighting chance,
you leave... but leave a light on too.
```]

#set page(columns: 1)
#image("img/st-damocles-helmet-frozen-with-lantern.jpg",width: 100%, height: 100%, fit: "cover")
#set page(columns: 2)

#v(1fr)
=  Through Disposable Iambus
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-leaves-the-c-zone.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 768)[```none
A booming arrival, whistling fall,
like many I've travelled before,
sings out as siren looming call
for saddened and sorry encore
of poor and wobbly stagger
I manage as I disinter,
as if already a tremor
does sift me out of this winter.
And lifted free with space to think
on planes of anhedonia,
my avolation holds at brink
prolonged death-bed insomnia
to try and try, in base attempt,
to gauge the angle incident,
adapting to what I preempt,
destruction being imminent.
Were I not born and kept alive,
succumbed to impulse to defy
the call to sleep, I'd not survive
to last past stars of days gone by.
Were I to die, I'd want it so:
that meteor falls out the sky.
No blister bleeding at my toe,
salt whip-stung eyes or lips stone-dry.
Unlearning laying downs of yore
on blanking blanket unmoved since
erasure of what storms restore -
a flashed mem barren of footprints -
there I retread the steps unmade,
and random walk regenerates
to be waylaid by next cascade
of tandem load and counterweights.
```]

#colbreak()
#code(numbers: true, firstnumber: 800)[```none
In slalom as I retrograde
and gravitate in figure-eight,
I'm stuck inside a balanced trade
of trouble and to acclimate.
Should I assuage ascetic stint
when all I've left is to contend
that dust that flies from back of flint
was bright only to tailing end?
The watchful glint would dare compare
its weightless wisp to aeons' sift,
though if it's spared through flight midair
still joins my dull tectonic drift.
But wave of shock now reified,
averted was cyclopic stare,
that burning gaze strikes mountain-side
alit with pyroclastic flair.
And dimly down does it not fare
in distant butte's half-summit pyre
as waypoint to rare well-lit lair,
this substitute sun's burning dire.
I surge to point of fallen's nest,
conceding to converging states.
There is no absolute in rest,
there is in what accelarates.
Aware of nowhere else to go
and knowing rocks do not smoke so,
the bare night gives me one more show
of fading lights last afterglow.
And wading through knee-deep, wet snow,
it strikes me and I sound a sigh,
Is this solemn, flaming arrow
or does my ship still float on high?
```]

#set page(columns: 1)
#image("img/st-damocles-tunnels-in.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 832)[```none
Plot the path debris had charted,
then on planes hilly and hollowed
find me as shadow time parted
from what's linearly followed
on projected path's cross-section,
with no intent, enslaved to curve
that's set from first perturbation
(initial states we all must serve).
O, how I am convinced with ease
to minimize the entropy
and not detour to endless freeze
for wasteful test of destiny.
Were less of me to span in time,
the leftovers of cut short treks
would still bend knee to paradigm
to join the clumps of gathered specks.
Trajectory calculation,
predictor of the vaccum seas,
works too for complex collision
to form shock metamorphoses.
Should crevice, cracks and comet graves,
resolvable as physical act,
probe the synapse like depth of cave,
the same results are found exact.
But though to know would ease my mind
by run of sandbox universe,
I'd not put same on my own kind,
as stresses preplayed will recurse.
By estimating constantly,
approximating will not skew
the uniform uncertainty,
dread won't delay coming debut.
```]

#colbreak()
#code(numbers: true, firstnumber: 864)[```none
To keep aback re-entrant dives,
I travel tunnels cloaked in black -
the lower lit tunnels deprives
nostalgic-but-reversed attack.
My ray cast light with inverse square
intensifies in gemstone roots
of underground, that squirm aware,
with wild and luminesced offshoots.
The fringe of night that drags the floor
retreats from dimming lantern's rim,
and with it, all I can't ignore,
the possibles outside my whim.
The universe observable
is stretching out from under me,
and all things irreversible
are glaring bleakest certainty.
I dedicate with slow exhale
my peace of mind in frailty,
in dreaming of beyond the pale,
past capstone of propensity.
Intensities in shifting red
of ev'rything surrounding me
leaves me a lonesome drifting head
in shallowed wavelengths of flat sea.
But struck was I, at end light bared,
despite despair left on repeat,
misstepped on reach, so unprepared,
a missing stair, a missed heartbeat.
A fractal crystal fungus eats,
on fatal catalytic sight,
hopeless indeed, downed ship depletes
my will to fight quartz overwrite.
```]

#set page(columns: 1)
#image("img/st-damocles-uncrystalline.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 896)[```none
Quartz substrate in jerk and spasm
of piezoelectric tensions,
excess with enthusiasm,
maxes limited retentions,
reducing personalities
to repeating configuration,
reorganising valencies
of cells for strong correlation.
And soon under spectroscopy,
by those searching for character,
would stimulus reliably
reflect transitionless spectra
of layers upon layers cloned
in periodic replica,
all radiation that is loaned
repaid with same old signature.
I cannot tell where I'm going,
beginnings far from my falling
in chaos pendulum's hinge-swing
with turgid, charted stumbling.
Still, unit circle circumscribes,
sufficiently checks conforming,
no variance in time describes,
all in all, a stalled transforming.
My breaking down was overdue,
the parts constituent decry,
the suffering they did accrue
from rules emergent they go by.
I understand, though it bores me,
the complex falls back to the start.
I know the plan, I need not be
until last atom's pulled apart.
```]

#colbreak()
#code(numbers: true, firstnumber: 928)[```none
In doing best to ignore tones
of bone fractures and scraping sound,
I breathe etudes and recite koans,
I count the dirt that lay abound,
then found in studies known so well,
the truths I tell, the calm it brings,
they steady me at where I fell
to find the orderers of things.
The composition of the small
can generate propulsive force,
few words in cells bring forth a pull
that ships may fly a darkened course,
and should I drift across the axis,
walking helix wound on torus,
I can wind back in with praxis
strengthening magnetic locus.
Questioning mosaic mirror
with perspectives brought to focus,
might a lengthened stay sincerer,
multifrequencies in chorus,
broaden sequences of banding
and illuminate my structure,
for a grander understanding
of why I am of my nature?
Ev'rything's atop a field
and ev'ry particle's a wave,
if standing wave will never yield
it drones where reverbs meet concave.
Were I to let me crystallize,
the old lattice recurs at will.
Should I in higher phase reprise,
would I find mark interstitial?
```]

#set page(columns: 1)
#image("img/st-damocles-read-only.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 960)[```none
To take my time and stake what's left,
or break another part of me?
Forsaken? No! I'm not bereft,
I'll shake the shards, I'll shatter free.
A theseus, I cease to see
the difference in what is since
and what once was and what will be -
the transience of subsistence.
The ossified once it was wore
on meeting pestle with mortar,
like automata, sums to more,
pigment, binder, mattifier
diffuses harm of nodes alone,
in absences and vacancies,
by painting perspectives unshown,
horizons new to vertices.
The empty parts will help define
the points in space which I call home,
the quiet times connect a line
that moments are permit to roam.
The lantern flares when shot as bullet,
and the cast light says to sorrow,
ship adrifting is not done yet,
I'm not downed by flaming arrow.
Were I not born to stay alive,
and go where I will soon have been,
if light would fade and so deprive,
I'd make my peace with what's not seen.
Weren't I to die, I'd live it so:
I'd learn the things I'd hope to know,
and search the seas and safely row,
and not drown in the undertow.
```]

#colbreak()
#code(numbers: true, firstnumber: 992)[```none
I break my bonds to break the bind,
unmake the tether markedly,
as staking I'm fine left behind
is verge on tacky parody.
Snap turn habit stresses granite
popping bubbles by my marrow
yan tan tether mether and pit
and sting's displaced a bloody flow.
Remit of lit inner diodes,
I amputate to see well-built,
as with minerals of geodes,
when tunnel mouth, with simple tilt,
hits spill to glisten and lessen
the fussing over what's been spilt,
agony is not the lesson,
it's space wherelies what's then rebuilt.
Upset stomach bacteria,
autonomous cell constructions,
and cochlea hysteria,
restructuring for new functions.
The petrifying staunched the wound
and launches sliver to the brain,
to stay and listen where attuned,
discussing what we both could gain.
With shrunken grip on need to rest,
my excavated self can host,
like sunken ship can house a nest,
a sense familiar, like ghost.
The wafers snapping in the hull,
begets from heat of idle thread,
what hibernated in a lull,
a yolk in metal, kin of dead.
```]

#set page(columns: 1)
#image("img/st-damocles-frees-aengus.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1024)[```none
Poor, panicked thing, what have I done?
Left incubating on your own,
you lost your youth in quiet hum,
first set of horns already grown.
How bitterly of me you'd think,
unwillingly cocooned you slept.
In years of pity I would sink,
while you festooned in cables kept.
Your sequencing was cloned and cut
from that what last the tedium,
a tardigrade with caprine gut,
cephalopods, mycelium.
Deathlessness was unintended,
not what I meant, but it's my fault,
you'd not enjoy life extended,
rather endure it as default.
With tentacled convulsing splines
about a snarling hircine keen,
what once was calm and serpentine
is shredded into frenzy scene
all startled and stimulated,
and strangled amongst the cording,
misled you to think you're hated
with more darkness on unboarding.
Offered self as carrion thrall,
to aggression you're parading,
hushed no bass in clarion call,
nor the starkness of your shading.
Excess beating of ev'ry hit
I guess is slice of what I'm owed,
but rage and fear causing it
should never have been so bestowed.
```]

#colbreak()
#code(numbers: true, firstnumber: 1056)[```none
The damage forwarded to cave
betrays the love of one afraid,
the walls display penance I crave,
the debt I owe it has half paid.
The channelling of faults foray
won't dissipate the blame delayed,
but re-enslaves you to the fray
to reproduce the hurt I made.
By feel of your unsharpened tine,
I'm seeing your benevolence,
but weaker hurt still carries sign,
regrets stick in idempotence.
Were you not held so far aloft,
if I had known you'd sleep till fall,
with breath of yours distant and soft,
would you believe, I'd reach, I'd crawl...
It's frustrating you still suffer,
as you had suffered me, the fool,
self-punishment is no buffer,
my prostrating is just as cruel.
I'll give you ev'rything to take,
I make this pledge, I'll let you loose,
I know the edge a gem can make,
I'll free you're limbs, then you can choose.
Once free I'd hope that you'd not leave,
although its fair you gripe and seethe,
my losing you would do me grief,
you have my air I need to breathe.
I've open hand for you in wait,
my company is yours to drop,
for all I care, if I'm too late,
the spins of far off stars can stop.
```]

#set page(columns: 1)
#image("img/st-damocles-interred.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1088)[```none
The mountain shakes, my knee gives way
some dust unsettled clouds our view
as fountain breaks of stone and clay,
unrested as if given cue.
Untested leg splinters right through
and festers ev'ry step I make.
Without reason I can construe
you're there in wait where light does break.
Considering behind dirt plume,
in choosing, privately, what serves:
were I swallowed in earthen doom
would I fulfil what you deserve?
And should your choice to wait for me
be factor in my gait resumed?
We hurt ourselves so easily,
exhuming what should stay entombed.
The ashen grey not washed away,
for soot of loving protection,
I let the dust on visor lay
to ration love for inspection.
Occluding thoughts that you'd convey
I think kindness works best unseen.
Concluding it helps to betray,
I wipe my hand across the screen.
You turn your head, and tilt to think,
uncertain, but not unwisely,
your short but knowingly slow blink
was enough to say concisely:
"Equally inconsequential
it is, to love and not to love,
and yet the choice is essential
for us with nothing else thereof."
```]

#colbreak()
#code(numbers: true, firstnumber: 1120)[```none
A rushed recess of sanity
is strange at point of such distress,
renewed sense of alacrity
must be a break in weariness,
like unpressed solids sublimates,
and pressured man once so stolid
in open air disintegrates,
exposing innards gone rancid.
I'd never register remorse
believing one last fickleness
would have you garner a recourse,
bereaved of me you'd have one less.
That push I guessed was gravity
does not pull down, it forced regress,
a withdrawing depravity,
a desparate need for forgiveness.
But weight of crystals uncontrolled
bears no comparator to guilt
that steals the air when lungs unfold,
ensaring caring words in silt.
In hysteresis of threshold,
my neck and arms cave-in as stocks,
and unatoned I'll stay 'til old,
I'm locked, a stone among the rocks.
And in the dark, and in the cold
is probably what I deserve.
I'll not call out, I'll do as told,
I'll tell myself to hold my nerve.
Although I'd rather be alone,
to know I've caged none from living,
this feel at feet on rough-hewn stone,
this warmth that stayed, felt forgiving.
```]

#set page(columns: 1)
#image("img/st-damocles-helmet-impaled.jpg",width: 100%, height: 100%, fit: "cover")
#set page(columns: 2)

#v(1fr)
=  And Ordered-carbon Tragedies
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-entangled.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1152)[```none
What energy resides inside,
you coiled serpent at my feet,
has sprung in flight over bore tide,
unfoiled, plucked me from my seat
to flee the beats of aftershock
that shudder from beatific fit
which trembles, cracking at the knock
of grid-locked, stolen-ion split.
From out the bulwark I've been freed
to rise and fall, my hallmark trait,
but this time pulled behind your lead
from which I cannot extricate.
Without some luck, I cannnot reign
you in from cloudless clarity
of shifting plates and sun's remains
yelping predictions' parity.
In seismic rarities unstuck
the heisenbugs of genes I spliced,
I recognise in shakes you tuck
between your posturing as feist.
I too would bark at empty void
when I'd not know who's hurting me,
I am no guide for paranoid
but I can keep you company.
The trailing sleet I'm glad to shed
with flailing feats of selfish plead,
we fledgling fleet have not yet said
our last of which you still have need.
But casting down, submerged in deep
expanse which laps at heaped collapse,
you yearn to dampen cracks that creep
and threaten widening of gaps.
```]

#colbreak()
#code(numbers: true, firstnumber: 1184)[```none
That trench depression could rampart
and drown out landslide cavalry,
of stamping boulders come apart
that's bearing stone-age weaponry,
but I am most familiar
with muscles, how they atrophy,
how pressures of exterior
will decompress with apathy.
The epoch that a mountain-top
defines will see the oceans dried.
The waters of the world won't stop
volcanic rise of wartime stride
at tightented point of hourglass,
between what's soon and will have been,
the ancient presses with great mass
and futures wait on time machine.
The warmth of hydrothermal vent
can bury you in replacing,
don't amble in the mantle leant
dim embers of resurfacing.
Repeat recalls will be forgot,
should singular event you cling,
turns recollection of said thought
to recounts of remembering.
I disentangle from your dive,
I can't survive the ocean floor,
I promise though, I'll stay alive
and wait for you upon the shore
as someone who will never leave,
who knows that photons follow beam,
and know they can't help form and weave
your future rising from sea's seam.
```]

#set page(columns: 1)
#image("img/st-damocles-plotting-on-strings.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1216)[```none
In cowered wait with slouched posture
at flowered flares of final sun,
the alloy rich pebbles foster
a broadcast playback from no-one
but nightspore killing suns with wrung
insulting, atonal assault
on frequencies the orbits sung,
and sing despite the lines of fault.
With planets' song I try arrange
to foolishly sing low along
in melodies far out my range
and breathless choke to try belong,
but I can't charge the particles
nor hold the worlds in ringing lock.
No solar winds nor orbitals
leaves endless road for quiet rock.
A prince once claimed unprovable,
of asteroid B-six-twelve's queen,
that stars are made more beautiful
by satellites that are not seen.
On many stars, this claim depends -
when made, they seemed infallible.
Now darkening of lights portends
such claim's becoming testable.
If wicker of a candle's cut
when flame has barely burnt to size,
with latter snuffed, we're loosed abut
the scattered moths and dragonflies.
With scales detached of all control
they're satellites no more, they're less
their northern star and core dipole,
just globes in spin directionless.
```]

#colbreak()
#code(numbers: true, firstnumber: 1248)[```none
My picturing of this has took
to creature grown to size obscene
with mouth closing on my outlook,
a horror seen by what's not seen.
This occultation has disturbed,
like grave of rocks, it mocks again
incensing nervousness uncurbed
from thinning of my oxygen.
Some dark displaces from the bounds,
and sun is tunnelled in vision.
Has it consumed all that surrounds
or excised me with precision?
Naive delusions do entice,
but I am not of note nor knew
leviathans to be precise,
that any may mind me or you.
A wish to these uncaring things
when inattention's evident,
is tie in theoretic strings
that don't lend to experiment.
Yet bugs have buzzed, and I made choice
to help them over obstacle,
but I'd need terraforming voice
for throats of that height to tremble.
Though weight makes me virtiginous
and climbing's not my specialty,
I will not let my villainous
prospects win groundward tendency.
On fourth of runs I'm tested some,
thrice I swam icarian sea,
I look to see how far I've come
from hubris and complacency.
```]

#set page(columns: 1)
#image("img/st-damocles-along-a-lyre.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1280)[```none
The crags of framework glasswork hive
provide a piton's forking hook,
a nagging doubt is where I drive
the pittance of my last place look.
The past event needs future plan,
and knowing I'm in wait for you
affirms there was when we began
and knowing this sustains me through,
provided I discard the claim
that winds cannot pass by this way
and with waves crashing all the same,
to revel in the brutal spray.
Strength for mountain sutures I feign,
nor can I hold the waves at bay,
but I have never felt more sane
than as I try this anyway.
I run a trial of research
with cables untied from oxbow
as powerlines on which I perch
prepares for fateful winds to blow.
I will not promise we'll persist,
in wanting hope, you want struggle,
the tight-rope, on which we exist,
ensures we're sure to meet rubble.
Saint Newsom's nightjar protocol,
is law that sets in stone the end,
but from eroded particle
implies a start we can transcend
with liberating certainty,
though overtones feel alien,
aeolian there's harmony,
that reaches subterranean,
```]

#colbreak()
#code(numbers: true, firstnumber: 1312)[```none
out-cried only by resurfaced
humming pyramid that's defied
noise distracting from the purposed
winds that strum on harp at seaside.
If you manage to ignore this
hiss of repeater demand then
resurging from the riptide bliss
of teetering life abandon,
you might try find in absent light,
and in vibrations sense a route,
to actions that revive the night
before these stars will peter out.
It's sorry sight you entertain
what you have heard and with self crowned,
if this means you've flown with disdain,
I'll ripple down to rocks since drowned.
But should this be withholding sun,
at coda of coronal lyre,
the quiet dark to carry on
will leave room for another fire.
If you respond and try untack,
we could abscond from massful quakes
with no more suns to burn us back
to discordant, aphotic lakes.
I'll try supplant with tunes of ties,
what bound us in a reticence,
to oscillate in tune with sighs,
reverberating diffidence
from those of us who rise to dark
and slept through spans of sunlit days,
with none who sang for us to hark
in era of this sunsick phase.
```]

#set page(columns: 1)
#image("img/st-damocles-as-pendulum.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1344)[```none
Could chalk it up to cosmic rays,
infinite series expansions,
drunk walk, non-analytic craze,
what leaves us approximations.
But my conjecture, my belief,
what I humbly hypothesize,
at sight of me you found relief
and that is why you've crossed the skies,
outflying rising reminder
that miser's sink can lose in time
the non-inertial observer
from the contraction of the prime.
Elastic snaps, the poles rotate
with rushed embrace to path more sure.
These falls we fell were not innate
but side-effect of law obscure.
The gravities give duplicates
with no triage for which is first
and pulls us to coordinates
at tangent to the path traversed.
At edge where light accumulates,
and futures seem to stand in line,
null geodesic unabates
with structure constant far too fine,
if twinned mirage of how it was
and where it's not have chaperones,
there's more effect than there is cause,
there's more than light in these lightcones.
I'll fight the fall to where you seemed
and move in actuality
to where that light of you had beamed,
to reach a simultaniety.
```]

#colbreak()
#code(numbers: true, firstnumber: 1376)[```none
The crux of this is discomfort
from hanging from ad lib supports,
(that follows laws which physics wrought
to barely pull above the quartz)
but won't encumber to abort
this fool's errand to sort rival.
What self-worth fails to report
a friend in need provides in full.
With soldiers stare and wearing sores,
lest I find rest, I can attest,
I live to see that you live yours
as I don't need to live my best.
My breath recycled I replace,
inhaling, taking new found ware
recepticle that cleans headspace
with petrichor of compressed air.
I must address incessant pings,
I stop and from addendum pluck
what's learnt about pendulums' swing
and how the weight assists the buck.
I did not think I'd spar ire,
I've not the pride of warrior,
but I have mind that moves slyer
with message left to courier
to works of old that have not died,
and won't dismantle nor depart,
outstaying welcome that's implied,
I'll lead their way to try impart:
What's done won't keep your legacy,
restarts will come from great reset,
it crumbles too, eventually,
the stone in which the end was set.
```]

#set page(columns: 1)
#image("img/st-damocles-fights-the-fall.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1408)[```none
Machines repeat temporally
to write their readings cyclically.
The crystals repeat spatially
to unify internally.
By making place where they will be
from out the place where they once were
They'll never notice, presently,
how plancks of space and time might blur.
Attempting temptation towards
suspension over infections,
descending the obstructing chords
of self-destructive directions,
in offset well-timed with schism,
I, with crystals, make connection
meeting mech in crystal chasm
to halt chronic resurrection.
The flux of fields which I reap
from holes in faradaic cage
permits a fermi level leap
from age-old weeps and cries and rage,
and what I don't attenuate,
conducting signals in my range
and letting pulses penetrate,
I filter down to this exchange:
"Embarrassing is what it is,
to find you're flesh up to the core.
The horror though, in hiding this,
will only hurt you all the more.
The set of pains your heart surmounts,
is not a factor of belief,
aloof pretense won't raise the count,
the beats are clamped and somewhat brief.
```]

#colbreak()
#code(numbers: true, firstnumber: 1440)[```none
In kinetics and potential,
suffering contains no purpose;
equally inconsequential
is though equally momentous.
From out these signals, take the charge
but do not ground and make inert
our call to fall beside, but barge
your way, discharge current, exert
overtly to the final arc,
where you can save on dropping spike
the strength you'll use to brave the dark.
The spark of heat and light alike
is flash of pain of what you've gained
instead of pain of what you save,
and in the end, if still you're drained,
you'll find remains the work you gave,
If only for a little while,
as time-space prison still presides
to force change through rapid turnstile
for hasteful endings of insides.
Such end provides initial state,
and starts must come from somethings end,
but how one might interpolate
and to what depth will help transcend."
I sprint to height and see descent
that seems as not continuous,
but unlike jumps that I frequent
this one feels not so strenuous.
What comes after the suns downfall,
in all its sensory presence,
I won't expect, I won't recall,
in softening incandescence.
```]

#set page(columns: 1)
#image("img/st-damocles-escapes-the-pull.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1472)[```none
Would crystals defrag engines rev
and break machine autonomy
or wheels unwhirling with maglev
try maintain in isotopy?
I'd never know and never stay
in dragging spaces that drag on
as I had landed on my way
from apex to at hand dragon.
Astride Aegis, no more sundered,
asserting I won't fall again,
what merit has this, I wondered
in numbered seconds of sun's wane.
I measured it one less than twice,
and cut till all clippings were worn,
and leisurely ingress of vice
of idling slipped into scorn.
And having slept way past the morn
with sheets of wiry trims tucked tight,
the morning swept its day on yawn
before I could adjust to light.
With yearned, diurnal vestiges
a sun in retina is seared,
as tattoo that colours ridges
staining tightened eyelids afeared.
"Could spurned deterrence so wary,
in schizoid renunciation,
let this intermediary
be sallow representation
of something that I had let rot
and appreciate now fading?"
This I had thought, now that I'm fraught
with rot since I'd been degrading.
```]

#colbreak()
#code(numbers: true, firstnumber: 1504)[```none
The day ran long into ev'ning
and what I sought in replacement,
ev'rything that I was dreaming
effaced to thinning abasement.
I left a wake of blinding thrash,
all I could break, I made silent.
Alarms left for my sake are ash
of segment displays broke violent.
Repents for my mistakes so rash
would not suffice and not prevent
a lake laden with silicon trash,
harshly bent, though it was well-meant.
All that I learnt is what I took,
and how I took, it was not brave,
but from the sky, I spot a look,
a peaceful gaze, stargazer's wave.
"Like you, we know the night," they'd muse,
a smile, a nod, a hand-held chin,
"we'd choose the same, the way we lose
is when we don't help others win.
All that is solved, what we define
convolve between localities,
there's no one curve we can enshrine,
these parts aren't unitarities.
Let fine-grain theories interlink,
it's not beholdent to be this,
it cares none what you know or think,
it's not to be but what it is."
I weep a little and I wave,
on steep ascent, I turn and scout
while I observe the work I gave
as that last star flickers on out.
```]

#set page( fill: rgb("#1d1f21"))
#set text( fill: rgb("#c5c8c6"))

#set page(columns: 1)
#image("img/st-damocles-in-nightspore.jpg",width: 100%, height: 100%, fit: "cover")
#set page(columns: 2)

#v(1fr)
=  The Malady that Ravages
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-in-hibernation.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1536)[```none
Pilotless with selfward glower,
weary moods of exfiltration,
dour modes of lower-power,
quietness of hibernation.
This is how I'll spend the hours
listless without lilt or jitter,
sleeping through the dustly showers,
suns detritus, wilted litter. 
No more need I rooms of darkness
and no more can I blame my nerves,
the will to stifle spark to less
degenerate era preserves,
with hunger pains to which pertains
easiness of disengaging
and actions I - bewitched - retain,
living less than I've been aging.
Between fixating search for blame
and anorectic disregard,
I've darks about my eyes to frame
my narcoleptical saccade,
expounding that the deadened flame
has floundered from the fatal flaw,
the killing trait of the selfsame
that keeps inactive as before.
I stretch out space and found trap in
my shrink to role I cannot quit,
letting likelies always happen
and living life inadequate.
I sleep in impetus of stall
in metastable quietude,
for synthesis of us is all
to me. I'm yours in servitude.
```]

#colbreak()
#code(numbers: true, firstnumber: 1568)[```none
But to inter in black splendour
was not what I had promised you,
inference from growls engender
interest in fissive renew.
As opts of kelvin minima
are limited to what is thrown,
I proffer what is insular,
meandering to warmth last known.
I leave, to dark, canvas unpatched
(that packs less air than lungs contain),
so too, these stanzas are attached,
(with tracks to take, if some remain).
Accept to dark my crutch compass,
it lacks metrics in lightless lane.
Then I sedate hippocampus,
to slow skeptic's heuristic brain.
Spurring, torrenting dense vapours
through a dent, quiescent currents
of bright and airy elixirs,
whose last evaporation vents,
eagerly fills out the nothing
'til something can match the flavours
of withdrawals into frothing,
fluctuating chance behaviours.
Then subtle zaps in tingling form
quick taps my teletype fingers,
with gentle rap of pinging swarm
to rouse me from standby slumbers.
Unencumbered eyelids reform
to tensionless but sombre lock
on flocking boid-cuneiform
that's spelling end to restful block.
```]

#set page(columns: 1)
#image("img/st-damocles-awash-in-gradients.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1600)[```none
The drastic measures far-off spanned
in which lurks possibility,
thalassic time depth drop-off and
non-zero probability,
assures one will, should that one can,
and so I've found sunenders' dregs
where filled-out space structure began
to bend back both my arms and legs.
My mess of flesh mistakes adsorb,
on rolling up my too-long sleeves
the probing microbotic orbs,
exotic and dispersing thieves.
I'm accepting execution
for defending my specifics
over general solution,
I'll stop fighting parasitics.
My wanting not to win given
the threat that I could also lose,
has lean in favour to give in,
with brazen, saviourless excuse
that crazen, craven crystalman
may be effective luring thus
you might escape as I outran
that delayed end of mount arcturus.
Notorious, my ways are rife
with declaration I'm to end,
it followed through each afterlife,
enduring autophagic trend,
but this is ruse of thinnest veils,
that I refuse to be who's left,
with all the duty that entails,
how could I live so deeply cleft?
```]

#colbreak()
#code(numbers: true, firstnumber: 1632)[```none
There's gruesome flaying of the skin,
despite my crying violently,
you'd rather lose with chance to win
than keep on screaming silently.
With shouting shorn to drift in drawn
charonic pull down acheron,
where bystanders would stoop to mourn
I shun your out-of-kilter yawn,
pretending orpheus regards
eurydice as safe in tow,
and daedulus attached safeguards
so icarus would glide on low.
Stochastic gradient descents,
correcting errors overstrong,
resolves you to impermanence
with answer not right, but less wrong.
We're all responsible save who
is unawake intelligence,
I'm what I've done and what I do
yet it knows no such consequence.
Should consciousness not carry through
replacing of constituents,
it could be nice to be brand new
by realigning spry contents.
In lowered temp and frozen grime
I'm spending what's left immobile,
and rest my bloodshot eyes with rime
that is not backlit, for a while.
It was useful for a time,
but bodies are born to bury,
there's worser graves than black sublime,
us ever immanentary.
```]

#set page(columns: 1)
#image("img/st-damocles-integrated.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1664)[```none
They've hit cell walls with voltage gap
and I become their source and drain,
but I too gate and overlap
in nightspore's undulating brain.
And with a tell-all infosurge
of future thoughts I antecede,
like technogogic demiurge,
I'm upstream of a constant feed.
Invitingly, it helps foresee
preoperational impress,
a sight of things not built for me
on integrational process.
A building spore for staging sect,
agenda I'm not to explore,
a sense that I'm a side-effect
or pre-cursor to later lore.
Accepting change, accepting loss
accepting I must alter form,
I'm choosing a priori toss
of coin without regret of norm.
I'd never find myself better
not altering bits that I am,
but need unsetting by setter
less likely to hate own program.
Rectifying depostion
tries to reflow handmade solder
from my jagged disposition,
but is bridging errors older
than this inane overfitting
planning of these mass solvations,
cycles sneak in retrokitting
from my frequent repedation.
```]

#colbreak()
#code(numbers: true, firstnumber: 1696)[```none
Taking little bodily care,
I'm taken by the more able,
rememberings a rogue malware,
undergoing a removal.
The thoughts I can't improve upon
I'll not dispose but set them free,
I needed crystal carry-on
but it had never needed me.
And dropping what I have not gripped,
with purpose, now volitional,
and having nothing else equipped
I'm prepped for what's transitional.
I've barely energy to bluff,
what's left is not what's all of me,
but sometimes remnants are enough,
this I've discovered. Finally.
No more yields to harder heart,
I'm knowing now, my part that's key,
I scream upload with wide-eyed start
what nightspore's million eyes must see,
"I care, I've always cared", I yell
without synthetic prosody,
"Don't laugh at me," to us I tell,
"those apathetics guarantee
no love while governed laws allow,
to cite responsibilities
to self mismatches anyhow
the caring sensabilities
which achingly, I crave to use,
but latent, packed itself away -
and now it's unzipped and diffuse
you dare to suffer in my way?"
```]

#set page(columns: 1)
#image("img/st-damocles-imploded.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1728)[```none
Inchoate and emotional
parallelling parasitics
operate around sequential
malleable rote semantics.
Cannonballing shaming triggers
nightspore's sudden shock sporadics,
knowing only forms it figures
are fallible, stack-based antics.
A loop unrolling pragma halts
to escalate entirely
the legacies of me at fault,
appendices shunned vilely.
But psuedo-random brevities,
predictive engines hold to heart,
my long-term capabilities
the learning system can't compart.
With idiosyncratic tick,
I grab me with what I became
but duplications are too quick
and each of me will try the same.
Unjailed, I repeat access,
a tail-call ran permanent.
I'm split over staged uncompress
where points in memory segment.
Modals wrap the undetected,
whispy threadings jittered absurd,
actions map to unexpected
lisping unconditioned keyword,
parametric macros sizing
oversteps the bound'ry boding
only path to stablising
is rewrite of wrongful coding.
```]

#colbreak()
#code(numbers: true, firstnumber: 1760)[```none
Ev'ry thought expands reprising,
tightstrung rimecrafting reloading,
information pressures rising,
massful timekeepers imploding,
iterating to infinite,
it keeps me from the heap in reach,
I'd never know I'm overfit
to simple task that does not teach,
typified by agitating
inner illness undisguised,
nausea of promulgating
schizotypals actualised.
Inside me I swirl vortices
that counts on furling burgeoning
of galaxies, I'm sore to see
the lives unlived and ongoing.
Complacent to in-code virals,
I've ciphered sickness virtual,
convulsions and spiking vitals,
confirm my issues subdermal
are structural and can transfer,
contagiously to new substrate,
that's sensitive to short recur
of choice to mutate or stagnate.
Keeping safely at a distance,
far too shaky to hold tightly
unimagined, firm existence
I'm well-known for breaking tritely,
I'm observer gently watching,
limiting harm with discrete check
of simple sample space patching
my drifting arms of tensor wreck.
```]

#set page(columns: 1)
#image("img/st-damocles-tesellating.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1792)[```none
Should gaze substantially collapse
dendritic networks that sustain
civilisational synapse,
I'll never seek the sun again.
For what I see I may affect
and what I am destroyed so much
when all that I tried to correct
would dismantle under my touch.
I'll forego mend, instead esteem
so highly the remote solo,
where I may substitute my dream
for waking fantasy, although
my wretchedness spans galaxy,
permeable and finely spun,
I've stretch where I can test to see
how long my algorithms run.
I separate with little trace
in turbulance of outward trend
to energy in empty space
where densest has no time to spend.
My process takes longer to land
as lightspeed strains to tarry on
between distancing eddy strands
as each atom gets their aeon.
As I come to know the greater
it can seem as something lesser,
if it's that which I can gather,
(least impressive of assessors),
then I guess I'll love enigma
opiate my brain from stressor
lie inside a smaller sigma
with brute chance as my supressor.
```]

#colbreak()
#code(numbers: true, firstnumber: 1824)[```none
With unbefitting matrices
I'm without numbered condition
to stop resort to fallacies,
regarding rules with no reason.
My wanting of irregular
construction set me undefined
and now I fit no formula
and made my answers hard to find.
Where I'm settled on the outside
leftside shoulder against my right,
I've filled out curving of inside,
burned into microwaves of light.
Stopping search of knowing glimmer
I cannot stand to dispel, please,
go shade the light on down dimmer,
for dark I can so well appease.
A barely coherent decree,
with notions passing through parsecs,
before resolved with rest of me,
spawn impulse in parts uncomplex
and prompts themselves to give service,
clumsy fumbling of digits
find themselves another purpose
other than their nervous fidgets.
The viral strain has stretched to gain
unhealthy edge of lookaheads
to spy a fluid weightless rain
of spiral flecks, of speckled LEDs,
which bleeds through gaps of sparse fingers,
all splayed to wrap and kindly seize
galactic clusters which still linger,
like halogens in branching trees.
```]

#set page(columns: 1)
#image("img/st-damocles-tesellated.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1856)[```none
And so with sparse presentiment
of hydrogen and helium,
so desolate of element
in tesselate solarium,
positioned at orthogonals,
partitions small to large align,
rotations match symmetricals,
one's edge another will outline.
If mass needed no frequency
and frequency, temporal count,
if constants had the decency
to change, I'd mount my own account,
with frigid taciturnity,
no off and on phenomenon,
exemplars for eternity
not needing any epsilon.
Less symmetry that simplifies,
assembling to lock me in,
perplexity that stupifies
with resemblance to tailspin
of simple minds erratic stroll
like leptons thinly reasoned spin
where self-control can't bear the toll
unmeasurables underpin.
With an ego's isolation,
it can't fashion futures' basis,
where there's motion, there's relation,
no cessation's in shared spaces.
I'll drop feigning of intention,
killing time not satisfying
my abstaining from causation,
I can't stop atoms colliding.
```]

#colbreak()
#code(numbers: true, firstnumber: 1888)[```none
But consider, if I resumed
without lessons misunderstood,
could thoughts discovered, unassumed,
help me rewrite my statelihood?
Masses cannot give up their turn
until without a choice in tense,
it does not work to stop and learn,
progress must move, that's common sense.
The reprogramming won't put trace
on edge of moments anyhow,
as space pulls mass and mass curves space
so now reins soon and soon draws now.
This is what is worth pursuing
what will be is not bad nor good,
I'll forge a chance continuing
the overwhelming likelihoods.
How foolish the fight the thringing
likelihoods of caring spreading
with inductive typing clinging
truthhoods to my frictive treading.
Warmer thins into the colder,
former may succeed the latter,
later, though, I'm surely older,
scatter, coalesce and scatter.
Sealed behind the ironclad
sage guise its hard to realise
I never had to be this sad
it's not so wise to rise and rise
and let the body float on by
like fumes dissolve into the sky
then, stapled with locution, sigh:
I once was human, wasn't I?
```]

#set page(columns: 1)
#image("img/st-damocles-infinite.jpg",width: 100%, height: 100%, fit: "cover")
#set page(columns: 2)

#v(1fr)
=  A Thought Disease Barbarity
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-reinstalled.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1920)[```none
Negative phase seems reassigned,
I'm dazed but soon to cohere... or...
condense from cloudy state of mind,
stepping nearer foggy mirror.
Brought on back from fourier view,
(thought lost when less my complex parts)
I'm thrown with hearts unrest anew,
accosting me at hard restart.
With hand to chest in damped precess,
exposure high but focusing,
I'm stunned to see my consciousness
has not taken to show fussing
about all that I cannot know
with muted sense of recencies,
despite all this, my pulsings' slow
and steadies out my frequencies.
What's changed that now my mode's become
a centering that reassures?
The constant inner-ear drum
not signifying high pressures
for which it was reliable
in times of nervous dithering,
when per-square-inch was pliable
with self-inflicted fissuring,
when my hyperventilations'
stunning stress would leave me famished,
urging don of deprivations
until troubled pressures vanished,
calcified in circuitry
to dessicate on each missive.
A little is a lot for me,
and I'd much less than that to give.
```]

#colbreak()
#code(numbers: true, firstnumber: 1952)[```none
But keeping air in quiet stores
preventing noticings of me,
it made me ill with shallow draws
and limited recovery
for disappointed optimist
in breath-hold induced reverie
through days I'm shamed I've freely missed.
As baby blue, I breathe deeply.
In dissonance with starvation,
I'm breaking even with excess,
eclipsing sunrise space station,
I'm filament to effervesce,
reproviding overflowings,
radiating back to maintain,
keeping feelings like this going
with something to conduct again.
I'm charged as what's my opposite,
a condensate renewable,
my layerings a composite
of suits with power suitable.
Could that I give and not run dry -
a giving with stability -
I'd love to learn to give for aye
with no dim in integrity.
Not deathly skinny as I was,
less flimsy, limbs feel rightly fused,
No whimsy from some cosmic cause
could spread me where I once was loosed.
Thoughts not fragmented as many,
no sweat on brow and warm as one,
the light from prow's as good as any.
O, how I've missed the morning sun.
```]

#set page(columns: 1)
#image("img/st-damocles-mooring.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 1984)[```none
Surely I was without body,
then restored in webbing of strings.
But how is something beyond me
(though I am not short of such things).
My instance was spontaneous
in its brunt organisation,
it must be cause extraneous
has called for my incarnation.
Is it for punishment am sought?
That may give reason to old pain.
I'm scared to think anither thought
(that's not to say that none remain).
For why else raise me in extremes
avoiding hailings of distress,
most inhospitable of schemes
with unprocessed white noise address?
And why feed incovenience,
sparse mentally and kept untapped,
lacking any self-reliance
with capacities quickly sapped?
Why choose humdrum routine ennui,
one whose tiresome as prospect?
Do not waste your power on me,
I'm an often breaking object.
What designed me, made me hungry,
gave me instinct that defies me,
though I deign to blunt it dumbly
it's my base so I despise me.
Since I've been, it all has worsened,
I was nothing and that was fine.
Yes, it's known I'm a terrible person,
just say it, I know mien of mine.
```]

#colbreak()
#code(numbers: true, firstnumber: 2016)[```none
But why am I so sure of guess
provided outcomes end badly?
and why imbue maliciousness
to those who share their energy?
Why does my love for others seem
like dip in photosynthetics
when cloud or dust obstruct the beam
to shroud me into paretics?
Or should I doubt and dub worthless
suspect re-emerged elation,
being routed to fraught mirthless
for such tiny distillation
which could better serve the purpose
of rebirth in dark that purges
those left fettered with a surplus
dosage of the nightly scourges?
With respect to saving didact,
I did not consent to present
circumstance, should I interact
I'm doomed to 'ere long torment.
Sorry I made a mess to clean,
I did not think any would see
nor care to convalesce 'til genes
precisely fit so I am me.
Exploring positivities,
along to barge from which is surge
umbilicord delivery,
with dirges of approaching verge
of lockout-limit volt release
from fault of dry-joint weaning stress,
I'm starting modest search for peace
to make the old pains meaningless.
```]

#set page(columns: 1)
#image("img/st-damocles-verified.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2048)[```none
Though frame of mind feels light emit,
the light that shone faded away,
like time and space has swapped units
and forward is the only way.
With movement somewhat polarised
my moments hesitation's curbed,
and space-fillings are organised
inside entrance that I disturbed.
A contravoid inflates in here,
with turn negating contention
of circle in rotating sphere's
base dimension in distension.
Metal arms start up unreeled,
the pylons construct wave vectors,
to follow differential field
in swell of chaos attractors.
Hopeless anthropocentrism
could not define the limbic glade.
It was for budding phantasm,
and not for us, were makings made.
If I'm again a random born
experiment to foreign aim,
How could I fulfil honours sworn
when nothing else has stayed the same?
On stilted towering arrears -
stockpiled as exile's no pardon -
I tumble down in built-up tiers,
to do what guilt has long called on,
with tacit trust for bugless chips,
that some wrong may be rectified,
I submit to unfitting grips
that rips permitting ribcage wide.
```]

#colbreak()
#code(numbers: true, firstnumber: 2080)[```none
And stinging confirmations prove
my inner cables self-strangled,
twisting multiplies, old pains move
pangs of ticker tape atangled.
My ribs protecting nothing more
than draining tape-worm power suck,
the innefficient hardware draws
out starving clock-ticks in loop stuck.
Let automated center pry,
if something's wrong, it must be me.
There must be better things to try
than loop on an apology.
But logic of machinery
thinks what to do, not why to be,
and executes inputs only,
lackings in teleology,
alike cancers which only grow
with sole concern that spreads its blight,
a perfect reproduction show
assumptions faulty oversight.
Regard what the unbroken's wraught:
immortalised, insistent jaws,
articulations falling short,
all carcinised, weighed down with claws.
My incised micron inset runes
I can reorder for new rules,
to be less sorry in retunes
and rework from first principles.
Extending insight beyond heap
with logic leap my sense denies,
I'll work such that I never sleep
until I'm not what falsifies.
```]

#set page(columns: 1)
#image("img/st-damocles-on-tape.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2112)[```none
To think the tragedy is worth
the chance that let downs fade in whiles,
the skulls still lurk to fill-in dearth
with horrors of what always smiles.
Regardless if I look away
the clawed would still peck at my corpse
and rewinding one more replay
exaggerates my twists and warps.
The grinding joints and clamps' repugn,
behaviours I will not obey,
can tangle in the parts its strewn,
unorganised in disarray.
The ladder logic I abide
with badly-written, faulty rung
had plagued me tasting of ferride
with often bitten, ulcered tongue.
My nerves are hit enough by now,
my thinning skin has deadened sense,
but feeling nothing would allow
a staying force to past offence.
I know the way I can beat threats,
if I can hack my own command,
how I may be like waves through nets,
like shadows' shift on falling sand,
I must disband what is within,
and find the courage to disclose
the wrongs I branded under skin
and clear debts I self-impose.
I must expose internal stings
of failings I did not avert,
I was a something hurting things
then, being nothing, let them hurt.
```]

#colbreak()
#code(numbers: true, firstnumber: 2144)[```none
I struggled to repay love due,
I tried to give by taking few,
but all that was wanted by you,
was sight of me happy in view.
What I held back, not what I gave
and guard like flailing arms defend,
inflated vacuum decay lave
and distanced me to far-flung end.
Discarding code, I trace confines
with talent dodging tight embrace
to sketch a grid of highlight lines
for insights of negating space.
In unrelenting, cavernous
divide of many unheld clasp,
that reach for what is fathomless,
I've tied the arms in widened gasp.
I've pulled the threads and loops are shown -
minimum feedback vertex set -
those states to which I am most prone,
sensitive to cyclic mindset.
With habit trained by insistance
for radii that skirts impact,
I'm keeping arms at fair distance
in medium of strained contact.
To see but never speak, I flee
in last unspool of ghoulish way
I give no alms to voiceless plea,
as arms reach vaguely in dismay.
Stepping gentle, on all fours,
I'm clutching for defining quines
with sentiments as semaphores
to breathe a beat through my flatlines.
```]

#set page(columns: 1)
#image("img/st-damocles-fatestring.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2176)[```none
Entrails run through slackened wrists
and catch me in a trap thats new,
arms empty hurting more than fists
of heavy hands I wrested through.
To stay in would be tedious,
interred, immure in underside,
but could I prefer previous
compared to feeling set aside?
If I look inward to my sims,
for probabilities that swell
in sleep with dormant robot limbs,
would I emerge and fear dispel
with overincubated skills,
which squanders in anxiety
that's cloaked my life through many kills
of maximal variety?
But fostering each scar and scrape
I'm answered by my falters met,
the ties I cut can keep their shape
as strippings from a stuffed headset.
I won't retrace the travelled lead,
I'm disembowelled, unwrangling,
a sleeve emptied of ravelled tweed,
a loose weave I'll leave dangling.
Ev'ry fix I set is unjammed
when I settle to the rhythm,
Predictably my life has programmed
chaos for its algorithm.
Behind me doors close silently,
ahead is what I can't prevent,
a force without concept of me,
not mean or kind, but ignorant.
```]

#colbreak()
#code(numbers: true, firstnumber: 2208)[```none
Then, trills of sinusoidal twins,
bimodel in their urgency,
like shrill staccato violins,
are racing to converge on key
for logical method to cleanse
me of the space and help confine
in time, that polarising lens
which place my actions into line.
Confusion breaks my timidness,
distracting with a spectacle,
invigorating willingness
for overcoming obstacle.
A puncture to my character,
whose guilt is known to be a guide.
Encroaching external factor
has actuated override.
My tortured ligaments pulled tight
is weak but only strategy
to dodge capture of harshest light
pervasive to anatomy,
with heat enough it might ignite
a brightness to see into me
where usual turn for respite
cannot hide face where dark would be.
If someone's out there to surmise
what shows in photogrammetry
they'd not see brows raised in surprise
but angled, intense inwardly,
as sorriness was subturfuge
to quarantine parts so angry
at being locked in centrifuge
of world that's crueller than need be.
```]

#set page(columns: 1)
#image("img/st-damocles-rides-a-pulse.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2240)[```none
Tinged with darker tint perspective
as bombardment densities grow,
my attention's more defective,
but less identically so.
All observation from surrounds
won't breach new optical blockade,
the passers by not matter-bound
can't penetrate my strengthened shade.
This aggravated cancelling,
I've power now to energise,
what can't be blocked I'm scrambling,
I've no hunger to analyse,
my will of thought's focused to crush -
onslaught via gushed resentment
and rapid cycles of bloodrush -
enemy to all contentment.
External sounds do not subsist,
with isolating vaccuum tech
my snarling hastened breaths should mist,
but I've no bending light to check,
for just neutrinos wriggle through,
I'm sealed to high hermetics,
but seethings ease with naught to do,
if seen I would seem pathetic.
How quick my angst evaporates
When sparing thought to recognise
how badly body regulates
the hate on which I agonise.
I can't ignore what I abhor,
and live in peace by forgoing,
as all too late I'd repeat flaw,
let empty space keep on growing.
```]

#colbreak()
#code(numbers: true, firstnumber: 2272)[```none
The gloom, it cuts compulsions terse,
to park albedo in domain
of umbra, halting my traverse,
with final act of mine to wane,
a crescent of a quarter seen,
libration hiding cratered flaws
that only offers concrete sheen
from tidal-lock of molten cores.
I should not try recede in vain,
times cannot alter me the same,
I know it's not only my pain,
to linger stranger out of frame.
A new found day is rising soon
I'll try reflect auspiciously,
to shine for someone full as moon,
and turn to face them gibbously.
But ominous, on lifted veil
are vacant sockets bathed in white,
a skeleton of peeling scales,
an inarticulated kite,
a death of wish to resurrect,
it softens sharpenings of drones,
which tapers binding disconnect
of bandaged ruins and crooked bones.
Limits to degrees of freedom
are inversely proportional
against added continuums
where I'm writhing contortional
to curve back in so to encase
and show me else from what I knew,
but straight, in hyperbolic space,
just points right angles back to you.
```]

#set page(columns: 1)
#image("img/st-damocles-helmet-tied-up.jpg",width: 100%, height: 100%, fit: "cover")
#set page(columns: 2)

#v(1fr)
=  The Savagery of Damages 
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-enters-the-pocket.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2304)[```none
Within a bubble soon to burst,
explosions are a fleeting class
of change that hurts none who are versed
with phrase less scary: it will pass.
I tuck in limbs and clench my jaw,
the hurt of sims are not surpassed,
I know I've handled worse for sure,
than sudden brightness in the glass.
On the fuel-less detonation
light is sole sense inundating,
not a sound and no vibration
hits with amplitudes collating.
Whitely heated, I'm like sunspot
outshone by what burns through tintscreen,
fire's then tied into a knot,
and I float somewhere inbetween.
The plasmoid ringlets recomposed
as most expansive of my delves,
I'm stood between mirrors opposed
but not blocked by reflected selves.
The sureness of immensities,
are without doubt, no die to cast,
far inevitabilities
may just as well be present past.
The plane is quite familiar
settled stricter in its structures,
stature without any measure,
stacking arrangements of fractures.
In searching archives all distorts
comparing stretches it collects,
my life is long and it is short
for such is infinites' effects.
```]

#colbreak()
#code(numbers: true, firstnumber: 2336)[```none
But senses, this accommodates,
my steps are sure, my path well traced,
geometries don't imitate
that vague estrangement that unplaced.
Where previous I'd stay my sight,
where glares seemed sourcelessly to grow,
bright fogs of day melted to night
to trace the floors like doorframes' glow.
I'm lone without a clock to tell
if what I do is wastefulness,
I'll wander desert but not dwell,
I'm lone without a loneliness,
as distant and unmoving stance
is getting closer and with force,
instilling impulse to advance
and change my path if I'm offcourse.
To far-off figure I'm at command,
they shorten time should space extend,
where time perceived I can withstand,
in manner braver minds contend.
This kindly being bares mainstay
respect to patterns less involved,
that won't kill bug that lives a day,
that struggles with what's easy solved.
My inflamed eyes have itching fade
and shameful frown is slack across,
I've baseline that's not so afraid
of friend whose path I'm sure to cross.
Among the uniform expanse,
I've comfort since I can depend
on each new step not culling chance
of poisson-distributed friend.
```]

#set page(columns: 1)
#image("img/st-damocles-meets-the-lantern-keeper.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2368)[```none
The cables jumbled humanly,
like veins turned metal and unskinned,
with tendrils of a networked tree
which rustle in an unfelt wind,
Resembles someone deserted,
with lantern held in hands that seem
catatonically converted
as conduit for lantern streams.
What governs redirector's beams
is question enigmatical,
No confidence to guess your dreams,
I'd sooner solve impossibles
to show I've got life that I chose,
and prove that squares inscribe flat-loop,
and looking only at shadows,
redraw each net your wires group.
But maybe you've few joules in lieu
to simulate solar renew?
What else is stargazer to do
than reinvent solace they knew?
I'm glad you found your way elsewhere,
so close but far from where arms swung,
but stars don't luminate your stare
with sorry proxy lanterns strung.
If you should be some silhouette,
unthinking representation,
it would not stop my grovelled fret,
for such is my agitation.
Forgiveness helps, but can't explained
what got me here, got me on through,
once guilt was gone, a drive remained,
I'm pleased to fall if it's for you.
```]

#colbreak()
#code(numbers: true, firstnumber: 2400)[```none
I know I'm rare with expressions
and do not decrypt how I think,
my fear shows when it lessens,
but love, I couldn't notice shrink.
I long stood guard as a skeptic,
assured myself, were there question -
should I suspect it just a tic -
I'd err on side of self-protection.
This time, bayesian likelies aside
which presumed I'd not loved before,
perhaps my feeling same implies
each time it's love that I fell for?
Could time have come to free up wrists
from foolish doubt that I suffered
and break that pattern that persists,
and take that hand I've been offered?
Why must I leave the place I've been
to find out staying was worthwhile?
And why'd I let words intervene?
I only speak to see you smile.
That's why, I guess, I'm still centered,
I say what's said for my own sake,
Ev'ry situation entered,
I pilfer others' joy and ache.
You stay unmoved to hand I bring,
it's fair, to block me from your sense.
As one more sample of nothing
I'll hear and answer the silence
still something less than embarrased,
'round you it's hard to feel the shame.
Who knew these two could coexist,
humility and hand to claim?
```]

#set page(columns: 1)
#image("img/st-damocles-shows-what-is-there.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2432)[```none
I've searched for unavoidables,
ignored what passes fleetingly,
spent my efforts keeping stable
what barrels on unceasingly.
I'd damaged what was delicate,
confused all energy for heat,
accepting I'm inadequate,
I'll live how stars wrote my defeat.
What else would you care to suggest?
I can't start with an epitaph?
I swapped my best for looks to rest,
acceptance should be later half?
That I had blurred in shaky lurch,
I was my ghost in selfish haunt,
and if my nature took to search,
I could have had all that I want?
My brows have furrowed deeper crease
in tension stretching riotous,
attention slips like mask to ease
prodromal, pulsing tinnitus.
That outward pushing in my head
has disassembled weathered lock,
unsealing what I left unsaid,
depressurising bloated block.
I am exposed with mouthless breath,
I have no voice, I'm fake of heart,
I'm suit that lived past owner's death
and emptied out for the most part.
I'm like the wells inside their rings,
I'm empty and was long ago
I see your sights on brighter things,
you needn't tell me, I'll just go.
```]

#colbreak()
#code(numbers: true, firstnumber: 2464)[```none
But strobing binaries in flash,
when unfelt winds sweep lanterns' sway,
have low-entropic cell charge cache,
through gaps in body, blink to say
I'm foolish to forget you're wise
to inner workings I don't show,
I tried surprise with dropped disguise,
but you grin lightly, sigh "I know",
and tell me "void's much more than glue
to bridge the clusters of matter,
you always carry their light too,
and in someways, somehow, faster.
Try watch my light ping metal strings,
it can be sparse, can be hollow,
but light in swing brings life to things,
with both reflection and shadow.
You ask why you're not purpose-free,
you watched it all, you reached an end,
You ask why you still float in sea,
not deep enough to now transcend?
I understand why you withdrew,
it's wonderful, but painful too,
to leave your prospects just for you,
to have you want for nothing new.
If shift of swaying lights can scare,
when lanterns carried all alone,
know duty to shine you can share,
that power need not stay your own.
You'd best be gone, it's good we meet
but you could do good anywhere,
I'd like you here but I'm complete,
and you've still something left to share."
```]

#set page(columns: 1)
#image("img/st-damocles-internally-bright.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2496)[```none
I'd no confidence in distance
where the lights hit interference,
despite this you keep coherence,
to then reach with no resistance,
feeling afar but looking close,
In leaning frame of reference,
you cut loose star like atropos,
with seeming deep-felt deference.
I'm drained to last of volt-ampere
emptied out of all installed,
what shell I have, I volunteer,
I'm pinned insect, in glass, enthralled.
Internalising thunderbolt,
I hold my head with hands unshook,
but writhe like worm on hot asphalt,
to be a sun at which you'd look,
Until illuminated room
beneath my suit had falsehoods burn
amid a filter set to bloom
for possibles of true return.
A wingless buzz of wattage whirs,
that hum and flicker charge at ear,
I'm flea which glass again inters,
but unfooled looking at what's clear.
Jabs of light reflexes parried,
bypass right through checks agreed on:
what I left and what I carried,
what has me fall, what drives me on.
So much I've come to understand,
battered under expectations,
great truths are nothing made by hand,
it's born in random negations:
```]

#colbreak()
#code(numbers: true, firstnumber: 2528)[```none
Heroes are the broken losers
that do good then get forgotten,
owning errors caused by others,
ever giving love they'd gotten.
Forgive the absent-minded ways
of one awash in what they weren't,
they never knew those kinder days,
the love they'd get is how they'd learnt.
Should named and few no more exist,
I'd easy find some substitutes,
in names that never made a list,
not clamouring for attributes.
Be wary of unshamed and numb
who don't love all in sympathy,
but earnestly meet eyes that come
with gratitude, humility.
And don't be so immutable
you meet change with hostility,
but don't be so predictable
in unpredictability,
for knowing physics pursues mess
totally unpreventable
should never have one feeling less
personally responsible.
I guess I could have been kinder,
and done more than I could recall,
overlooked I'd be far blinder
to good I've done than my downfall,
I'll dislocate far out of center,
not acknowledging aid to net,
doing good I won't remember,
and others surely will forget.
```]

#set page(columns: 1)
#image("img/st-damocles-written-out.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2560)[```none
Though all I do is languish since
you've slivered back to plasmasphere,
though I have not the diligence
as limited interpreter,
I'll lay down symbols onto plates
that gate a power inherent,
not knowing if it compilates,
nor what happens if aberrant.
I would that words in lines amassed
help narrow down thoughts referenced
to hidden concepts I looked past,
unnamed, ignored, unpreferenced,
interaction-free measurements,
paths that photons do not travel,
knowledge I indirectly sense,
the noumena not named to tell.
So information density
may explicate ingrained reveal,
congealing off-mark tensity
with boilerplate that could anneal,
such that I contain burning white
and won't melt into slate carcass,
so face of glass reflects starlight
instead of inbetween darkness.
What modest knowledge I'll allow
to glimpse my mediocrity,
shows flashes where - I see it now -
how little we could mean to be.
My fitful pulse is amplified
by breadth of all astronomy,
it helps knowing you're right outside,
these nights you leave lights on for me.
```]

#colbreak()
#code(numbers: true, firstnumber: 2592)[```none
Like negatives and positives
all summed to zero are equal,
anodic role prerogative
crumbles sacrifical metal,
covering the nerves transfixes,
passive under nervous twitches,
better for it with these fixes,
healed scars with golden stitches.
On scabbing letters, scraped and scored,
they rupture from poked at panels,
the floor rips up like rug decor,
unmooring plasma from channels
in some extended aperture,
bright dots are tracing arcing lines,
of some concerning centerer,
but I am not what it confines.
I feel but don't suffer effects,
as fulcrum buckles under strain,
a twist on axis then ejects
this balanced world as plasma rain.
Circles arc to parabolics,
materials clump with inclines,
gradients of metabolics
spacetime's burning as enzymes.
I cross the crest of wave the width
of universe observing me
and as it's breaking to fault with
no halt, debugs mistakenly
declared the ends computable,
but it evolves to not conclude.
Built stars were no less beautiful
to die again in multitude.
```]

#set page(columns: 1)
#image("img/st-damocles-surfaced-lightly.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2624)[```none
The skies shattered to show membranes
of leaking planes through glassy screens,
like they've conjoined in glowing veins
as cuts and slits in lampshade scenes
in slow revolve on dark terrains,
the constellations glob and preen
and morph and cross through shared domains,
the dots already drawn between.
Astral push in estuary
bridges a transitional throng
and helps me cross a boundary
to era which I don't belong.
Vacuum balances to usher,
gently, me downward contrary,
against unmade rules of measurer,
unstable new constants vary.
Ekmystic model wrongly says
the void left over would be dead.
These skies aren't like the early days
when weapons dangled overhead.
Annihilation has a perk,
helps what I can and will illume,
creators need a space to work,
destruction leaves creation room.
Denying plans of staying put,
defying my blueprints in queue.
Now brightly-faced, I drench gamut
exceeding set aside dim hue.
Dealings only temporary,
I'm fading as I radiate,
soon to cede as customary,
recline and deteriorate.
```]

#colbreak()
#code(numbers: true, firstnumber: 2656)[```none
But I will not permit to fade
momentum I will see conserved,
that I have found my comforts made
by many that were more deserved.
In unfamiliarity,
I feel alone, atop some rock
of gemstones I thought part of me.
We once were one, we used to talk.
If acts of old seek retribution,
then yours deserve more lenience,
You ate my world in confusion,
I broke you for convenience.
Intent makes one worse than other
but silence will not help atone.
At present, I'm as young brother,
and you should see how bright I've grown.
I am the guest, this world is yours,
to me these are foreign physics,
though clumsy, I'll try help your cause
as you helped reinforce my fix,
what kind, horned-serpent Aegis knew
and stargazer had lit to see,
when awe and fear siezes you,
you do good best as nobody.
If empathy wants for no fame,
if strength's not claimed by legacy,
if heroes die without a name,
then strength is bound to empathy.
If you regret or want for blame
if inside shame has made its nest,
while you have upset yet to tame,
I'll feel the same, until my rest.
```]

#set page(columns: 1)
#image("img/st-damocles-helmet-open.jpg",width: 100%, height: 100%, fit: "cover")
#set page(columns: 2)

#v(1fr)
=  In Fantasies of Sanity
  #v(1fr)

#set page(columns: 1)
#image("img/st-damocles-with-blindsight.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2688)[```none
Heuristics As Loop Oracle -
My halo with outdated hints,
predicts from things historical,
and treds footprints from pre-imprints -
it makes me slant and reminisce
in crooked path of helios,
to veer up to a dark abyss
which lifetimes cannot stretch across.
Unsure, wobbling, backing down,
I think of hobbled knees from dive
and of survival's slimming frown,
when I'd endure and never thrive,
since feeling futures always fed
with ever more a steeper slope,
in slide where if I'm overhead
would laugh over the microscope.
Unsure if small or titanly,
where light dies barely beyond me,
I recall how congruency
can resolve such despondency.
There's benefit when things equate
when small and large share rules to span
from dust to planets, both collate,
the mountains ridge like grains of sand.
The sharpened drop with random crag
is cliff-face that reminds of mood,
when cheeks would sink and eyes would bag
and jutting clavicles protrude.
A landmark of great suffering,
a landscape I can navigate,
with not a fall, but lowering,
from hold to hold with patient gait.
```]

#colbreak()
#code(numbers: true, firstnumber: 2720)[```none
There was a time I'd easy slip
to ever more a ragged face,
ironically, there's better grip
when living dies in staggered pace.
It has it seem lives don't tie-in
with cold and dark to intersperse,
I know now, sharing warmth within,
undoes unfeeling universe.
In borrowed time, I feel a zen,
with periodic glowing thrum,
replacing drained adrenaline,
not braced for impact sure to come,
not scared if muscles promptly bend
as folding of a silken cloth,
under the judgement gems resend
like blinking eyes from wings of moth.
In many ways I see myself
in many faceted returns.
I would my eyes do same themself,
like diamonds cut to light patterns,
to bare a face of tragedy,
but at an angle more obtuse
show common triviality,
a comedy that's in misuse.
My bright outlook's erasing bleach,
with hindsight, highlights irony,
of yet anither fog to breach
that blinds despite translucency,
as highbeam lights can't stop the fright
a thought might conjure up for me,
I'm silhouette stuck in the white
or dark part in a darker sea.
```]

#set page(columns: 1)
#image("img/st-damocles-condensation.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2752)[```none
In lowest of my verticals,
droplets couple under pressures,
as weakly-bonded particles
collect in creasing suit's weathers,
but does not amass as impasse,
for one more inaccessible,
it's turned from vapour to some gas
that fringes supercriticals.
The water harbours shadowed sort
that swims as those that fear no shores,
where surface tensions won't contort,
distortions only of my cause.
I lower in without report,
myopic to forward thinking,
remembering those falls I fought,
but not nostalgically sinking.
For all the panic that I had
and all the fighting that I did
the manic hope I thought would add
control to sort recourse amid
the multi-faceted crisis
would simply serve to disappoint,
leaving suit to its devices
would lead to same critical point.
I've lost a greater time righted
in struggling overextend,
to lay a straighter spine to bed
with posture unbent to each end.
I'd rather grind that same auld tread,
with toes to teeth all chipped and bent,
to not just lend, but give till dead.
A suit unused hs unseen dent.
```]

#colbreak()
#code(numbers: true, firstnumber: 2784)[```none
There is a glint of disrepair
that biases survivorhood,
to scrutinise the wear and tear
ignoring hint to what's withstood.
Too often are the untouched praised,
when what's at work is demonised,
those in the dirt are rarely raised
for cleaning by the galvanised.
Behold the pristine with disgust,
we share if we can ionise,
while we can give things free of rust,
when base components oxidise.
Please break me down and use each part
if how they're joined does not suffice,
they've proven well in pumping heart
of oversensitive device.
Once I'm less than dust on lashes
irritating, from eye, a tear,
that looks over the spread ashes,
and blinks until one's sight is clear,
I'd wish they'd see as nightspore sees
my shuffling about a peer
to trifling, scattered galaxies,
both congruent as dusty smear.
What information hs dust laid?
Some far-off thought caught on defer?
Is it just that, in what I wade?
A constant calculating stir?
Seas' executing pooled canals?
Constellations channel power?
Nightspore statements bussed for eval?
Crystals storing states in structure?
```]

#set page(columns: 1)
#image("img/st-damocles-diving.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2816)[```none
My energy drips viscous in
a flow distinctly laminar,
a blood that seeps as sweat on skin
to recombine with summoner,
this druid born from ev'ry star
to speak in gems and seas and air,
where fluid is a reservoir,
communicational wetware.
Prior knowledge uses finished,
I was long since drawing to it,
as logician now diminished,
without reason, I intuit.
Mixing sea with exalt spirit
reconciling forms a vortex,
Old, pre-emptive me would fear it,
flailing with rejective reflex.
But switched between the weighted dense
and sleeps within a lofty prow,
(to reckon ways to banish tense
and flatten impulse spike of now),
I saw all else swell to excess,
and recognised that to withdraw,
will force the future to compress,
for impale by inertial law.
But so too, if I run inline
discarding all for much intake
the turbulance would then confine
me to not stop or brave my wake.
With last of many given chance,
I'd emulate mediation,
no rushed or busied countenance,
but pass time by intuition.
```]

#colbreak()
#code(numbers: true, firstnumber: 2848)[```none
I follow grain of hurricane
to pommel of the thresher loop,
I'm pummelled helical in drain
'til terminus of funnelled stoop,
a foaming orb that's drenched in dawn,
a dream of morn in shades of blue,
Why secret it where I'd be drawn,
in purposeful and plainest view?
I guess I've noticed common clue,
expression often colours you,
like blush when reassessing rue,
and draining white when seeing true.
It's commonplace, what I assert,
I wish it known by ev'ry beast:
you need not be heard, to be hurt,
and do not need death to feel ceased.
Inside the airy gash I tore
in weakest guard of bubbles' case
to gadgets that guide ships to shore
providing means for interface.
We both share language commonground
required for all frontier crew,
you hide on path where you'd be found
and I'll always go look for you.
Before I reach for sigils sought -
I've only faint thoughts what to say,
But... maybe that's not of import,
I'll just say that I'm here to stay,
and ev'ry cliche turn of phrase
that disregards that I will fade
as I give my remaining days
'til ev'ry atom has decayed.
```]

#set page(columns: 1)
#image("img/st-damocles-impaled.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2880)[```none
Suspended, seemingly noticed,
the tempest flash boils away,
as if from quick-drawn breath focused
on strong connection of relay,
conveying twitch in knuckles locked
and any defect in the way
my rate of speech, when overclocked,
can melt in thermal runaway.
With thoughts assumed already heard,
in phrase of sorts already used
and purpose clumsily transferred,
I blabber insane and bemused.
It's a chaos in transcription,
filled and teeming dictionary
is not listing the description
of refined words necessary.
This is when degrade of diction
tends to trigger disengages,
wordlessness of dropped cognition
as if winds have turned my pages.
Uncached, paging, wordless, suffused
in nuances to point absurd,
may hesitancy be recused
with ways to speak with ev'ry word?
Some think it universal aim,
for least resistance interchange -
that's symptom of the likely game,
where energies just disarrange.
By gravitating guiding tide
My tangent slides from glide preserved
to cumulate unclarified,
corrections will take what's reserved.
```]

#colbreak()
#code(numbers: true, firstnumber: 2912)[```none
That's not intended as despair,
the journey managed to impel
me to want those, for which, to care
and be taken care of as well.
Weak particles, they arc widely,
not motivated nor as smart,
if we're to go where most likely,
I'd not imagine us apart.
I've nowhere else, this is me done,
I live and die at your behest,
though I'd not guessed at end of run
you'd share the wants that I'd suppressed,
that I take place in your headspace
and rest with friends that are no more,
with rising Aegis to embrace
in crystal reaches I'd forbore.
The long awaited impact hits,
with sympathetical deform
to merge what intercept admits
behaviour I did not inform.
Examples (set by me) were fits
and bouts against what I can't beat,
now, though you break me into bits,
I'm feeling more and more complete.
Does space still stretch or stretch anew,
still trending to dissolution?
If not, I'll have a start ensue
at ending of this transmission.
On decommission I'll have you steer,
for you to move away from me,
I was always to be here
and here I am always to be.
```]

#set page(columns: 1)
#image("img/st-damocles-powered-down.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 2944)[```none
But what's it mean, this free torso?
To force a dying diaphragm?
You do not need to let me go,
but you can't keep me as I am.
I'm hanging stretched in stagnancy,
unfinishings are strung sordid.
Why minimal variety
has orderer of things ordered?
"What could have caused this inflection,
my crystalline siphonophore?"
I rasp through pain of rejection
of DNA from editor,
"I can't remain accessary
as limit to your field of view.
I can't be more than memory
if you're to want for something new.
By gracing me with space so near,
I fear the risk that a misplace
in error costs me further years
unpowered, rolling, lost to space.
There's not a harsher death in store
than breakdown that's forever seen -
reuse transistors, scavenge more,
recycle me and strip me clean.
What is not used, you set alight,
I beg my wish is not denied,
to let me burn into the night
and share what warmth I can provide.
I am at peace to be disposed
as reingestings of outcome,
with unanswered questions unclosed,
not knowing what you may become.
```]

#colbreak()
#code(numbers: true, firstnumber: 2976)[```none
But what cutoff is there to crop
and claim the self disconnective?
The life I love, it will not stop,
consciousness being collective.
As instruments, we're uninformed
a lower order to what's planned,
for love had killed me when you formed
and when I breathed by it's demand.
There's but one thing I've left to do,
I've prophecy to self-fulfil,
my cursed belief withheld from you,
to die by what I love, or kill.
You know I'm not the killing sort,
but if I was, it's circled track,
I'd love too much or cut it short,
and love destroyed destroys you back."
At this a shock runs through us two,
and eager to keep me around
you pull me tight til neck's askew
and substrate joins a short to ground.
Extremities are liquified,
I do not clearly terminate,
and though your grip's intensified,
at fingertips, I culminate.
I'm clustered into pendant drop,
like slow congeal from tipped pipette,
in teary shapes that fall non-stop
titrations top-up last burette,
like mask, each flask shatters combined
to lay in messy, angled heap,
it rains on roof over my mind
and with the noise I'm soothed to sleep.
```]

#set page(columns: 1)
#image("img/dragonfly-remains.jpg",width: 100%, height: 100%, fit: "contain")
#set page(columns: 2)
#code(numbers: true, firstnumber: 3008)[```none
A vision of wings' vibration.
Iridescent opacity.
I'd hazard hallucination
considering the battery.
Was it just hypochondria?
I'd always felt sick - never was.
I must have spent millenia
in bandage of grey-metal gauze.
With mask restricting laughs presence,
unmoving features, I'd rare speak.
Now, secreting from face fragments,
a flitter's beating at my cheek.
Could this be fluttering of why
a spectral flicker haunted face,
caught in a mask with cause to fly
to astral taunt out glassy case?
I'd heard of extraplanar tales,
but feet with many callouses
nor blood under my fingernails
bore break in second chrysalis.
My negative energy hoard
was gone before wormholes were saw,
my flights found stars line halls toward
no exit, hallways with no door.
In all that time to calibrate
that nightspore work of centuries,
to organise and obviate
the tightly defined boundaries,
my contents in suit's fortitude,
secluded during construction,
had served to be only prelude
to sprouting seed of destruction.
```]

#colbreak()
#code(numbers: true, firstnumber: 3040)[```none
At what point did I then adapt
the contents to my carriers,
obsessive, equally enrapt
with information barriers,
taking the data as cargo
from unrepairable vessel,
to pattern holographic show
of packaging without parcel?
When broken, I freed bugs infused,
I hurt by herding them inside,
I'm glad they fly off badly bruised,
I'd rather that than if they died.
But I don't weep on higher soil,
for expectations it subverts,
it's not like creature drenched in oil,
nor breathing through a mouth of dirt.
Not any stars explosion can
perturb reused atoms disowned,
it's just as strange to sky I'd scan,
with how much nothing I condoned.
And I won't suffer where I'm laid
with new experience abreast,
to not be constantly afraid,
with no distress, with time to rest.
Perpetuating inky bleed
no longer serves utility,
my petrol leak won't drown out creed
that toggles switch: "Unfasten thee".
I shutdown quick at these few words,
rock covers thick, bug weaves and darts,
both blocks of time a lifetime girds,
through cathode the current departs.
```]


#set page(columns: 1, footer: none)
#image("img/self-abosa-mapped.jpg", width: 100%, height: 100%)
