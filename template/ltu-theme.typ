#import "@preview/touying:0.6.1": *
#import "ltu-slide.typ": ltu-slide
#import "ltu-title-slide.typ": ltu-title-slide
#import "ltu-final-slide.typ": ltu-final-slide

#let ltu-theme(
  ..args,
  body,
) = {
  set text(
    font: ("Arial"),
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
    ..args,
    ltu-title-slide() + body + ltu-final-slide(),
  )
}
