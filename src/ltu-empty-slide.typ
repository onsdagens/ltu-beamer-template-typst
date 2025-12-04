#import "@preview/touying:0.6.1": *
#import "ltu-colors.typ": *

#let ltu-empty-slide(
  ..args,
) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
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
        text(fill: main-blue, size: 9pt, weight: "bold", stack(
          dir: ltr,
          h(2.5mm),
          text(tracking: 3pt, upper(ltu)),
          h(1fr),
          box(width: 15.29mm, align(center + horizon, pagenr)),
        )),
      ),
    )
  }
  self = utils.merge-dicts(
    self,
    config-page(
      footer: footer,
      margin: (top: 0mm, bottom: 9.69mm, left: 0mm, right: 0mm),
      footer-descent: 0mm, // rationale: the footer "pads" itself by its horizontal alignment
    ),
  )
  touying-slide(self: self, ..args)
})
