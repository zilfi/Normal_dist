library(shiny)
library(mnormt)  
library(mvtnorm)
library(lattice)#for whire frame
#install.packages("plot3D")
library(plot3D)#for hist 3D
library(MASS)#mvrnorm


shinyServer(
  function(input, output, session) {
    
    
    output$text1<-renderText({paste("You choose Normal distribution with mean", input$mean, "and std", input$std)})
    
    range<-reactive(as.numeric(input$range))
    mean<-reactive(as.numeric(input$mean))
    std<-reactive(as.numeric(input$std))
    
    set.seed(3000)
    randomdeviates <- reactive({rnorm(range(), mean=mean(), sd=std())}) 
    
    x <- reactive (sort(randomdeviates(), decreasing = FALSE))
    
    densities<-reactive ({dnorm(x(),mean(), std())})
    cumulative<-reactive ({pnorm(x(),mean(), std())})
    
    
    
    output$density<- renderPlot(plot(x=x(), y=densities(), col="red",xlab="", ylab="Density", type="l", main="PDF", lwd=2 ))
    
    output$info1 <- renderText({
      paste0("Click on graph to see the  values","\n",
             "x=", input$plot_click1$x, "\n",
             "p=", input$plot_click1$y)
    })
      output$cumulata<- renderPlot( plot(x=x(), y= cumulative(), col="darkorange", xlab="", ylab="Cumulative Probability",lwd=2, type="l", main="CDF "))
    output$hist<- renderPlot({
      hist(randomdeviates(), main="Random draws from Std Normal", probability=TRUE, breaks = as.numeric(input$bin), col = input$col)
      switch(input$`y/n`,'Yes' =lines(x = x(), y = densities(), col="red", lwd=input$lwd))
    })
  
      output$info <- renderText({
      paste0("Click on graph to see the  values","\n",
             "x=", input$plot_click$x, "\n",
             "p=", input$plot_click$y)
    })
#____________3D part of my work
    
    output$text12<- renderText({paste("You choose Normal distribution with means:", input$mean1,input$mean2, "and stds", input$std1,input$std1)})
    set.seed(3000)
    randomdeviates1  <- reactive( mvrnorm(input$range1, mu=c(input$mean1,input$mean2), Sigma = matrix(c(input$std1,input$cov12,input$cov12,input$std2), 2,2)))
    density12  <- reactive(kde2d(randomdeviates1()[,1], randomdeviates1()[,2], n = 50))
    output$a<-renderPrint(density12())
    output$b<-renderPlot({persp(density12(), phi = input$phi, theta = input$teta,shade = .1,
                                border = NA, xlab = "x", ylab = "y", zlab = "density function", main = "PDF")})
    output$infopdf <- renderText({
      paste0("Click on graph to see the  values","\n",
             "x=", input$plot_clickpdf$x, "\n",
             "y=", input$plot_clickpdf$y,"\n",
             "p=", input$plot_clickpfd$z)
    })
    
    
    ##  Calculate joint counts at cut levels:
    k <- reactive(
      table(cut(randomdeviates1()[,1],input$bin1), cut(randomdeviates1()[,2], input$bin2)))
    
    ##  Plot as a 3D histogram:
   output$hist2<-renderPlot( hist3D(z = k(), border="black"))
    
   output$info2 <- renderText({
     paste0("Click on graph to see the  values","\n",
            "x=", input$plot_click2$x, "\n",
            "y=", input$plot_click2$y,"\n",
            "p=", input$plot_click2$z)
   })
 
   output$graf2d<-renderPlot(image2D(k(), border="black") )
   output$brush <- renderText({
     paste0("Click on graph to see the  values","\n",
            "x=", input$brush$x, "\n",
            "y=", input$brush$y)
   })
#__________________________    
   

   #1
   range1<-reactive(as.numeric(input$range1))
   range2<-reactive(as.numeric(input$range2))
   #2
   mean1<-reactive(as.numeric(input$mean1))
   mean2<-reactive(as.numeric(input$mean2))
   #3
   std1<-reactive(as.numeric(input$std))
   std2<-reactive(as.numeric(input$std))
   cov12<-reactive(as.numeric(input$cov12))
   
   #4    
   set.seed(3000)
   randomdeviates1 <- reactive({rnorm(range1(), mean=mean1(), sd=std1())}) 
   randomdeviates2 <- reactive({rnorm(range2(), mean=mean2(), sd=std2())}) 
   #5
   
   x1 <- reactive (sort(randomdeviates1(), decreasing = FALSE))
   x2 <- reactive (sort(randomdeviates2(), decreasing = FALSE))
   #6
    mu <- c(100,100)
    sigma <- matrix(c(15,0,0,15),2,2)                                
   
   f<-reactive( function(x1,x2){dmnorm(cbind(x1(),x2()), mu, sigma)})
   
   k<-reactive(matrix(c(x1(),x2()), length(x1()), length(x2())))
   
   z<-reactive(outer(x1(),x2(),f()))
   
   output$dentisy12<-renderPlot(persp(k(),z(), ticktype="detailed", theta=40,phi=0))
   
   #output$dentisy12<-renderText(length(z(),k()))
   
    
  }#function{}
)#shinyServerD 


######_

#output$text12<-renderText({paste("You choose Normal distribution with means:", input$mean1,input$mean2, "and stds", input$std1,input$std1)})
#1
#range1<-reactive(as.numeric(input$range1))
#range2<-reactive(as.numeric(input$range2))
#2
#mean1<-reactive(as.numeric(input$mean1))
#mean2<-reactive(as.numeric(input$mean2))
#3
#std1<-reactive(as.numeric(input$std))
#std2<-reactive(as.numeric(input$std))
#cov12<-reactive(as.numeric(input$cov12))

#4    
#set.seed(3000)
#randomdeviates1 <- reactive({rnorm(range1(), mean=mean1(), sd=std1())}) 
#randomdeviates2 <- reactive({rnorm(range2(), mean=mean2(), sd=std2())}) 
#5

#x1 <- reactive (sort(randomdeviates1(), decreasing = FALSE))
#x2 <- reactive (sort(randomdeviates2(), decreasing = FALSE))
#6
# mu <- c(100,100)
# sigma <- matrix(c(15,0,0,15),2,2)                                

#mu <- c(100,100)
#sigma <- matrix(c(15,0,0,15),2,2)                                

#f<-reactive( function(x1,x2){dmnorm(cbind(x1(),x2()), mu, sigma)})

#k<-reactive(matrix(c(x1(),x2()), length(x1()), length(x2())))

#z<-reactive(outer(x1(),x2(),f()))

#output$dentisy12<-renderPlot(persp(k(),z(), ticktype="detailed", theta=40,phi=0))

#output$dentisy12<-renderText(length(z(),k()))





