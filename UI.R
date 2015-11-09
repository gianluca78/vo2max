library(shiny)

shinyUI(fluidPage(
    titlePanel("VO2Max estimator"),
    a("Click here for the documentation", href = "./documentation.html"),
    
    fluidRow(
        column(7, wellPanel(
            h2("Predictor variables"),
            p("Please, fill in the following questionnaire to discover your estimated
              level of fit throught the VO2max. The results will be printed \"live\"
              in the right part of the webpage."),
            h3(toupper("Section 1. General Data")),
            radioButtons("sex", 
                         label = h3("Sex"),
                         choices = list("Male" = 1, "Female" = 0)
            ),
            numericInput("age", 
                         label = h3("Age in years"), 
                         value = NULL),    
            numericInput("weight", 
                         label = h3("Weight in kilograms"), 
                         value = NULL),
            numericInput("height", 
                         label = h3("Height in meters"), 
                         value = NULL),
            h3(toupper("Section 2. Physical activity")),
            radioButtons("physical_activity_1", 
                         label = h3("Suppose you were going to exercise 
                                    continuously on an indoor track
                                    for 1 mile. Which exercise pace is just for you not 
                                    too easy and not too hard."),
                         choices = list(
                             "Walking at a slow pace (18 minutes per mile or more)." = 1, 
                             "Walking at a medium pace (16 minutes per mile or more)." = 3, 
                             "Walking at a fast pace (14 minutes per mile or more)." = 5,
                             "Jogging at a slow pace (12 minutes per mile or more)." = 7,
                             "Jogging at a medium pace (10 minutes per mile or more)." = 9,
                             "Jogging at a fast pace (8 minutes per mile or more)." = 11,
                             "Running at a fast pace (7 minutes per mile or less)." = 13
                         )
            ),
            radioButtons("physical_activity_2", 
                         label = h3("How fast could you cover a distance of 3 miles 
                                    and NOT become breathless or overly fatigued? Be realistic."),
                         choices = list(
                             "I could walk the entire distance at a slow pace (18 minutes per mile or more)." = 1, 
                             "I could walk the entire distance at a medium pace (16 minutes per mile or more)." = 3, 
                             "I could walk the entire distance at a fast pace (14 minutes per mile or more)." = 5, 
                             "I could jog the entire distance at a slow pace (12 minutes per mile or more)." = 7, 
                             "I could jog the entire distance at a medium pace (10 minutes per mile or more)." = 9,
                             "I could jog the entire distance at a fast pace (8 minutes per mile or more)." = 11,
                             "I could run the entire distance at a fast pace (7 minutes per mile or more)." = 13
                         )
            ),            
            radioButtons("physical_activity_3", 
                         label = h3("Select the number that best describes your 
                                    overall level of physical
                                    activity for the previous 6 months."),
                         choices = list(
                             "Avoid walking or exertion; e.g. always use elevator, drive
                             when possible instead of walking." = 0,
                             "Light activity: walk for pleasure, routinely use stairs,
                             occasionally exercise sufficiently to cause heavy breathing
                             or perspiration." = 1,
                             "Moderate activity: 10 to 60 minutes per week of moderate 
                             activity; such as golf, horseback riding, calisthenics, 
                             table tennis, bowling, weight lifting, yard work, cleaning 
                             house, walking for exercise." = 2,
                             "Moderate activity: over 1 hour per week of moderate activity
                             as described above." = 3,
                             "Vigorous activity: run less than 1 mile per week or spend 
                             less than 30 minutes per week 
                             in comparable activity such as running 
                             or jogging, lap swimming, cycling, rowing, 
                             aerobics, skipping rope, running in place, or 
                             engaging in vigorous aerobic-type activity 
                             such as soccer, basketball, tennis, racquetball, 
                             or handball." = 4,
                             "Vigorous activity: run 1 mile to less than 5 miles 
                             per week, or spend 30 minutes to less 
                             than 60 minutes per week in comparable 
                             physical activity as described above." = 5,
                             "Vigorous activity: run 5 mile to less than 10 miles 
                             per week, or spend 1 hour to less 
                             than 3 hours per week in comparable 
                             physical activity as described above." = 6,
                             "Vigorous activity: run 10 mile to less than 15 miles 
                             per week, or spend 3 hours to less 
                             than 6 hours per week in comparable 
                             physical activity as described above." = 7,
                             "Vigorous activity: run 15 mile to less than 20 miles 
                             per week, or spend 6 hours to less 
                             than 7 hours per week in comparable 
                             physical activity as described above." = 8,
                             "Vigorous activity: run 20 mile to less than 25 miles 
                             per week, or spend 7 hours to less 
                             than 8 hours per week in comparable 
                             physical activity as described above." = 9,
                             "Vigorous activity: run over 25 mile per week, or spend 
                             over 8 hours per week in comparable 
                             physical activity as described above." = 10                                                                                      
                         )
            )            
            
        )),
        column(5, 
               h2("Results"),
               htmlOutput("vo2max"),
               htmlOutput("evaluation")               
        )
    )
))
