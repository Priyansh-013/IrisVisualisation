# Data Visualization Dashboard

This is a Shiny web application for visualizing and analyzing the well-known **Iris dataset**. The app provides various univariate and multivariate visualization tools, clustering techniques, and interactive dashboards to explore the dataset's characteristics and relationships. It is hosted online and available for use at the following link:

[Visit the Dashboard](https://7k9w5y-priyansh-awasthi.shinyapps.io/findash/)

---

## Features

The dashboard includes the following features:

### 1. **Univariate Analysis**
   - Visualizations that focus on individual variables (features) in the Iris dataset.
   - Available plots:
     - **Histogram**: Create a histogram for any chosen feature with adjustable bin sizes.
     - **Box Plot**: Visualize the spread and outliers of individual features.
     - **Density Plot**: Show the distribution of a feature with a smoothed curve.
     - **Violin Plot**: Combine box plot and density plot for a better understanding of the feature distribution.

### 2. **Multivariate Analysis**
   - Visualizations that explore relationships between multiple features.
   - Available plots:
     - **Pair Plot**: A pairwise scatter plot to understand the relationship between different features.
     - **Scatter Plot**: A plot showing relationships between selected features, with options to adjust point sizes.
     - **Correlation Heatmap**: A heatmap showing the correlation matrix between features.
     - **3D Scatter Plot**: Visualize the data points in three dimensions with color differentiation by species.

### 3. **Clustering Techniques**
   - Explore various clustering algorithms to group data points based on similarities.
   - Available clustering methods:
     - **K-Means**: Group the data into user-defined clusters.
     - **Hierarchical Clustering**: A dendrogram-based method for hierarchical grouping of data points.
     - **DBSCAN**: A density-based clustering method for discovering arbitrarily shaped clusters.

---

## How to Use

1. **Access the App**: Visit [this link](https://7k9w5y-priyansh-awasthi.shinyapps.io/findash/) to open the application.
2. **Explore Visualizations**:
   - Navigate to the **Univariate Analysis** and **Multivariate Analysis** sections to generate various plots by selecting features and adjusting relevant parameters (e.g., number of bins, point sizes).
   - For clustering, choose your preferred clustering method and adjust the input parameters to experiment with different groupings of the data.
3. **Interact**: The app is interactive, allowing you to modify the visualizations dynamically by selecting different options through dropdowns and sliders.

---

## Technology Stack

This web app is built using:

- **R**: Programming language for statistical computing and graphics.
- **Shiny**: R package for building interactive web applications.
- **shinydashboard**: Provides a layout framework for creating dashboards in Shiny apps.
- **ggplot2**: For creating visualizations in the app.
- **plotly**: For interactive plots like the 3D scatter plot and heatmap.

---

## How to Run Locally

If you want to run this app on your local machine, follow these steps:

1. Install **R** from [CRAN](https://cran.r-project.org/).
2. Install the required libraries:

   ```R
   install.packages(c("shiny", "shinydashboard", "ggplot2", "plotly", "dplyr", "cluster"))
   ```
3. Clone this repository to your local machine.

4. In your R console, navigate to the project directory and run the app:

   ```R
   shiny::runApp()

5. The app will be hosted locally at http://127.0.0.1:XXXX.


## Contribution

Feel free to open an issue or pull request if you have suggestions for improving the app or adding new features.


---

## Acknowledgements

I would like to acknowledge the following resources and individuals who have contributed to the development of this project:

- **The Iris Dataset**: A classic dataset from the field of machine learning and statistics, widely used for classification and clustering tasks.
- **Shiny**: An R package that has made it easy to create interactive web applications with R.
- **Plotly**: An open-source graphing library that enables interactive plots and visualizations.
- **ggplot2**: A powerful R library used for creating static and interactive data visualizations.
- **Community and Open-Source Contributors**: Various open-source contributors whose work and documentation helped me in building and enhancing this app.

---

## Future Improvements

This web application is a work in progress, and there are several areas where it can be improved:

- **Additional Clustering Algorithms**: Adding more clustering algorithms such as Gaussian Mixture Models (GMM) or Agglomerative Clustering.
- **Feature Engineering Tools**: Integrating tools for feature engineering, selection, and preprocessing.
- **Interactive Visualizations**: Improving interactivity by allowing users to modify visualizations in real-time (e.g., adding interactivity to correlation heatmaps).
- **Deployment on Other Platforms**: Exploring deployment options on other platforms like Docker for easy installation and sharing.

---

## FAQ

**Q: Why is the Iris dataset used in this app?**  
A: The Iris dataset is a simple, yet powerful dataset that contains well-defined clusters and is commonly used to showcase machine learning models and data analysis techniques.

**Q: Can I use this app for other datasets?**  
A: Currently, the app is designed for the Iris dataset. Future versions may allow uploading custom datasets for analysis.

**Q: How accurate are the clustering algorithms?**  
A: The accuracy of clustering algorithms depends on the data and the parameters chosen. The app provides interactive features to tune the clustering parameters for optimal results.

---

## Contact

For any questions or feedback, feel free to reach out:

- **Email**: priyansh.awasthi@hotmail.com
- **GitHub**: [Priyansh-013](https://github.com/Priyansh-013)
- **LinkedIn**: [Priyansh Awasthi](www.linkedin.com/in/priyansh-awasthi-29113b251)

---

