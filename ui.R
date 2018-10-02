library(shiny)
#install.packages("colourpicker")
#install.packages("plot3D")
library(colourpicker)
shinyUI(fluidPage(
 
   titlePanel("Interactive statistical distributions"
    
  ), #title panel
  sidebarLayout(
        sidebarPanel(
        
          tabsetPanel( type="tab",
                       tabPanel("Normal distribution 2D", 
                                h5("Input desireable parameters"),
                                
                                numericInput(inputId ="mean", label = "Select the mean", "0"),
                                numericInput(inputId ="std", label = "Select the standart deviation", "1"),
                                numericInput(inputId ="range", label = "Input range of randov variable (number of observations)", "100"),
                                radioButtons(inputId = "y/n", label = "Add normal dist curve to histogram", choices = c("Yes", "No")),
                                sliderInput(inputId="bin", label="Select number of bins for histogram",value = 10, min = 2, max = 160),
                                numericInput(inputId ="lwd", label = "lenght of curve", "2"),
                                colourInput("col", "Select colour", value = "#F0C0C0"),
                                actionButton("button", "Click Me to update main pannel chem ashxatacrel hly")
                       ),
                       #______________3D______________
                       tabPanel("Normal distribution 3D",
                                fluidRow(
                                  column(6,
                                         numericInput(inputId ="mean1", label = "Select the mean for x", "100")),
                                  column(6,
                                         numericInput(inputId ="mean2", label = "Select the mean for y", "100")
                                  )),
                                fluidRow(
                                  column(6,
                                         numericInput(inputId ="std1", label = "Select the standart deviation for x", "15")),
                                  column(6,
                                         numericInput(inputId ="std1", label = "Select the standart deviation for y", "15")
                                  )),
                                numericInput("cov12", "input covxy", "0"),
                                numericInput(inputId ="range1", label = "Input range of randov variable X", value = "100"),
                                
                                sliderInput(inputId ="teta", label = "Input teta", min = 0, max=360, value = 30),
                                sliderInput(inputId ="phi", label = "Input phi", min = 0, max=360, value = 45),
                                ##--
                                  sliderInput(inputId="bin1", label="Select number of bins for histogram x",value = 10, min = 2, max = 160),
                                sliderInput(inputId="bin2", label="Select number of bins for histogram y",value = 10, min = 2, max = 160)
                       )) #tabsetPanel             
        
      
    ),#sidebarPanel
    mainPanel("Main Panel",
              tabsetPanel( type="tab",
                           tabPanel("Normal distribution 2D", 
                                    textOutput("text1"),
                                    plotOutput("hist", click = "plot_click", width = 400),
                                    verbatimTextOutput("info"), 
                                    plotOutput("density", click = "plot_click1", width = 400 ),
                                    verbatimTextOutput("info1"),
                                    plotOutput("cumulata")),
                           tabPanel("Normal distribution 3D",
                                    textOutput("text12"),
                                    plotOutput("b", click = "plot_clickpdf", width = 1000),
                                    verbatimTextOutput("infopdf"),
                                    plotOutput("hist2",brush  = "plot_click2", width = 400),
                                    verbatimTextOutput("info2"),
                                    verbatimTextOutput("a")
                                    
                                   
                                    ),
                           tabPanel("error",
                                    plotOutput("densiterr"))
                           )#tabsetpanel
              
                                    
                           
            
              
              )#mainPanel
  )#sidebarLayout
)#FluidPage
  
  
)#shinyUI

