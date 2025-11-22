#import "@preview/touying:0.6.1": *
#import "ltu_touying.typ": ltu-theme, ltu-slide

#show: ltu-theme.with(
  config-info(
    subtitle: "D7020E - Robust and Energy Efficient Real-Time Systems",
    title: "Robust and Energy Efficient",
    authors: ("Pawel Dzialo", "Prof. Per Lindgren"),
    date: "1.1.1970",
    // institution: "Luleå University of Technology",
  )
)

= Heading
This is the example slide for using:
    - Bullet points
      - Nested bullets
    // This is a comment. The backslash in the next line causes a linebreak
    *Bold* text \
    _italic_ text
    + Numbered lists
    + Number 2
    Math mode: $E=m c^2$ \
    References @dijkstra

= Course Aims and Content
  Using `#pause` splits the content over multiple slides
  #pause

  This is appears separately\
  Here is a code snippet with highlighting:\ ```Rust let b = if a != 0 {100/a} else {100}```

= Double column slide
#ltu-slide[- Demonstrate the ability to perform *model-based* design of *small footprint* (low-powered, low-memory) distributed embedded real-time systems
    - Modelling and analysis of real-time applications under the RTIC framework
][ // These two brackets need to be on the same line!
    - Power-profiling down to the micro-second/ampere
    - Validation of embedded software by debugging and tracing
]

#pagebreak()

= Bibliography
#bibliography(title:none, "ref.bib", style: "ieee")
