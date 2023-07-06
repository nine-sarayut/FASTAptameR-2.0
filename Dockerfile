# Use a Shiny base image from Docker Hub
FROM rocker/shiny:latest
LABEL Maintainer="Sarayut (Nine) Winuthayanon, https://www.linkedin.com/in/winuthayanons/"

# Install CMake and libssl-dev
RUN apt-get update && \
    apt-get install -y cmake libssl-dev

# Copy the app files into the Docker image
COPY functions/ /srv/shiny-server/functions/
COPY trans/ /srv/shiny-server/trans/
COPY uiTabs/ /srv/shiny-server/uiTabs/
COPY www/ /srv/shiny-server/www/
COPY app.R /srv/shiny-server/
COPY run.sh /usr/bin/run.sh

# Copy the custom run script into the Docker image
COPY run.sh /usr/bin/run.sh

# Set the executable permissions for the custom run script
RUN chmod +x /usr/bin/run.sh

# Install R packages
RUN R -e "install.packages(c('shiny', 'shinythemes', 'stringi', 'DT', 'shinyBS', 'shinyjs', 'shinycssloaders', 'colourpicker', 'purrr', 'shinyFiles', 'UpSetR'), repos='https://cran.rstudio.com/')"
RUN R -e "install.packages(c('dplyr', 'ggplot2', 'plotly', 'kmer', 'factoextra', 'jsonlite'), repos='https://cran.rstudio.com/')"

# Expose port 3838 for Shiny Server
EXPOSE 3838

# Set the command to start the Shiny app when the container is run
CMD ["/usr/bin/run.sh"]
