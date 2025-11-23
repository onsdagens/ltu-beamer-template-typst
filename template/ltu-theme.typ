#import "@preview/touying:0.6.1": *
#import "ltu-slide.typ": ltu-slide
#import "ltu-title-slide.typ": ltu-title-slide
#import "ltu-final-slide.typ": ltu-final-slide

#let ltu-theme(
  ..args,
  body,
) = {
  set text(
    font: ("Helvetica Neue", "Arial", "Liberation Sans"),
    fill: white,
    size: 20pt,
  )
  // theme for syntax highlighting
  set raw(theme: "code.theme")
  touying-slides(
    config-page(
      fill: rgb("#05325a"), // correct ltu blue
    ),
    config-common(
      zero-margin-header: false,
      slide-fn: ltu-slide,
    ),
    config-colors(
      ltu-blue: rgb("#05325a"),
      ltu-orange: rgb("#f15a22"),
      white: white,
    ),
    config-store(
      title: none,
      footer: none,
    ),
    config-info(
      title: "D7020E - Robust and Energy Efficient Real-Time Systems",
      subtitle: "D7020E",
      authors: ("Pawel Dzialo", "Prof. Per Lindgren"),
      // date: "1.1.1970",
      //    institution: "Luleå University of Technology",
    ),
    ..args,
    ltu-title-slide() + body + ltu-final-slide(),
  )
}
