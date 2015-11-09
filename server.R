library(shiny)

shinyServer(function(input, output) {    
    normVo2max <- data.frame(
        sex = c(0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1),
        ageStart = c(13, 20, 30, 40, 50, 60, 13, 20, 30, 40, 50, 60),
        ageEnd = c(19, 29, 39, 49, 59, 120, 19, 29, 39, 49, 59, 120),
        veryPoorStart = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
        veryPoorEnd = c(25, 23.6, 22.8, 21, 20.2, 17.5, 35, 33, 31.5, 30.2, 26.1, 20.5),
        poorStart = c(25, 23.6, 22.8, 21.0, 20.2, 17.5, 35, 33, 31.5, 30.2, 26.1, 20.5),
        poorEnd = c(30.9, 28.9, 26.9, 24.4, 22.7, 20.1, 38.3, 36.4, 35.4, 33.5, 30.9, 26),
        fairStart = c(31, 29, 27, 24.5, 22.8, 20.2, 38.4, 36.5, 35.5, 33.6, 31, 26.1),
        fairEnd = c(34.9, 32.9, 31.4, 28.9, 26.9, 24.4, 45.1, 42.4, 40.9, 38.9, 35.7, 32.2),
        goodStart = c(35, 33, 31.5, 29, 27, 24.5, 45.2, 42.5, 41, 39, 35.8, 32.3),
        goodEnd = c(38.9, 36.9, 35.6, 32.8, 31.4, 30.2, 50.9, 46.4, 44.9, 43.7, 40.9, 36.4),
        excellentStart = c(39, 37, 35.7, 32.9, 31.5, 30.3, 51, 46.5, 45, 43.8, 41, 36.5),
        excellentEnd = c(41.9, 41, 40, 36.9, 35.7, 31.4, 55.9, 52.4, 49.4, 48, 45.3, 44.2),
        superiorStart = c(41.9, 41, 40, 36.9, 35.7, 31.4, 55.9, 52.4, 49.4, 48, 45.3, 44.2),
        superiorEnd = c(100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100)
    )
    
    calculateVo2max <- function(weigth, height, sex, physicalActivityItem1, 
                                physicalActivityItem2, physicalActivityItem3) {
        
        bmi <- input$weight / (input$height ^ 2)
        
        44.895 + (7.042 * as.numeric(input$sex)) - (0.823 * bmi) + 
            (0.738 * (
                (as.numeric(input$physical_activity_1) * 1.0) + 
                    (as.numeric(input$physical_activity_2) * 1.0))
            ) + 
            (0.688 * as.numeric(input$physical_activity_3))        
    }
    
    evaluateVo2Max <- function(vo2max, sex, age) {                
        normForAgeSex <- subset(normVo2max, sex == sex & age >= ageStart 
                                & age <= ageEnd)
        
        normForAgeSex <- normForAgeSex[1, ]
        
        if(vo2max < normForAgeSex$veryPoorStart) {
            return("very poor")
        }
        
        if(vo2max <= normForAgeSex$poorEnd & vo2max >= normForAgeSex$poorStart) {
            return("poor")
        }
        
        if(vo2max <= normForAgeSex$fairEnd & vo2max >= normForAgeSex$fairStart) {
            return("fair")
        }
        
        if(vo2max <= normForAgeSex$goodEnd & vo2max >= normForAgeSex$goodStart) {
            return("poor")
        }
        
        if(vo2max <= normForAgeSex$excellentEnd & vo2max >= normForAgeSex$excellentStart) {
            return("excellent")
        }
        
        if(vo2max > normForAgeSex$superiorStart) {
            return("superior")
        }        
    }
    
    vo2max <- reactive({
        calculateVo2max(input$weight, input$height, input$sex,
                        input$physical_activity_1, input$physical_activity_2,
                        input$physical_activity_3)              
    })
    
    vo2maxNormEvaluation <- reactive({
        evaluateVo2Max(
            calculateVo2max(input$weight, input$height, input$sex,
                            input$physical_activity_1, input$physical_activity_2,
                            input$physical_activity_3),
            input$sex,
            input$age                   
        )
    })
    
    output$vo2max <- renderText({ 
        validate(
            need(input$age, "The field age is required"),
            need(input$weight, "The fied weight is required"),
            need(input$height, "The field height is required")
        )        
        paste("Your estimated VO2Max is: <strong>", round(vo2max(), 2), "</strong>")
    })
    
    output$evaluation <- renderText({
        validate(
            need(input$age, ""),
            need(input$weight, ""),
            need(input$height, "")            
        )        
        paste("According to the normative data for your age, your level of fit is:", 
              "<strong>", vo2maxNormEvaluation(), "</strong>")
    })
})
