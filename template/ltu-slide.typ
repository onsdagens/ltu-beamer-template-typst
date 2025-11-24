#import "@preview/touying:0.6.1": *

#let ltu-slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }

  // these values are meant for playing around:
  let c = 10mm // corner size
  let ts = 0.3528mm * 28 // text size, 28pt
  let bw = 1.5mm // bar width
  let bh = 20mm // bar height
  let ha = 0.2 // header ascent
  let btd = ts / 2 // bar-text-distance

  // these values are not meant for playing around:
  let cx = c // corner x
  let cy = c // corner y
  let tm = (cy + bh) / (1 - ha) // top margin
  let xm = btd + bw + cx // x-margin, we are only interested in left, x is only for symmetry
  let sl = btd + bw // shift  left
  let bar = rect(width: bw, height: bh, fill: self.colors.ltu-orange)
  let tab = align(
    horizon,
    stack(
      dir: ltr,
      bar,
      h(btd),
      text(weight: "bold", size: ts, utils.display-current-heading(level: 1)), // orange bar, distance, and the text
    ), // go from left to right
  ) // align bar horizontally with text

  let header(self) = {
    box(
      width: 100%,
      height: 100%,
      inset: 0mm,
      move(dx: -sl, tab), // move, shifts to the left
    ) // box, important to stretch complete space
  }
  let ltu = "Luleå University of Technology"
  let pagenr = context utils.slide-counter.display()
  let footer(self) = {
    box(
      width: 100%,
      height: 100%,
      inset: 0mm,
      fill: self.colors.white, // the footer is white
      align(
        horizon,
        // I reused btd for the x padding, need to see whether thats nice or not
        text(fill: self.colors.ltu-blue, size: 10pt, weight: "bold", stack(
          dir: ltr,
          h(btd),
          text(tracking: 1.25pt, upper(ltu)),
          h(1fr),
          pagenr,
          h(btd),
        )),
      ), // align
    ) // box
  }
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
      margin: (top: tm, x: xm, bottom: 7mm),
      header-ascent: ha * 100%,
      footer-descent: 0mm, // rationale: the footer "pads" itself by its horizontal alignment
    ),
  )
  touying-slide(self: self, ..args)
})
