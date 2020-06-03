library(lintr)
data <- read.csv("data/data.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8-BOM"
)

data[, 5:11] <- sapply(data[, 5:11], as.numeric)

server <- function(input, output) {
  # PLOT 1 #############################################################
  output$plot1 <- renderPlotly({
    # Initial data selection
    page1_data <- data %>%
      select(year, country, region, epr_female, epr_male, income_pc) %>%
      filter(year != 2018) %>%
      drop_na() %>%
      mutate(epr_avg = (epr_female + epr_male) / 2)

    # Function to determine income bracket
    inc_bracket <- function(income, year_input) {
      year_data <- page1_data %>%
        filter(year == year_input)

      range <- range(year_data$income_pc)
      difference <- range[2] - range[1]
      lowest_10 <- range[1] + 0.1 * difference
      lower_40 <- lowest_10 + 0.4 * difference
      upper_40 <- lower_40 + 0.4 * difference

      if (income <= lowest_10) {
        return("1: Lowest 10%")
      }
      else if (income <= lower_40) {
        return("2: 10%-50%")
      }
      else if (income <= upper_40) {
        return("3: 50%-90%")
      }
      else {
        return("4: Top 10%")
      }
    }

    # Function to label axes, titles, etc using proper names
    labels <- function(gender) {
      if (gender == "epr_female") {
        return("Female Employment to Population Ratio")
      }
      else if (gender == "epr_male") {
        return("Male Employment to Population Ratio")
      }
      else {
        return("Average Employment to Population Ratio")
      }
    }

    # Filter data to input year and add income bracket
    page1_data <- page1_data %>%
      filter(year == input$year1) %>%
      mutate(income_bracket = sapply(income_pc, inc_bracket, input$year1))

    # Set radio button input to desired column
    col <- switch(input$gender, epr_female = page1_data$epr_female,
      epr_male = page1_data$epr_male, epr_avg = page1_data$epr_avg
    )

    # Plot
    plot <- ggplot(
      data = page1_data,
      aes(
        fill = region,
        y = col,
        x = income_bracket,
        group = income_pc,
        text = paste0(
          "Country: ", country, "<br>",
          "Income per capita: $", round(income_pc, 2), "<br>",
          labels(input$gender), ": ", round(col, 2)
        )
      )
    ) +
      geom_bar(
        stat = "identity",
        position = position_dodge2(preserve = "single")
      ) +
      labs(
        title = paste0(
          labels(input$gender), " vs Income Bracket by Region in ",
          input$year1
        ),
        x = "Income Brackets",
        y = labels(input$gender)
      )
    plot <- ggplotly(plot, tooltip = "text")
    return(plot)
  })

  # PLOT 2 #############################################################
  output$plot2 <- renderPlotly({
    country_vector <- c(
      input$region1, input$region2, input$region3,
      input$region4, input$region5, input$region6,
      input$region7
    )
    page2_data <- data %>%
      filter(year == input$years &
               country %in% country_vector)

    scatterplot <- ggplot(page2_data) +
      geom_point(mapping = aes_string(
        x = "income_pc",
        y = "co2_emissions",
        color = "country",
        size = "income_pc",
        alpha = 0.8
      )) +
      geom_line(stat = "smooth", linetype = "dashed",
                mapping = aes(income_pc, co2_emissions),
                colour = "black", alpha = 0.3, method = lm, se = FALSE) +
      labs(
        title = paste0("CO2 Emissions vs. Income (", input$years, ")"),
        x = "Income (per capita)",
        y = "CO2 Emissions (metric tons per capita)"
      ) +
      guides(size = FALSE, alpha = FALSE) +
      theme(plot.title = element_text(hjust = 0.5))

    interactive <- ggplotly(scatterplot,
                            tooltip = c("country", "x", "y")
    )
    return(interactive)
  })

  # PLOT 3 #############################################################
  output$edu_plot <- renderPlotly({
    # additional filtering data to use in plot
    df_for_plot <- df_melt %>%
      filter(percentage != 0,
             income_pc != 0,
             year == input$year,
             edu_level == input$education)
    # build actual plot
    edu_plot <- plot_ly(
      data = df_for_plot,
      x = ~income_pc,
      y = ~percentage,
      type = "scatter",
      mode = "markers",
      hovertext = (df_for_plot$country),
      opacity = 1,
      color = ~region,
      size = 1
    ) %>%
      layout(
        title = paste("Percent Population in", names(school_type)
                      [school_type == input$education],
                      "School in", input$year),
        xaxis = list(title = "Income (per capita)", range = c(0, 55000)),
        yaxis = list(title = "Population in School (%)", range = c(0, 0.3))
      )
  })

  output$chart1 <- renderText({
    c(
      '<img src="',
      "https://i.imgur.com/TgQPZto.png",
      '">'
    )
  })
  
  # Chart 2
  output$chart2 <- renderText({
    c(
      '<img src="',
      "https://i.imgur.com/qZgfB3a.png",
      '">'
    )
  })
  
  #Chart 3
  output$chart3 <- renderText({
    c(
      '<img src="',
      "https://i.imgur.com/yFt37Gc.png",
      '">'
    )
  })
}
