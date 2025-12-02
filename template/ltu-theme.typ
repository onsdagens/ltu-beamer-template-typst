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
  // Paragraph spacing: 24 * 0.3528 = 8.4672mm text size. 8.4672 / 6.35 (par spacing from template) = 1.33341...
  set par(spacing: 1.33341em)

  // bulletpoints
  set list(body-indent: 0.13em, marker: move(dy: -0.15em, text(1.3em, fill: main-white, sym.square.filled.tiny))) // There is normal, .tiny (25AA), .small (25FE), .medium (25FC), .big (2B1B), my measurements were based on tiny i believe
  // Manual counter for decreasing bullet point size, taken from forum
  let list-counter = counter("list")
  show list: it => {
    list-counter.step()

    context {
      set list(body-indent: 0.22em) if list-counter.get().first() == 1
      set list(body-indent: 0.32em) if list-counter.get().first() == 2
      set list(body-indent: 0.38em) if list-counter.get().first() == 3
      set list(body-indent: 0.40em) if list-counter.get().first() >= 4

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
