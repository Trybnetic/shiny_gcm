#!/usr/bin/Rscript
# -*- encoding: utf-8 -*-
# server.R
#
# (c) 2016 Marc Weitz <marc.weitz [at] trybnetic.org>
# GPL 3.0+ or (cc) by-sa (http://creativecommons.org/licenses/by-sa/3.0/)
#
# created 2017-01-15
# last mod 2017-01-16 MW
#

library(shiny)
library(plotrix)

server <- function(input, output) {
  circles.x <- c(.3,.33,.35,.36)
  circles.y <- c(.9,.86,.76,.92)

  squares.x <- c(.7,.72,.73,.75)
  squares.y <- c(.08,.26,.19,.15)

  output$representation <- renderPlot({
    plot(x=circles.x,
         y=circles.y,
         xlim = c(0,1),
         xlab = "Dimension 1",
         ylim = c(0,1),
         ylab = "Dimension 2",
         main = "",
         pch=19,
         col="green")

    segments(x0=input$x,
             y0=input$y,
             x1=c(circles.x, squares.x),
             y1=c(circles.y, squares.y))

    points(x=squares.x,
           y=squares.y,
           pch=15,
           col="blue")

    points(x=circles.x,
           y=circles.y,
           pch=19,
           col="green")

    draw.circle(x=input$x,
                y=input$y,
                radius= 0.03,
                col="white",
                border="white")

    points(x=input$x,
           y=input$y,
           pch="?",
           bg="white")

  })

  distance <- function(x, y) {
    d <- input$omega1 * abs(input$x - x) + input$omega2 * abs(input$y - y)
    return(d)
  }

  similarity <- function(x,y, lambda=input$lambda) {
    s <- exp(-lambda * distance(x,y))
    return(s)
  }

  get_sim_circles <- function() {
    similarity.c <- c()
    for(ii in 1:4) {
      similarity.c <- c(similarity.c, similarity(circles.x[ii],
                                                 circles.y[ii]))
    }
    return(similarity.c)
  }

  get_sim_squares <- function() {
    similarity.sq <- c()
    for(ii in 1:4) {
      similarity.sq <- c(similarity.sq, similarity(squares.x[ii],
                                                   squares.y[ii]))
    }
    return(similarity.sq)
  }

  output$similarity <- renderPlot({
    similarity.c <- get_sim_circles()
    similarity.sq <- get_sim_squares()

    plot(x=similarity.c,
         y=rep(0,4),
         xlab = "",
         xlim = c(0,1),
         ylab = "Generalization Similarity",
         ylim=c(0,5),
         main = "",
         pch=19,
         col="green")

    points(x=similarity.sq,
           y=rep(0,4),
           pch=15,
           col="blue")

#    curve(function(x){similarity(circles.x[1],
#                                 circles.y[1],
#                                 lambda=x)},
#          from=0,
#          to=15)

  })

  output$probability <- renderPlot({
    similarity.c <- get_sim_circles()
    similarity.sq <- get_sim_squares()

    sum.all <- input$beta1 * (sum(similarity.c))^input$gamma +
               input$beta2 * (sum(similarity.sq))^input$gamma

    prob <- c((input$beta1 * (sum(similarity.c))^input$gamma)/sum.all,
              (input$beta2 * (sum(similarity.sq))^input$gamma)/sum.all)

    plot(x=0.5,
         y=prob[1],
         xlab = "",
         xlim = c(0,2),
         ylab = "Category Probability",
         ylim=c(0,1),
         main = "",
         pch=19,
         col="green")

    points(x=1.5,
           y=prob[2],
           pch=15,
           col="blue")

    segments(x0=.5,
             y0=0,
             x1=.5,
             y1=prob[1])

    segments(x0=1.5,
             y0=0,
             x1=1.5,
             y1=prob[2])


  })


}

shinyServer(server)
