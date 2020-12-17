FROM rocker/tidyverse:3.6.0

RUN echo "options(repos = c(CRAN = 'https://cloud.r-project.org'))" >> /usr/local/lib/R/etc/Rprofile.site

RUN R -e "install.packages('pacman', repos = 'https://cran.rstudio.com')"
RUN R -e "pacman::p_load(DescTools)"
RUN R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/shinycssloaders/shinycssloaders_0.2.0.tar.gz', repos=NULL, type='source')"
RUN R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/googleAuthR/googleAuthR_0.7.0.tar.gz', repos=NULL, type='source')"
RUN R -e "pacman::p_load(googleAnalyticsR,tidyverse, shinydashboard, data.table, formattable, shinyBS, rpart, shinyWidgets, plotly, ggiraph, shinyjs, here, readxl, gsheet)"
RUN R -e "pacman::p_load(openxlsx)"
RUN R -e "pacman::p_load(RColorBrewer, circlize, networkD3, rpart.plot)"
RUN R -e "pacman::p_load(bsplus)"
RUN R -e "pacman::p_load(googledrive)"
RUN R -e "pacman::p_load(matrixStats)"
RUN R -e "pacman::p_load(forecast, sunburstR, checkpoint)"
RUN R -e "pacman::p_load(sass)"
RUN R -e "pacman::p_load(crul)" # For api async call

RUN apt-get update && apt-get install -y cron anacron openjdk-8-jdk openjdk-8-jre r-cran-rjava && apt-get clean
RUN apt-get install -y libmariadbclient-dev # For SQL
RUN R -e "install.packages('DBI')" # For SQL
RUN R -e "install.packages('RMySQL')" #For SQL

RUN R CMD javareconf
RUN R CMD javareconf JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
RUN mkdir -p /etc/crond.d

RUN install2.r mailR

RUN R -e "pacman::p_load(reactable)"
RUN R -e "sessionInfo()"

FROM datamacoredep2

RUN mkdir /home/datamacore2

COPY datama-core /home/datamacore2/datama-core

WORKDIR /home/datamacore2/datama-core

RUN R CMD INSTALL . -c --build
