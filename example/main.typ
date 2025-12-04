#import "@preview/touying:0.6.1": *
#import "@local/kraftpunkt-ltu:0.1.0": ltu-theme, ltu-colors, ltu-empty-slide

#show: ltu-theme.with(
  config-info(
    subtitle: "D7020E - Robust and Energy Efficient Real-Time Systems",
    title: "Robust and Energy Efficient",
    authors: ("Pawel Dzialo", "Prof. Per Lindgren"),
    date: "1.1.1970",
    // institution: "Luleå University of Technology",
  ),
)
= My Title
- My bullet
- My bullet
  - My subbullet
    - My again subbullet
      - My fourth subbullet
        - Stop this
          - Hello
= Heading
This is the example slide for using:
- Bullet points
  - Nested bullets
// This is a comment. The backslash in the next line causes a linebreak
*Bold* text \
_italic_ text
+ Numbered lists
+ Number 2
Math mode: $E=m c^2$
References @dijkstra

= This slide features bullets
- on various indentation levels
  - such as two level nesting
    - or three levels of nesting
      - what about four?
        - five? thats enough for sure
        
#ltu-empty-slide()

= Course Aims and Content
Using `#pause` splits the content over multiple slides
#pause

This is appears separately\
Here is a code snippet with highlighting:\ ```Rust let b = if a != 0 {100/a} else {100}```

= Double column slide
  - Power-profiling down to the micro-second/ampere
  - Validation of embedded software by debugging and tracing

= Manual double column slide
However, it is not yet known how or why this works. In case you want to use something that does not involve black magic you can do it manually for example like this:

#box(width: 1fr)[First column]
#box(width: 1fr)[Second Column]

= Color Palette
#grid(
  columns: (1fr, 1fr, 1fr), gutter: 15pt,
  ..ltu-colors
    .pairs()
    .map(
      it => align(horizon, stack(
        dir: ltr,
        box(
          width: 3cm,
          height: 1.5cm,
          fill: it.at(1),
          stroke: 2pt + black,
          radius: 5pt,
        ),
        h(1em),
        text(
          font: "DejaVu Sans Mono",
          size: 15pt,
          bottom-edge: "bounds",
          it.at(0),
        ),
      )),
    )
)
#pagebreak()

= Bibliography
#bibliography(title: none, "ref.bib", style: "ieee")
