link <- read_html("https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/situacionActual.htm") %>%
  html_node("li:nth-child(9) a") %>%
  html_attr("href")

url <- paste("https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/", link, sep = "")

t <- extract_tables(url,
                    output = "data.frame",
                    pages = 1,
                    area = list(c(126.0359, 169.1034, 405.8357, 274.9735)),
                    guess = FALSE
                    )

date1 <- as.Date(t[[1]]$TOTAL.HASTA[1], "%d/%m/%Y")
date2 <- as.Date(t[[1]]$TOTAL..HASTA[1], "%d/%m/%Y")

count1 <- t[[1]]$TOTAL.HASTA[22] %>%
  gsub("\\.", "", x = .) %>%
  as.integer()

count2 <- t[[1]]$TOTAL..HASTA[22] %>%
  gsub("\\.", "", x = .) %>%
  as.integer()

add_snapshot(
  count = count2,
  date = date2,
  sheet_name = "Spain",
  country = "Spain",
  units = "tests performed",
  source_url = url,
  source_label = "Ministerio de Sanidad, Consumo y Bienestar Social"
)
