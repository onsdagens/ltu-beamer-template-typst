#import "@preview/touying:0.6.1": *
#import "ltu-slide.typ": ltu-slide
#import "ltu-title-slide.typ": ltu-title-slide
#import "ltu-final-slide.typ": ltu-final-slide
#import "ltu-colors.typ": *

#let ltu-theme(
  ..args,
  body,
) = {
  // main text setting
  set text(
    font: "Arial",
    fill: main-white,
    size: 24pt,
  )

  // bulletpoints
  set list(marker: text(fill: main-figure, sym.square.filled))
  // Manual counter for decreasing bullet point size, taken from forum
  let list-counter = counter("list")
  show list: it => {
    list-counter.step()

    context {
      set text(20pt) if list-counter.get().first() == 2
      set text(18pt) if list-counter.get().first() == 3
      set text(16pt) if list-counter.get().first() >= 4
      it
    }
    list-counter.update(i => i - 1)
  }
  // theme for syntax highlighting
  set raw(theme: "code.theme")
  touying-slides(
    config-page(
      fill: main-background-blue,
      width: 13.333in,
      height: 7.5in,
    ),
    config-common(
      zero-margin-header: false,
      slide-fn: ltu-slide,
    ),
    config-colors(),
    config-store(
      title: none,
      footer: none,
    ),
    ..args,
    ltu-title-slide() + body + ltu-final-slide(),
  )
}
