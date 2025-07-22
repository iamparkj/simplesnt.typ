#import "@preview/simplebnf:0.1.1": *
#import "@preview/curryst:0.5.1": rule, prooftree
#import "@preview/polylux:0.4.0": *

#import "simplesnt.typ": (
  slide,
  title-slide,
  new-section-slide,
  focus-slide,
  setup,
)

#show: setup.with(
  aspect-ratio: "16-9",
  set-hangul: true,
)

#show raw: text.with(size: 0.9em)
#show footnote.entry: set text(size: 0.8em)

#show link: text.with(
  font: "JetBrainsMonoHangul Nerd Font Mono",
  size: 0.9em,
)
#show link: underline

// in Korean paragraphs, it is recommended to use:
// #set par(leading: 1.3em, justify: true)

#let kopub(body) = {
  set text(
    font: "KoPubWorldDotum_Pro",
    size: 0.8em,
    baseline: 0.1em,
  )
  body
}

#let jbmono(body) = {
  set text(
    font: "JetBrainsMonoHangul Nerd Font Mono",
    size: 0.8em,
    baseline: 0.1em,
  )
  body
}

#let tup(..content) = $⟨#content.pos().join(",")⟩$
#let rbox(x) = box(
  inset: (x: 0.25em, top: 0.35em, bottom: 0.5em),
  stroke: 0.5pt + black,
  x,
)
#let step(ctxt, lhs, rel: $⇓$, rhs) = $#ctxt ⊢ #lhs #rel #rhs$
#let infer(name, body) = box(
  inset: 0.3em,
  align(
    left,
    stack(
      dir: ttb,
      spacing: 0.3em,
      text(size: 0.8em, smallcaps(name)),
      prooftree(body),
    )
  )
)

#let date-format-uk = "[day] [month repr:long] [year]"
// #let date-format-iso = auto
// #let date-format-kr = "[year]년 [month padding:none]월 [day padding:none]일"
// #let date-format-us = "[month repr:long] [day], [year]"

#title-slide(
  title: `simpleSnT`,
  subtitle: "A template to create Show and Tell slides",
  author: [Park, Junyoung],
  date: datetime.today().display(date-format-uk),
  extra: "ROPAS@SNU",
  logo: image("img/snu-symbol.png"),
  secondlogo: image("img/ropas-symbol.png"),
)

#slide(title: "Contents")[
  #list(
    spacing: 2em, 

    [ Prerequisites ],
    [ (Opinionated) Examples ],
  )
]

#new-section-slide("Prerequisites")

#slide(title: "Typst")[
  You are expected to use Typst 0.13.0 or later.

  You can use this template on the web app#footnote[https://typst.app]
  or your local environment#footnote[https://github.com/typst/typst].
]

#slide(title: "Fonts")[
  The following Korean fonts are required outside of the fonts \
  included in the Typst distribution:

  #list(
    marker: [■],
    indent: 1em,
    spacing: 0.9em,

    [ #kopub[KoPubWorldDotum_Pro]
      #footnote[https://github.com/adrinerDP/font-kopubworld]
    ],

    [ #jbmono[JetBrainsMonoHangul NF Mono]
      #footnote[https://github.com/Jhyub/JetBrainsMonoHangul]
    ],
  )

  If you set the `set-hangul` parameter to `false`, \
  the template will not load custom Korean fonts.
]

#slide(title: "Usage (1/2)")[
  1. Import and configure the template at the top of `main.typ`:

  ```typst
    #import "@preview/polylux:0.4.0": *

    #import "simplesnt.typ": (
      slide, title-slide, new-section-slide,
      focus-slide, setup,
    )

    #show: setup.with(
      aspect-ratio: "16-9", // or "4-3"
      set-hangul: true,     // or false
    )
  ```
]

#slide(title: "Usage (2/2)")[
  2. Then, compile it with `simplesnt.typ` file. \
     If you are in a local environment, run:

  ```sh
    typst c main.typ
  ```
]

#new-section-slide("(Opinionated) Examples")

#slide(title: "Backus-Naur Forms")[
  Use `simplebnf`, e.g.,

  ```typst
  #import "@preview/simplebnf:0.1.1": *
  ```
  #v(5%)

  #align(center)[
    #bnf(
      Prod(
        $e$,
        annot: $sans("Expression")$,
        {
          Or[$n$][number]
          Or[$x$][variable]
          Or[$λ x. e$][abstraction]
          Or[$e$ $e$][application]
        },
      ),
    )
  ]
]

#slide(title: "Inference Rules")[
  Use `curryst`, e.g.,

  ```typst
  #import "@preview/curryst:0.5.1": rule, prooftree
  ```

  #v(5%)
  #set text(size: 0.8em)

  #align(right)[#rbox(step[$σ$][$e$][$v$])]
  #align(center)[
    #infer("Int", rule(step[$σ$][$n$][$n$]))
    #infer("Var", rule(step[$σ$][$x$][$σ(x)$], $x ∈ "dom" σ$))
    #infer("Func", rule(step[$σ$][$λ x. e$][$tup(λ x. e, σ)$]))

    #infer(
      "App",
      rule(
        step[$σ$][$e_1 space e_2$][$v'$],
        step[$σ$][$e_1$][$tup(λ x. e, σ')$],
        step[$σ$][$e_2$][$v_2$],
        step[$σ' {x ↦ v_2}$][$e$][$v'$],
      )
    )
  ]
]

#focus-slide[
  = End of Document
]
