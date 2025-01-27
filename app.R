library(shiny)
library(shinydashboard)
library(DT) # For rendering data tables
library(ggplot2)
library(GGally)
library(pheatmap)
library(reshape2)
library(plotly)
library(dbscan)
library(DiagrammeR)
library(rsconnect)


# Define UI for the application
ui <- dashboardPage(
  dashboardHeader(
    title = tags$div(
      "Data Visualization")
),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard"),
      
      
      
    
      menuItem("Univariate Analysis", tabName = "univar",
               menuSubItem("Histogram", tabName = "hist"),
               menuSubItem("Box Plot", tabName = "boxplot"),
               menuSubItem("Density Plot", tabName = "denplot"),
               menuSubItem("Violin Plot", tabName = "vioplot")
      ),
      menuItem("Multivariate Analysis", tabName = "mulvar",
               menuSubItem("Pair Plot", tabName = "pairplot"),
               menuSubItem("Scatter Plot", tabName = "scatterplot"),
               menuSubItem("Correlation Heatmap", tabName = "corheatmap"),
               menuSubItem("3D Scatter Plot", tabName = "scatter3d")
      ),
      

       menuItem("Clustering", tabName = "clus",
                   menuSubItem("K-Means", tabName = "kmeans"),
                   menuSubItem("Hierarchical", tabName = "hierarchical"),
                   menuSubItem("DBSCAN", tabName = "dbscan")
          )

      
    )
  ),
  dashboardBody(
    tabItems(
      # Dashboard Tab
      tabItem(
        tabName = "dashboard",
        fluidRow(
          # Add Dataset Description
          box(
            title = "About the Iris Dataset",
            status = "info",
            solidHeader = TRUE,
            width = 12,
            p("The Iris dataset is a classic dataset in machine learning and statistics, consisting of 150 observations of iris flowers. 
         Each observation contains measurements of sepal length, sepal width, petal length, and petal width, 
         as well as the species of the flower: Setosa, Versicolor, or Virginica."),
            p("It is widely used for classification, clustering, and visualization tasks.")
          ),
          # Add Summary Table
          box(
            title = "Summary of Iris Dataset",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            dataTableOutput("irisSummary")
          ),
          # Add Flowchart for Visualizations
          box(
            title = "Visualizations Overview",
            status = "warning",
            solidHeader = TRUE,
            width = 12,
            DiagrammeR::grViz("
digraph IRIS_Dataset {
  graph [layout = dot, rankdir = TB, bgcolor = '#f9f9f9']

  # Main node
  IRIS [label = 'IRIS DATASET', shape = box, style = filled, fillcolor = '#cce5ff', fontcolor = '#333333'];

  # Main subcategories
  Univariate [label = 'Univariate Analysis', shape = ellipse, style = filled, fillcolor = '#e6f7ff', fontcolor = '#333333'];
  Multivariate [label = 'Multivariate Analysis', shape = ellipse, style = filled, fillcolor = '#e6ffe6', fontcolor = '#333333'];
  Clustering [label = 'Clustering', shape = ellipse, style = filled, fillcolor = '#ffe6e6', fontcolor = '#333333'];

  # Subparts of Univariate
  Uni_1 [label = 'Histograms', shape = box, style = filled, fillcolor = '#f2f9ff', fontcolor = '#333333'];
  Uni_2 [label = 'Boxplots', shape = box, style = filled, fillcolor = '#f2f9ff', fontcolor = '#333333'];
  Uni_3 [label = 'Density Plots', shape = box, style = filled, fillcolor = '#f2f9ff', fontcolor = '#333333'];

  # Subparts of Multivariate
  Multi_1 [label = 'Scatter Plots', shape = box, style = filled, fillcolor = '#f9fff9', fontcolor = '#333333'];
  Multi_2 [label = 'Pair Plots', shape = box, style = filled, fillcolor = '#f9fff9', fontcolor = '#333333'];
  Multi_3 [label = 'Correlation Matrices', shape = box, style = filled, fillcolor = '#f9fff9', fontcolor = '#333333'];

  # Subparts of Clustering
  Clust_1 [label = 'K-Means', shape = box, style = filled, fillcolor = '#fff9f9', fontcolor = '#333333'];
  Clust_2 [label = 'Hierarchical', shape = box, style = filled, fillcolor = '#fff9f9', fontcolor = '#333333'];
  Clust_3 [label = 'DBSCAN', shape = box, style = filled, fillcolor = '#fff9f9', fontcolor = '#333333'];

  # Relationships
  IRIS -> {Univariate Multivariate Clustering};

  Univariate -> {Uni_1 Uni_2 Uni_3};
  Multivariate -> {Multi_1 Multi_2 Multi_3};
  Clustering -> {Clust_1 Clust_2 Clust_3};
}
")
          )
        )
      ),
      
      
      
      # Univariate Analysis Tab
      tabItem(
        tabName = "univar",
        fluidRow(
          box(
            title = "Univariate Analysis",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            p("Univariate analysis involves analyzing the distribution and characteristics of a single variable. 
         Below are buttons to visualize the univariate analysis for different features using various plots."),
            actionButton("go_hist", "Go to Histogram"),
            actionButton("go_boxplot", "Go to Box Plot"),
            actionButton("go_denplot", "Go to Density Plot"),
            actionButton("go_vioplot", "Go to Violin Plot")
          )
        )
      ),
      
      
      # Histogram Tab
      tabItem(
        tabName = "hist",
        fluidRow(
          box(
            title = "Histogram",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("hist_feature", "Select Feature:", 
                        choices = colnames(iris)[1:4], 
                        selected = "Sepal.Length"), # Default feature
            sliderInput("bins", "Number of Breaks",
                min=1,max=100,value=50),
            plotOutput("histogram")
          )
        )
      ),
      
      
      
      tabItem(
        tabName = "boxplot",
        fluidRow(
          box(
            title = "Box Plot",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("box_feature", "Select Feature:", 
                        choices = colnames(iris)[1:4], 
                        selected = "Sepal.Length"), # Default feature
            plotOutput("boxplot")
          )
        )
      ),
      
      
      tabItem(
        tabName = "denplot",
        fluidRow(
          box(
            title = "Density Plot",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("den_feature", "Select Feature:", 
                        choices = colnames(iris)[1:4], 
                        selected = "Sepal.Length"), # Default feature
            plotOutput("densityplot")
          )
        )
      ),
      
      
      # Violin Plot Tab
      tabItem(
        tabName = "vioplot",
        fluidRow(
          box(
            title = "Violin Plot",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("vio_feature", "Select Feature:", 
                        choices = colnames(iris)[1:4], 
                        selected = "Sepal.Length"), # Default feature
            plotOutput("violinplot")
          )
        )
      ),
      
      
      ############ MULTI######################
      #pairplot
      tabItem(
        tabName = "pairplot",
        fluidRow(
          box(
            title = "Pair Plot",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("pairplot_x", "Select X Feature:", choices = colnames(iris)[1:4], selected = "Sepal.Length"),
            selectInput("pairplot_y", "Select Y Feature:", choices = colnames(iris)[1:4], selected = "Sepal.Width"),
            plotOutput("pairplot")
          )
        )
      ),
      
      
      #scatter plot
      tabItem(
        tabName = "scatterplot",
        fluidRow(
          box(
            title = "Scatter Plot",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("scatter_feature_x", "Select X Feature:", choices = colnames(iris)[1:4], selected = "Sepal.Length"),
            selectInput("scatter_feature_y", "Select Y Feature:", choices = colnames(iris)[1:4], selected = "Sepal.Width"),
            sliderInput("point_size", "Select Point Size:", min = 1, max = 8, value = 3),
            plotOutput("scatterplot")
          )
        )
      ),
      
      
      tabItem(
        tabName = "corheatmap",
        fluidRow(
          box(
            title = "Correlation Heatmap by Species",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("cor_species", "Select Species:", 
                        choices = unique(iris$Species), 
                        selected = "setosa"),  # Default to 'setosa'
            plotOutput("cor_heatmap")
          )
        )
      ),
      
      
      #3d plot
      tabItem(
        tabName = "scatter3d",
        fluidRow(
          box(
            title = "3D Scatter Plot by Species",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            selectInput("xaxis", "Select X-axis:", 
                        choices = colnames(iris)[1:4], 
                        selected = "Sepal.Length"),
            selectInput("yaxis", "Select Y-axis:", 
                        choices = colnames(iris)[1:4], 
                        selected = "Sepal.Width"),
            selectInput("zaxis", "Select Z-axis:", 
                        choices = colnames(iris)[1:4], 
                        selected = "Petal.Length"),
            sliderInput("point_size", "Select Point Size:", 
                        min = 1, max = 8, value = 5),
            plotlyOutput("scatter3d_plot")
          )
        )
      ),
      
      
      
      
      ##################### clustering#######################
      #kmeans
        tabItem(tabName = "kmeans",
                fluidRow(
                  box(title = "K-Means Clustering",
                      status = "primary",
                      solidHeader = TRUE,
                      width = 12,
                      selectInput("kmeans_k", "Select number of clusters (K):", 
                                  choices = 2:3, selected = 3),
                      sliderInput("kmeans_point_size", "Select Point Size:", 
                                  min = 1, max =8, value = 3),
                      plotOutput("kmeans_plot")
                  )
                )
        ),
        
        
        #hierarchical
        tabItem(tabName = "hierarchical",
                fluidRow(
                  box(title = "Hierarchical Clustering",
                      status = "primary",
                      solidHeader = TRUE,
                      width = 12,
                      sliderInput("hclust_point_size", "Select Point Size:", 
                                  min = 1, max = 20, value = 5),
                      sliderInput("hclust_threshold", "Select Threshold:", 
                                  min = 0, max = 1, value = 0.5),
                      selectInput("hclust_clusters", "Select Number of Clusters:", 
                                  choices = 2:3, selected = 3),
                      plotOutput("hclust_plot")
                  )
                )
        ),
      
      
      
      
      
        
        #dbscan
        tabItem(tabName = "dbscan",
                fluidRow(
                  box(title = "DBSCAN Clustering",
                      status = "primary",
                      solidHeader = TRUE,
                      width = 12,
                      sliderInput("dbscan_point_size", "Select Point Size:", 
                                  min = 1, max = 8, value = 5),
                      sliderInput("dbscan_eps", "Select Epsilon (Neighborhood Size):", 
                                  min = 0.1, max = 2, value = 0.5, step = 0.1),
                      sliderInput("dbscan_minPts", "Select Minimum Points (minPts):", 
                                  min = 1, max = 10, value = 5),
                      plotOutput("dbscan_plot")
                  )
                )
        )
      
  
    )
  ), 
        
tags$head(
  tags$title("Data Visualization Dashboard")  # Correctly set the browser tab title
)
 


)

# Define server logic required
server <- function(input, output, session) {
  # Render histogram
  output$histogram <- renderPlot({
    selected_feature <- input$hist_feature
    hist(iris[[selected_feature]], 
         breaks = input$bins, 
         col = "lightblue", 
         border = "white", 
         main = paste("Histogram of", selected_feature),
         xlab = selected_feature)
  })
  
  # Render iris dataset summary
  output$irisSummary <- renderDataTable({
    iris_summary <- data.frame(
      Feature = colnames(iris)[1:4],
      Min = apply(iris[, 1:4], 2, min),
      Max = apply(iris[, 1:4], 2, max),
      Mean = round(apply(iris[, 1:4], 2, mean), 2),
      Median = apply(iris[, 1:4], 2, median),
      SD = round(apply(iris[, 1:4], 2, sd), 2)
    )
    datatable(iris_summary, options = list(dom = "t", pageLength = 5), rownames = FALSE)
  })
  
  
  
  # Redirect to Histogram
  observeEvent(input$go_hist, {
    updateTabItems(session, "sidebar", selected = "hist")
  })
  
  # Redirect to Box Plot
  observeEvent(input$go_boxplot, {
    updateTabItems(session, "sidebar", selected = "boxplot")
  })
  
  # Redirect to Density Plot
  observeEvent(input$go_denplot, {
    updateTabItems(session, "sidebar", selected = "denplot")
  })
  
  # Redirect to Violin Plot
  observeEvent(input$go_vioplot, {
    updateTabItems(session, "sidebar", selected = "vioplot")
  })
  
  
  
  
  #Box PLOt logic
  output$boxplot <- renderPlot({
    selected_feature <- input$box_feature
    boxplot(iris[[selected_feature]], 
            main = paste("Box Plot of", selected_feature),
            ylab = selected_feature,
            col = "lightblue", 
            border = "black")
  })
  
  
  #Density Plot
  output$densityplot <- renderPlot({
    selected_feature <- input$den_feature
    plot(density(iris[[selected_feature]]), 
         main = paste("Density Plot of", selected_feature),
         xlab = selected_feature,
         col = "lightblue", lwd = 5)
  })
  
  
  
  #Violin Plot
  output$violinplot <- renderPlot({
    selected_feature <- input$vio_feature
    ggplot(iris, aes_string(x = "Species", y = selected_feature)) +
      geom_violin(trim = FALSE, fill = "lightblue",
                  color = "darkblue") +
      labs(title = paste("Violin Plot of", selected_feature), 
           x = "Species", y = selected_feature) +
      theme_minimal()
  })
  
  
  
  #################### MULTIVARIATE######################
  
  #pairplot
  output$pairplot <- renderPlot({
    # Subset the selected features
    selected_data <- iris[, c(input$pairplot_x, input$pairplot_y, "Species")]
    
    # Create a pair plot for selected features
    ggpairs(selected_data, aes(color = selected_data$Species))
  })
  
  #scatterplot
  output$scatterplot <- renderPlot({
    ggplot(iris, aes_string(x = input$scatter_feature_x, y = input$scatter_feature_y, color = "Species")) +
      geom_point(size = input$point_size) +  # Adjust point size based on slider input
      labs(title = paste("Scatter Plot of", input$scatter_feature_x, "vs", input$scatter_feature_y)) +
      theme_minimal()
  })
  
  
  
  #correlation heatmap
  output$cor_heatmap <- renderPlot({
    # Subset the data based on selected species
    selected_species_data <- subset(iris, Species == input$cor_species)
    
    # Select only the numeric columns for correlation
    numeric_data <- selected_species_data[, 1:4]  # Sepal.Length, Sepal.Width, Petal.Length, Petal.Width
    
    # Calculate the correlation matrix
    cor_matrix <- cor(numeric_data)
    
    # Plot the correlation heatmap
    pheatmap(cor_matrix, 
             display_numbers = TRUE,   # Display correlation values in the heatmap
             clustering_distance_rows = "euclidean", 
             clustering_distance_cols = "euclidean",
             clustering_method = "complete",
             color = colorRampPalette(c("skyblue", "lightblue", "blue"))(50),
             main = paste("Correlation Heatmap -", input$cor_species),
             fontsize_number = 15,  # Adjust font size for numbers inside the heatmap
             number_color = "white",  # Change color of numbers (black in this case)
             fontface_number = "bold"
    )
  })
  
  
  
  
    #3d scatter plot
    output$scatter3d_plot <- renderPlotly({
      # Subset the data for the selected features
      selected_data <- iris[, c(input$xaxis, input$yaxis, input$zaxis, "Species")]
      
      # Create the 3D scatter plot
      plot_ly(data = selected_data, 
              x = ~get(input$xaxis), 
              y = ~get(input$yaxis), 
              z = ~get(input$zaxis), 
              color = ~Species, 
              colors = c("red", "green", "blue"), 
              type = "scatter3d", 
              mode = "markers", 
              marker = list(size = input$point_size)) %>%
        layout(scene = list(
          xaxis = list(title = input$xaxis),
          yaxis = list(title = input$yaxis),
          zaxis = list(title = input$zaxis)
        ), 
        title = paste("3D Scatter Plot of", input$Species))
    })
    
    
    
    
    ###########################Clustering################
    
    #kmeans
    
    output$kmeans_plot <- renderPlot({
      # Subset numeric data from the iris dataset
      data <- iris[, -5]  # Remove Species column
      
      # Perform K-means clustering
      set.seed(123)  # For reproducibility
      kmeans_result <- kmeans(data, centers = input$kmeans_k)
      
      # Plot the result
      ggplot(data, aes(x = Sepal.Length, y = Sepal.Width, color = factor(kmeans_result$cluster))) +
        geom_point(size = input$kmeans_point_size) +
        labs(title = paste("K-Means Clustering with", input$kmeans_k, "Clusters"), 
             x = "Sepal Length", y = "Sepal Width") +
        scale_color_manual(values = c("red", "green", "blue", "purple", "orange"))
    })
   
    
    
    
    #hclust
        output$hclust_plot <- renderPlot({
      # Subset numeric data from the iris dataset
      data <- iris[, -5]  # Remove the 'Species' column
      
      # Compute distance matrix
      dist_matrix <- dist(data)
      
      # Perform hierarchical clustering
      hclust_result <- hclust(dist_matrix)
      
      # Use the selected number of clusters from the slider
      clusters <- cutree(hclust_result, k = input$hclust_clusters)
      
      # Plot hierarchical clustering with dynamic point size
      ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = factor(clusters))) +
        geom_point(size = input$hclust_point_size) +
        labs(title = paste("Hierarchical Clustering (", input$hclust_clusters, " Clusters)", 
                           sep = ""), 
             x = "Sepal Length", y = "Sepal Width") +
        scale_color_manual(values = rainbow(input$hclust_clusters))  # Use a different color for each cluster
    })
    
    
    
    #dbscan
        output$dbscan_plot <- renderPlot({
          # Subset numeric data from the iris dataset
          data <- iris[, -5]  # Remove the 'Species' column
          
          # Perform DBSCAN clustering
          dbscan_result <- dbscan(data, eps = input$dbscan_eps, minPts = input$dbscan_minPts)
          
          # Plot DBSCAN clustering with dynamic point size
          ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = factor(dbscan_result$cluster))) +
            geom_point(size = input$dbscan_point_size) +
            labs(title = paste("DBSCAN Clustering (eps = ", input$dbscan_eps, ", minPts = ", input$dbscan_minPts, ")", 
                               sep = ""), 
                 x = "Sepal Length", y = "Sepal Width") +
            scale_color_manual(values = c("gray", rainbow(max(dbscan_result$cluster))))  # Use gray for noise and rainbow for clusters
        })
}

# Combine UI and server to create a Shiny app
shinyApp(ui = ui, server = server)
