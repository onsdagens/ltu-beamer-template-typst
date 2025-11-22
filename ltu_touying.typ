#import "@preview/touying:0.6.1": *


#let ltu-slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  // set page
  let header(self) = {
    set align(horizon)
    set text(fill: self.colors.text, weight: "bold", size: 28pt)
    // rect(fill: gray, width:100%, height:100%, inset: 0mm,
      stack(dir: ltr, spacing: 0mm,
        // move(dx: -10mm, rect(fill: self.colors.ltu-orange, width: 1.5mm, height: 20mm)),
        utils.display-current-heading(level: 1)
      )
    // )
}
  let footer(self) = {
    set align(horizon)
    set text(fill: self.colors.neutral-darkest, size: .8em)
    utils.call-or-display(self, self.store.footer)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number + h(4mm)
  }
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
      fill: self.colors.ltu-blue
    ),
  )
  touying-slide(self: self, ..args) // All kinds of black magic, do not delete
})


#let ltu-theme(
  ..args,
  body,
) = {
  set text(fill: gray, size: 20pt, font: (
    "Helvetica Neue",
    "Arial",
    "Liberation Sans",
  ))

  touying-slides(
    config-page(
      margin: (x: 10mm, top: 30mm, bottom: 15mm),
    ),
    config-common(
      // auto-offset-for-heading: false,
      zero-margin-header: false,
      slide-fn: ltu-slide,
    ),
    config-colors(
      ltu-blue: rgb("#05325a"),   // LTU graphic style blue
      ltu-orange: rgb("#f15a22"), // LTU graphic style orange
      text: white,
    ),
    config-store(
      title: none,
      footer: none
    ),
  body
  )
}
