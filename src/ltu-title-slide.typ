#import "@preview/touying:0.6.1": *
#import "autosize.typ": autosize
#import "ltu-colors.typ": *

#let ltu-title-slide(
  ..args,
) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  // Any oddly specific mm values should be blamed on the official PPT template
  let body = {
    v(41.64mm)
    std.align(
      left + top,
      stack(dir: ltr, h(59.96mm), block(
        fill: white,
        width: 211.05mm,
        height: 83.52mm,
        breakable: false,
        stack(dir: ltr, h(12.67mm), stack(
          dir: ttb,
          v(8.13mm),
          box(width: 189.88mm, height: 32mm, inset: (top: 1.27mm, bottom: 1.27mm, right: 2.54mm), align(bottom, text(size: 36pt, bottom-edge: "bounds", fill: main-blue, info.title))),
          v(2.7mm),
          rect(width: 19.99mm, height: 1.39mm, fill: main-orange),
          v(4.42mm),
          box(width: 189.88mm, height: 25.14mm, inset: (top: 1.27mm, bottom: 1.27mm, right: 2.54mm), align(horizon, text(size: 24pt, fill: main-figure, info.subtitle))),
        )),
      )),
    )
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      margin: 0mm,
      background: {
        align(
          right,
          image(
            "img/first_slide_bg.jpg",
          ),
        )
      },
    ),
  )
  touying-slide(self: self, body)
})
