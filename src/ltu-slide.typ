#import "@preview/touying:0.6.1": *
#import "ltu-colors.typ": *

#let ltu-slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  // Any oddly specific mm values should be blamed on the official PPT template
  // these values are meant for playing around:
  let ts = 0.3528mm * 28 // text size, 28pt
  let bw = 1.29mm // bar width
  let bh = 18.59mm // bar height
  let ha = 0.2 // header ascent
  let btd = ts / 2 // bar-text-distance

  // these values are not meant for playing around:
  let cx = 9.1mm // corner x
  let cy = 10.3mm // corner y
  let tm = (cy + bh) / (1 - ha) // top margin
  let xm = btd + bw + cx // x-margin, we are only interested in left, x is only for symmetry
  let sl = btd + bw // shift  left
  let bar = rect(width: bw, height: bh, fill: main-orange)
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

  let ltu = "   Luleå University of Technology"
  let pagenr = text(fill: main-figure, context utils.slide-counter.display())
  let footer(self) = {
    box(
      width: 100%,
      height: 100%,
      inset: 0mm,
      fill: main-white,
      align(
        horizon,
        // I reused btd for the x padding, need to see whether thats nice or not
        text(fill: main-blue, size: 9pt, weight: "bold", stack(
          dir: ltr,
          h(2.5mm),
          text(tracking: 3pt, upper(ltu)),
          h(1fr),
          box(width: 15.29mm, align(center + horizon, pagenr)),
        )),
      ), // align
    ) // box
  }
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
      margin: (top: tm, x: xm, bottom: 9.69mm),
      header-ascent: ha * 100%,
      footer-descent: 0mm, // rationale: the footer "pads" itself by its horizontal alignment
    ),
  )
  touying-slide(self: self, ..args)
})
