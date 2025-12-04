#import "@preview/touying:0.6.1": *
#import "ltu-slide.typ": ltu-slide
#import "ltu-title-slide.typ": ltu-title-slide
#import "ltu-final-slide.typ": ltu-final-slide
#import "ltu-colors.typ": *
#import "ltu-empty-slide.typ": ltu-empty-slide

#let ltu-empty-slide = ltu-empty-slide

#let ltu-colors = (
  main-white: main-white,
  main-background-blue: main-background-blue,
  main-blue: main-blue,
  main-figure: main-figure,
  main-line: main-line,
  main-orange: main-orange,
  tema1: tema1,
  tema2: tema2,
  tema3: tema3,
  tema4: tema4,
  tema5: tema5,
  tema6: tema6,
  palette1: palette1,
  palette2: palette2,
  palette3: palette3,
  palette4: palette4,
  palette5: palette5,
  palette6: palette6,
  palette7: palette7,
  palette8: palette8,
  palette9: palette9,
)



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
  set list(indent: 0.055em,body-indent: 0.12em, spacing: 1.02em, marker: move(dy: -0.15em, text(size: 1.3em, fill: main-white, sym.square.filled.tiny))) // There is normal, .tiny (25AA), .small (25FE), .medium (25FC), .big (2B1B), my measurements were based on tiny i believe
  // Manual counter for decreasing bullet point size, taken from forum
  let list-counter = counter("list")
  show list: it => {
    list-counter.step()

    context {
      if list-counter.get().first() == 1 {
        v(0.3em)
        // We had left this one here, i'm not sure what it contributes,
        // probably we can comment it out and reinstate when we figure out what it breaks
        //set par(leading: 0.77em)

        set list(indent: 0.312em, body-indent: 0.23em, spacing: 0.78em)
          text(size: 24pt, it) 
      } else if list-counter.get().first() == 2  {
        set par(leading: 0.1em)
        set list(indent: 0.232em, body-indent: 0.32em, spacing: 0.805em)
        text(size: 20pt, it)
      } else if list-counter.get().first() == 3 {
        set list(indent: 0.200em, body-indent: 0.39em)
        text(size: 18pt, it)
      } else {
        set list(indent: 0.26em, body-indent: 0.41em)
        text(size: 16pt, it)
      }
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
