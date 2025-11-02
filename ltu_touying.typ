// University theme

// Originally contributed by Pol Dellaiera - https://github.com/drupol

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
      size: .4em,
      font: ("Helvetica Neue", "Arial", "Liberation Sans"),
    )
    {
      let cell(..args, it) = components.cell(
        ..args,
        inset: 1mm,
        std.align(horizon, text(fill: rgb("#032040"), tracking: 1.25pt, weight: "bold", it)),
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
    set text(size: 24pt, fill: self.colors.primary, font: ("Helvetica Neue", "Arial", "Liberation Sans"))
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
    //layout(background => (image("img/title.jpg", height: 10%, width: 10%)))
    std.align(
      center,
      {
        v(13.5%) // no real rationale behind this
        block(
          // we assume presentation 16:9 which is
          // 297.0 by 167.0625 milimeters https://github.com/typst/typst/blob/17a7890b2dc47da390d194d3593ed9a8b5668169/crates/typst-library/src/layout/page.rs#L937
          fill: white,
          width: 297mm * 60%,
          height: 167.0625mm * 40%,
          //inset: 0.7em,
          breakable: false,
          {
            set text(fill: self.colors.ltublue, font: ("Helvetica Neue", "Arial", "Liberation Sans")) 
            text(size: 2em, info.title)
            if info.subtitle != none {
            v(.1em)
              text(size: 1.2em, info.subtitle)
            }
            // content here
            set text(size: .8em)
            grid(
              columns: (1fr,) * calc.min(info.authors.len(), 3),
              column-gutter: 1em,
              row-gutter: 1em,
              ..info.authors.map(author => text( author,  ))
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
          },
        )
      },
    )
  }
  touying-slide(self: self, body)
})


/// New section slide for the presentation. You can update it by updating the `new-section-slide-fn` argument for `config-common` function.
///
/// Example: `config-common(new-section-slide-fn: new-section-slide.with(numbered: false))`
///
/// - config (dictionary): is the configuration of the slide. Use `config-xxx` to set individual configurations for the slide. To apply multiple configurations, use `utils.merge-dicts` to combine them.
///
/// - level (int, none): is the level of the heading.
///
/// - numbered (boolean): is whether the heading is numbered.
///
/// - body (auto): is the body of the section. This will be passed automatically by Touying.
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em, fill: self.colors.primary, weight: "bold")
    stack(
      dir: ttb,
      spacing: .65em,
      utils.display-current-heading(level: level, numbered: numbered),
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        components.progress-bar(
          height: 2pt,
          self.colors.primary,
          self.colors.primary-light,
        ),
      ),
    )
    body
  }
  touying-slide(self: self, config: config, slide-body)
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
  header: utils.display-current-heading(level: 2, style: auto),
  header-right: self => (
    box(utils.display-current-heading(level: 1)) + h(.3em) + self.info.logo
  ),
  footer-columns: (90%, 10%),
  footer-a: self => "LULEÅ UNIVERSITY OF TECHNOLOGY",
  footer-b: self => {
    context utils.slide-counter.display()
  },
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 1em,
      footer-descent: 0em,
      margin: (top: 2.5em, bottom: 1.25em, x: 2em),
      //fill: rgb("#132541"), // 19 37 65
      fill: rgb("#032040"),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 25pt)
        show heading.where(level: 3): set text(fill: self.colors.primary)
        show heading.where(level: 4): set text(fill: self.colors.primary)

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      ltublue: rgb("#032040"),
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
  title-slide(
  )

  body
}
