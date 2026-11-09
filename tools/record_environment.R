#!/usr/bin/env Rscript
## Record the R environment this analysis runs in.
##
## Run this once, in a session that has the analysis packages installed. It
## needs NO analysis objects and reads no data, so it can be run at any time --
## unlike the `export-bundle` listing in analysis_v17.Rmd §0b, which also needs
## a completed run in the session.
##
## Writes, into the directory given as the first argument (default: env/):
##   package_versions.csv  one row per package, with NA where it is not installed
##   sessionInfo.txt       R version, platform, locale, attached and loaded packages
##   renv.lock             if renv is available
##
## The package list is derived from the documents themselves rather than typed:
## every `pkg::`, `library(pkg)` and `requireNamespace("pkg")` in every chunk of
## the five .Rmd files, minus base R. Add a dependency and this picks it up.

args   <- commandArgs(trailingOnly = TRUE)
OUT    <- if (length(args) >= 1) args[1] else "env"
ROOT   <- if (length(args) >= 2) args[2] else "."
dir.create(OUT, showWarnings = FALSE, recursive = TRUE)

rmds <- list.files(file.path(ROOT, c("analysis", "figures")), "\\.Rmd$", full.names = TRUE)
if (!length(rmds)) stop("no .Rmd files under ", ROOT, "/analysis or ", ROOT, "/figures")

collect <- function(f) {
  src  <- readLines(f, warn = FALSE)
  open <- grep("^```\\{r", src); close <- grep("^```$", src)
  code <- unlist(lapply(open, function(s) {
    e <- close[close > s][1]; if (is.na(e)) character(0) else src[(s + 1):(e - 1)]
  }))
  code <- code[!grepl("^\\s*#", code)]
  tx   <- gsub("\"[^\"]*\"", "", paste(code, collapse = "\n"))
  c(regmatches(tx, gregexpr("[A-Za-z][A-Za-z0-9.]*(?=:::?[A-Za-z.])", tx, perl = TRUE))[[1]],
    regmatches(tx, gregexpr("(?<=library\\()[A-Za-z][A-Za-z0-9.]*",   tx, perl = TRUE))[[1]],
    regmatches(tx, gregexpr("(?<=requireNamespace\\(\")[A-Za-z][A-Za-z0-9.]*", tx, perl = TRUE))[[1]])
}

base <- c(rownames(installed.packages(priority = "base")), "graphics")
PKGS <- sort(setdiff(unique(unlist(lapply(rmds, collect))), c(base, "tidyverse", "p")))
cat(length(PKGS), "packages found across", length(rmds), "documents\n")

ver <- vapply(PKGS, function(p)
  tryCatch(as.character(packageVersion(p)), error = function(e) NA_character_), "")
write.csv(data.frame(package = PKGS, version = unname(ver), row.names = NULL),
          file.path(OUT, "package_versions.csv"), row.names = FALSE)

miss <- PKGS[is.na(ver)]
if (length(miss))
  cat("NOT INSTALLED in this session (recorded as NA):\n  ",
      paste(miss, collapse = ", "), "\n", sep = "")

writeLines(capture.output(sessionInfo()), file.path(OUT, "sessionInfo.txt"))

if (requireNamespace("renv", quietly = TRUE)) {
  lf   <- file.path(OUT, "renv.lock")
  snap <- function(...) !inherits(
    try(renv::snapshot(lockfile = lf, packages = PKGS[!is.na(ver)],
                       prompt = FALSE, ...), silent = TRUE), "try-error")
  snap()
  ## renv aborts the snapshot when the library mixes Bioconductor releases --
  ## a real warning, but not a reason to ship no lockfile. The mixed library is
  ## what the analysis ran on, so record it and let the caveat travel with it:
  ## a restorer needs to know what was installed before they can know it is
  ## awkward to reinstall. force = TRUE skips only the pre-flight check.
  if (!file.exists(lf)) {
    if (snap(force = TRUE))
      cat("\nNOTE: renv pre-flight validation failed, so renv.lock was written\n",
          "  with force = TRUE. It records the library as it is, mixed\n",
          "  Bioconductor releases included. Read the warning above before\n",
          "  relying on renv::restore() from this lockfile.\n", sep = "")
  }
  if (!file.exists(lf)) cat("\nrenv.lock could not be written.\n")
} else {
  cat("renv not installed; renv.lock not written\n")
}

cat("written to ", normalizePath(OUT), "\n", sep = "")
