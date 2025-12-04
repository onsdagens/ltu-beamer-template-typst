#import "@preview/touying:0.6.1": *

#let ltu-final-slide(
  ..args,
) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  self = utils.merge-dicts(
    self,
    config-page(
      margin: 0mm,
      background: {
        align(horizon + center, image(
          "img/LTU_eng_vit.png",
          fit: "contain",
          width: 30%,
        ))
      },
    ),
  )
  touying-slide(self: self)
})
