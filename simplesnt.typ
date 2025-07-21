// This theme is inspired by https://github.com/matze/mtheme
// The Polylux-port was originally performed by https://github.com/Enivex

#import "@preview/polylux:0.4.0"

#let toolbox = polylux.toolbox

#let dark-teal = rgb("#23373b")
#let bright = rgb("#eb811b")
#let brighter = rgb("#d6c6b7")

#let full-width-block = block.with(
  width: 100%,
  height: 120%,
  above: 0pt,
  below: 0pt,
  breakable: false
)

#let slide-title-header(title) = {
  set align(top)
  if title != none {
    show: full-width-block.with(fill: dark-teal, inset: 1em)
    set align(horizon)
    set text(fill: white, size: 1em)
    strong(title)
  } else { [] }
}

#let the-footer(content) = {
  set text(size: 0.8em)
  show: pad.with(.5em)
  set align(bottom)
  context text(fill: dark-teal.lighten(40%), content)
  h(1fr)
  toolbox.slide-number
}

#let outline = toolbox.all-sections((sections, _current) => {
  enum(tight: false, ..sections)
})

#let divider = line(length: 100%, stroke: .1em + bright)

#let progress-bar = toolbox.progress-ratio( ratio => {
  set grid.cell(inset: (y: .03em))
  grid(
    columns: (ratio * 100%, 1fr),
    grid.cell(fill: bright)[],
    grid.cell(fill: brighter)[],
  )
})

#let slide(title: none, body) = {
  set page(
    header: slide-title-header(title),
    footer: the-footer(none),
    margin: (top: 3em, bottom: 1em),
    fill: white,
  )

  let content = {
    show: align.with(horizon)
    show: pad.with(x: 2em)
    set text(fill: dark-teal)
    body
  }

  polylux.slide(content)
}

#let title-slide(
  title: [],
  subtitle: none,
  author: none,
  date: none,
  extra: none,
  logo: none,
  secondlogo: none,
) = {
  let content = {
    set text(fill: dark-teal)
    v(5%)
    grid(columns: (5%, 1fr, 1fr, 5%),
      [],
      if logo != none {
        set align(bottom + left)
        set image(height: 3em)
        logo
      } else { [] },
      if secondlogo != none {
        set align(bottom + right)
        set image(height: 3em)
        secondlogo
      } else { [] },
      []
    )
    block(width: 100%, inset: 2em, {
      text(size: 1.3em, strong(title))
      if subtitle != none {
        linebreak()
        text(size: 0.9em, subtitle)
      }
      line(length: 100%, stroke: .05em + bright)
      set text(size: .9em)
      v(10%)
      if author != none {
        block(spacing: 1em, author)
      }
      if date != none {
        block(spacing: 1em, date)
      }
      set text(size: .8em)
      if extra != none {
        block(spacing: 1em, extra)
      }
    })
  }
  
  set par(leading: 1.3em)
  polylux.slide(content)
}

#let new-section-slide(name) = {
  let content = {
    set page(header: none, footer: none)
    show: pad.with(15%)
    set text(size: 1.2em)
    strong(name)
    v(-15pt)
    toolbox.register-section(name)
    progress-bar
  }
  polylux.slide(content)
}

#let focus-slide(body) = {
  let content = {
    set page(header: none, footer: none, fill: dark-teal, margin: 2em)
    set text(fill: white, size: 1.5em)
    set align(horizon + center)
    body
  }
  polylux.slide(content)
}

#let setup(
  aspect-ratio: "16-9",
  set-hangul: true,
  body,
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    fill: white,
    margin: 0em,
    footer: none,
    header: none,
  )
  
  if set-hangul {
    set text(
      font: (
        "Libertinus Sans",
        "KoPubWorldDotum_Pro",
      ),
      size: 24pt,
      fill: dark-teal,
      lang: "ko",
    )

    show math.equation: set text(
      font: (
        "Libertinus Math",
        "EB Garamond",
        "KoPubWorldDotum_Pro",
      ),
      weight: "regular",
      features: ("ssty",),
    )

    show raw: set text(
      font: "JetBrainsMonoHangul Nerd Font Mono"
      // or
      // font: ("JetBrainsMono NF", "D2Coding")
    )

    set align(horizon)

    body
  } else {
    set text(
      font: "Libertinus Sans",
      size: 24pt,
      fill: dark-teal,
    )

    show math.equation: set text(
      font: (
        "Libertinus Math",
        "EB Garamond",
      ),
      weight: "regular",
      features: ("ssty",),
    )

    set align(horizon)

    body
  }
}
