#import "@preview/touying:0.6.1": *

/// Default slide function for the presentation.
///
/// - config (dictionary): is the configuration of the slide. Use `config-xxx` to set individual configurations for the slide. To apply multiple configurations, use `utils.merge-dicts` to combine them.
///
/// - repeat (int, auto): is the number of subslides. The default is `auto`, allowing touying to automatically calculate the number of subslides. The `repeat` argument is required when using `#slide(repeat: 3, self => [ .. ])` style code to create a slide, as touying cannot automatically detect callback-style `uncover` and `only`.
///
/// - setting (dictionary): is the setting of the slide, which can be used to apply set/show rules for the slide.
///
/// - composer (array, function): is the layout composer of the slide, allowing you to define the slide layout.
///
///   For example, `#slide(composer: (1fr, 2fr, 1fr))[A][B][C]` to split the slide into three parts. The first and the last parts will take 1/4 of the slide, and the second part will take 1/2 of the slide.
///
///   If you pass a non-function value like `(1fr, 2fr, 1fr)`, it will be assumed to be the first argument of the `components.side-by-side` function.
///
///   The `components.side-by-side` function is a simple wrapper of the `grid` function. It means you can use the `grid.cell(colspan: 2, ..)` to make the cell take 2 columns.
///
///   For example, `#slide(composer: 2)[A][B][#grid.cell(colspan: 2)[Footer]]` will make the `Footer` cell take 2 columns.
///
///   If you want to customize the composer, you can pass a function to the `composer` argument. The function should receive the contents of the slide and return the content of the slide, like `#slide(composer: grid.with(columns: 2))[A][B]`.
///
/// - bodies (arguments): is the contents of the slide. You can call the `slide` function with syntax like `#slide[A][B][C]` to create a slide.

// Variable for the default font
#let slide(
  config: (:),
  repeat: auto,
  headline_text: "",
  setting: body => body,
  composer: auto,
  align: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  let header(self) = {
    set std.align(top)
    grid(
      rows: (auto, auto),
      if self.store.progress-bar {
        components.progress-bar(
          height: 2pt,
          self.colors.primary,
          self.colors.tertiary,
        )
      },
      block(
        inset: (x: 6%, y: 0.5cm),
        components.left-and-right(
          text(
            fill: self.colors.primary,
            weight: "bold",
            size: 28pt,
            font: ("Helvetica Neue", "Arial", "Liberation Sans"),
            utils.call-or-display(self, self.store.header),
          ),
          text(fill: self.colors.primary.lighten(65%), utils.call-or-display(
            self,
            self.store.header-right,
          )),
        ),
      ),
    )
  }
  let footer(self) = {
    set std.align( bottom)
    set text(
      size: .45em,
      font: ("Helvetica Neue", "Arial", "Liberation Sans"),
    )
    {
      let cell(..args, it) = components.cell(
        ..args,
        inset: 1mm,
        std.align(horizon, text(fill: self.colors.ltublue, tracking: 1.25pt, weight: "bold", it)),
      )
      show: block.with(width: 100%, height: auto)
      grid(
        columns: self.store.footer-columns,
        rows: 2.5em,
        cell(fill: self.colors.primary, utils.call-or-display(
          self,
          self.store.footer-a,
        )),
        cell(fill: self.colors.primary, utils.call-or-display(
          self,
          self.store.footer-b,
        )),
      )
    }
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  let new-setting = body => {
    show: std.align.with(self.store.align)
    show: setting
    set text(size: 20pt, fill: self.colors.primary, font: ("Helvetica Neue", "Arial", "Liberation Sans"))
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})


/// Title slide for the presentation. You should update the information in the `config-info` function. You can also pass the information directly to the `title-slide` function.
///
/// Example:
///
/// ```typst
/// #show: university-theme.with(
///   config-info(
///     title: [Title],
///     logo: emoji.school,
///   ),
/// )
///
/// #title-slide(subtitle: [Subtitle])
/// ```
///
/// - config (dictionary): is the configuration of the slide. Use `config-xxx` to set individual configurations for the slide. To apply multiple configurations, use `utils.merge-dicts` to combine them.
///
/// - extra (string, none): is the extra information for the slide. This can be passed to the `title-slide` function to display additional information on the title slide.
#let title-slide(
  config: (:), // this is the syntax for an empty dictionary
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
  )
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
        block(
          fill: white,
          width: 60%, // taken from officiel template
          height: 40%, // taken from official template
          //inset: 0.7em,
          breakable: false,
          {
            v(1em)
            set text(size: 1.1em, fill: self.colors.ltublue, font: ("Helvetica Neue", "Arial", "Liberation Sans")) 
              move(dx:0.4em, align(start,text(info.title + layout(size => [Height: #size.height.mm()mm Width: #size.width.mm()mm])  )))
            if info.subtitle != none {
              v(0.1em)
              text(info.subtitle)
            }
            move(dx: -7.2em, dy: -0.5em, rect(fill: self.colors.ltuorange, width: 2em, height: 4pt))
            // content here
            set text(size: .8em)
            grid(
              columns: (1fr,) * calc.min(info.authors.len(), 3),
              column-gutter: 1em,
              row-gutter: 1em,
              ..info.authors.map(author => move(dx: -7.2em, align(left, text( author,  ))))
            )
            v(1em)
            if info.institution != none {
              parbreak()
              text(size: .9em, info.institution)
            }
            if info.date != none {
              parbreak()
              text(size: .8em, utils.display-info-date(self))
            }
          }  
        )
      },
    )
  }
  let my_args = (:);
  my_args.background = {
    align(right, image("template_assets/first_slide_bg.jpg", fit: "stretch", width: 50%, height: 100%))
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: (left: 0mm, right: 0mm, top: 0mm, bottom: 0mm), ..my_args),
  )
  touying-slide(self: self, body)
})

/// Final slide
#let final-slide(
  config: (:), // this is the syntax for an empty dictionary
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
  )
  let body = {
    v(3em)
    align(center,layout(background => (image("template_assets/LTU_eng_vit.png", height: 36%, width: 37.25%))))
  }
  touying-slide(self: self, body)
})


/// Focus on some content.
///
/// Example: `#focus-slide[Wake up!]`
///
/// - config (dictionary): is the configuration of the slide. Use `config-xxx` to set individual configurations for the slide. To apply multiple configurations, use `utils.merge-dicts` to combine them.
///
/// - background-color (color, none): is the background color of the slide. Default is the primary color.
///
/// - background-img (string, none): is the background image of the slide. Default is none.
#let focus-slide(
  config: (:),
  background-color: none,
  background-img: none,
  body,
) = touying-slide-wrapper(self => {
  let background-color = if (
    background-img == none and background-color == none
  ) {
    rgb(self.colors.primary)
  } else {
    background-color
  }
  let args = (:)
  if background-color != none {
    args.fill = background-color
  }
  if background-img != none {
    args.background = {
      set image(fit: "stretch", width: 100%, height: 100%)
      background-img
    }
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 1em, ..args),
  )
  set text(fill: self.colors.neutral-lightest, weight: "bold", size: 2em)
  touying-slide(self: self, std.align(horizon, body))
})


// Create a slide where the provided content blocks are displayed in a grid and coloured in a checkerboard pattern without further decoration. You can configure the grid using the rows and `columns` keyword arguments (both default to none). It is determined in the following way:
///
/// - If `columns` is an integer, create that many columns of width `1fr`.
/// - If `columns` is `none`, create as many columns of width `1fr` as there are content blocks.
/// - Otherwise assume that `columns` is an array of widths already, use that.
/// - If `rows` is an integer, create that many rows of height `1fr`.
/// - If `rows` is `none`, create that many rows of height `1fr` as are needed given the number of co/ -ntent blocks and columns.
/// - Otherwise assume that `rows` is an array of heights already, use that.
/// - Check that there are enough rows and columns to fit in all the content blocks.
///
/// That means that `#matrix-slide[...][...]` stacks horizontally and `#matrix-slide(columns: 1)[...][...]` stacks vertically.
///
/// - config (dictionary): is the configuration of the slide. Use `config-xxx` to set individual configurations for the slide. To apply multiple configurations, use `utils.merge-dicts` to combine them.
#let matrix-slide(
  config: (:),
  columns: none,
  rows: none,
  ..bodies,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  touying-slide(
    self: self,
    config: config,
    composer: components.checkerboard.with(columns: columns, rows: rows),
    ..bodies,
  )
})


/// Touying university theme.
///
/// Example:
///
/// ```typst
/// #show: university-theme.with(aspect-ratio: "16-9", config-colors(primary: blue))`
/// ```
///
/// The default colors:
///
/// ```typ
/// config-colors(
///   primary: rgb("#04364A"),
///   secondary: rgb("#176B87"),
///   tertiary: rgb("#448C95"),
///   neutral-lightest: rgb("#ffffff"),
///   neutral-darkest: rgb("#000000"),
/// )
/// ```
///
/// - aspect-ratio (string): is the aspect ratio of the slides. Default is `16-9`.
///
/// - align (alignment): is the alignment of the slides. Default is `top`.
///
/// - progress-bar (boolean): is whether to show the progress bar. Default is `true`.
///
/// - header (content, function): is the header of the slides. Default is `utils.display-current-heading(level: 2)`.
///
/// - header-right (content, function): is the right part of the header. Default is `self.info.logo`.
///
/// - footer-columns (tuple): is the columns of the footer. Default is `(25%, 1fr, 25%)`.
///
/// - footer-a (content, function): is the left part of the footer. Default is `self.info.author`.
///
/// - footer-b (content, function): is the middle part of the footer. Default is `self.info.short-title` or `self.info.title`.
///
/// - footer-c (content, function): is the right part of the footer. Default is `self => h(1fr) + utils.display-info-date(self) + h(1fr) + context utils.slide-counter.display() + " / " + utils.last-slide-number + h(1fr)`.
#let ltutheme(
  aspect-ratio: "16-9",
  align: top,
  progress-bar: false,
  header: utils.display-current-heading(level: 1, style: auto),
  header-right: self => (
    box(utils.display-current-heading(level: 2)) + h(.3em) + self.info.logo
  ),
  footer-columns: (90%, 10%),
  footer-a: self => "     LULEÅ UNIVERSITY OF TECHNOLOGY", // yep spacing with spaces, i am desperate
  footer-b: self => {
    align(right, text(fill: self.colors.ltulightblue, context utils.slide-counter.display() + "     ")) // yep spacing with spaces again
  },
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 4em, x: 1.65em, y: 1em), // margins for the body
      // fill: rgb("#05325a"), // correct
      fill: rgb("#032040"), // nice
    ),
    config-common(
      slide-fn: slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 25pt)
        // ident bullet lists by 20pt, I like it that way
        show list: it => {
          move(dx: 20pt, it)
        }
        // it captures all parameters of the heading object
        show heading: it => {
          // So the heading is implemented using a block for spacing, a rectangle for the
          // orange bar in the left and using text as the central element
          move(
            dx: -29pt,
            dy: 0pt,
            v(0.48em)  + block( 
              height: 50pt,
              stroke: (left: 0.13em + self.colors.ltuorange),
              v(16pt) + h(22pt) + it.body
            )
          )
        }

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      // ltublue: rgb("#05325a"), // this is the correct one
      ltublue: rgb("#032040"), // this is the nice one
      ltulightblue: rgb("#96afc6"),
      //ltuorange: rgb("#f15a22"), // correct
      ltuorange: rgb("#ff8247"), // nice
      primary: white,
      secondary: rgb("#176B87"),
      tertiary: rgb("#448C95"),
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    // save the variables for later use
    config-store(
      align: align,
      progress-bar: progress-bar,
      header: header,
      header-right: header-right,
      footer-columns: footer-columns,
      footer-a: footer-a,
      footer-b: footer-b,
    ),
    ..args,
  )
  title-slide()
  body
  focus-slide(
    background-img: image("template_assets/LTU_eng_vit.png", width: 30%, height: 30%),
    "" // this is our needed, but invisible content
  )
}
