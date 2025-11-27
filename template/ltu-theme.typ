#import "@preview/touying:0.6.1": *
#import "ltu-slide.typ": ltu-slide
#import "ltu-title-slide.typ": ltu-title-slide
#import "ltu-final-slide.typ": ltu-final-slide
#import "ltu-colors.typ": *

#let ltu-theme(
  ..args,
  body,
) = {
  set text(
    font: "Arial",
    fill: main-white,
    size: 20pt,
  )
  // theme for syntax highlighting
  set raw(theme: "code.theme")
  touying-slides(
    config-page(
      fill: main-background-blue,
      width: 13.333in,
      height: 7.5in
    ),
    config-common(
      zero-margin-header: false,
      slide-fn: ltu-slide,
    ),
    config-colors(
    ),
    config-store(
      title: none,
      footer: none,
    ),
    ..args,
    ltu-title-slide() + body + ltu-final-slide(),
  )
}
