#' SentiStrength Jar
#'
#' Specifies SentiStrength jar and copies it inside the installed
#' package folder.
#'
#' @param location Location of the file. Can be a local file name or a
#'   URL.
#' @param overwrite If FALSE, the function will fail if the file
#'   already exists.
#' @export
SentiStrengthJar <- function(location, overwrite=FALSE) {
  dest <- file.path(system.file(package="RSentiStrength"), "sentistrength")
  if (!file.exists(dest)) dir.create(dest)
  dest <- file.path(dest, "sentistrength.jar")
  if (overwrite || !file.exists(dest)) {
    if (grepl("^https?://", location)) {
      download.file(location, dest)
    } else {
      file.copy(location, dest, overwrite=TRUE)
    }
  } else stop("File %s already exists", dest)
}

#' Add SentiStrength Data
#'
#' Specifies SentiStrength language data and copies it inside the
#' installed package folder.
#'
#' @param location Location of the folder data.
#' @param datadir Name of the destination folder.
#' @param overwrite If FALSE, the function will fail if the file
#'   already exists.
#' @export
AddSentiStrengthData <- function(location, datadir="sentidata_en", overwrite=FALSE) {
  dest <- file.path(system.file(package="RSentiStrength"), "sentistrength", datadir)
  if (overwrite && file.exists(dest)) {
    message("Removing ", dest)
    unlink(dest, recursive=TRUE)
  }
  if (!file.exists(dest)) {
    message("Creating ", dest)
    dir.create(dest)
    files <- dir(location, all.files=TRUE, recursive=TRUE, full.names=TRUE)
    for (f in files) {
      message("Copying ", f)
      file.copy(f, dest, recursive=TRUE)
    }
  } else stop("File %s already exists", dest)
}

#' SentiStrength Data
#'
#' Returns the location of a specific language data.
#' @param datadir Name of the folder where the language data is stored
#'   inside the installed package.
#' @return The path to the data folder. Fails if it doesn't exist.
#' @seealso AddSentiStrengthData
#' @export
SentiStrengthData <- function(datadir) {
  system.file("sentistrength", datadir,
              package="RSentiStrength", mustWork=TRUE)
}
