#!/usr/bin/Rscript
# -*- encoding: utf-8 -*-
# ui.R
#
# (c) 2016 Marc Weitz <marc.weitz [at] trybnetic.org>
# GPL 3.0+ or (cc) by-sa (http://creativecommons.org/licenses/by-sa/3.0/)
#
# created 2017-01-15
# last mod 2017-01-16 MW
#


library(shiny)

ui <- fluidPage(

  tags$head( tags$script(src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML-full", type = 'text/javascript'),
               tags$script( "MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});", type='text/x-mathjax-config')
    ),
  titlePanel("Generalized Context Model"),

  fluidRow(
    column(3,
      wellPanel(
        sliderInput("omega1",
                    label = HTML("$\\omega_1$"),
                    value = .5,
                    min = 0.0,
                    max = 1.0,
                    step = .01),
        sliderInput("omega2",
                    label = HTML("$\\omega_2$"),
                    value = 0.5,
                    min = 0.0,
                    max= 1.0,
                    step = .01),
        sliderInput("lambda",
                    label = HTML("$\\lambda$"),
                    value = 5,
                    min = 0.0,
                    max = 15.0,
                    step = .1),
        sliderInput("gamma",
                    label = HTML("$\\gamma$"),
                    value = 1.0,
                    min = 0.0,
                    max = 2.0,
                    step = .01),
        sliderInput("beta1",
                    label = HTML("$\\beta_1$"),
                    value = 1.0,
                    min = 0.0,
                    max = 2.0,
                    step = .01),
        sliderInput("beta2",
                    label = HTML("$\\beta_2$"),
                    value = 1.0,
                    min = 0.0,
                    max = 2.0,
                    step = .01),
        h5("Target"),
        sliderInput("x",
                    label = HTML("$\\omega_1$"),
                    value = .65,
                    min = 0.0,
                    max = 1.0,
                    step = .01),
        sliderInput("y",
                    label = HTML("$\\omega_2$"),
                    value = 0.3,
                    min = 0.0,
                    max= 1.0,
                    step = .01)
      ),

      wellPanel(
        h4("About"),
          HTML('&copy;<em> 2017 by Marc Weitz. The source code of this app is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">CC BY SA 4.0 License</a> and is published on <a href="https://github.com/Trybnetic/shiny_gcm">Github</a>.</em>')
      )
    ),

    column(9,
      column(12,
        column(4,
          plotOutput("representation")
        ),
        column(4,
          plotOutput("similarity")
        ),
        column(4,
          plotOutput("probability")
        )
      ),
      column(12,
        wellPanel(
#          h3("Equation"),
          h5("Distanz zwischen zwei Punkten"),
          HTML('$$d_{ij} = \\sum_k \\omega_k |x_{ik} - x_{jk}|$$'),
          h5('Ähnlichkeit'),
          HTML('$$s_{ij} = exp(-\\lambda d_{ij})$$'),
          h5('Ähnlichkeit des Stimulus zu Kategorie A'),
          HTML('$$s_{iA} = \\sum_{j \\in A} s_{ij}$$'),
          h5('Wahrscheinlichkeit den Stimulus in Kategorie A einzuordnen'),
          HTML('$$p_{iA} = \\beta_A s^\\gamma_{iA} / \\sum_C \\beta_C s^\\gamma_{iC}$$')
        )
      )
    )
  )
)

shinyUI(ui)
