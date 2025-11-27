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
  let body = {
    v(24%) // taken from official template
    std.align(
      center + top,
      {
        [#block(
            fill: white,
            width: 60%, // taken from officiel template
            height: 40%, // taken from official template
            inset: 1cm, // padding towards the box
            breakable: false,
          )[
            #{
              set align(left + top)
              // Text size 10 is an ok choice, that means autosize can range from 1pt to 50pt in 1pt steps
              set text(size: 10pt)
              // two thirds title + subtitle, make as large as possible, subtitle 75% the size of the title
              block(height: 2fr, autosize(
                text(fill: main-blue, info.title)
                  + if info.subtitle != none {
                    align(bottom, text(
                      size: 0.75em,
                      parbreak() + text(fill: main-figure, info.subtitle),
                    ))
                  },
              ))
              // Orange bar
              rect(fill: main-orange, width: 15%, height: 2%)
              // one third authors and date
              align(bottom, block(height: 1fr)[
                #{
                  grid(
                    columns: (1fr,) * calc.min(info.authors.len(), 3),
                    column-gutter: 1em,
                    row-gutter: 1em,
                    ..info.authors.map(author => align(left, text(author)))
                  )
                  if info.date != none {
                    utils.display-info-date(self)
                  }
                  if info.institution != none {
                    "   -   " + info.institution
                  }
                }
              ])
            }]
        ]
      },
    )
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      margin: 0mm,
      background: {
        align(right, image(
          "img/first_slide_bg.jpg",
          fit: "stretch",
          width: 50%,
          height: 100%,
        ))
      },
    ),
  )
  touying-slide(self: self, body)
})
