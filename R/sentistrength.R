#' SentiStrength
#'
#' Runs SentiStrength
#'
#' @param text The text on which to run SentiStrength.
#' @param sentistrength.data Location of the folder containing the
#'   SentiStrength language data.
#' @param parse If TRUE, parses the output of SentiStrength into a
#'   \code{data.table} object.
#' @return The output of SentiStrength as a character vector or parsed
#'   as a \code{data.table} object.
#' @export
SentiStrength <- function(text,
                          sentistrength.data=SentiStrengthData("sentidata_en"),
                          parse=TRUE) {
  text <- gsub("[[:blank:]\n\r]+", " ", text)
  text <- paste(text, collapse="\n")
  if (!grepl("/$", sentistrength.data)) {
    sentistrength.data <- paste0(sentistrength.data, "/")
  }
  senti.jar <- system.file("sentistrength", "sentistrength.jar",
                           package="RSentiStrength", mustWork=TRUE)
  senti.args <- c("-jar", senti.jar, "sentidata", sentistrength.data,
                  "stdin", "mood", "0")
  res <- system2("java", senti.args, stdout=TRUE, input=text)
  if (parse) {
    data.table(min=as.numeric(sub("^(.*)\t(.*)\t", "\\2", res)),
               max=as.numeric(sub("^(.*)\t(.*)\t", "\\1", res)))
  } else res
}

#' Polarity
#'
#' Computes the polarity of a text document based on SentiStrength's
#' positive and negative scores.
#'
#' @param positive Positive scores as computed by SentiStrength
#' @param negative Negative scores as computed by SentiStrength
#' @param neutral.limit If positive and negative are equals and are
#'   below this below, then the result is neutral, otherwise NA.
#' @return -1, 0, 1 or NA based on the overall computed polarity.
#' @references M. Thelwall, K. Buckley, and G. Paltoglou,
#'   "Sentiment strength detection for the social web,"
#'   *J. Am. Soc. Inf. Sci. Technol.*, vol. 63, no. 1, pp. 163–173,
#'   Jan. 2012.
#' @export
#'
#' @examples
#' Polarity(1, -1)
#' Polarity(2, -1)
#' Polarity(1, -2)
#' Polarity(3, -3)
#' Polarity(c(5, 4, 4), c(-4, -5, -4))
#' Polarity(5, -5, 6)
#' Polarity(c(1, 2), c(-1, -2), 2)
Polarity <- function(positive, negative, neutral.limit=4) {
  polarity <- data.table(positive, negative, score=NA_integer_)
  polarity[positive < neutral.limit, score := 0]
  polarity[positive + negative > 0, score := 1]
  polarity[positive + negative < 0, score := -1]
  polarity$score
}
