#' Minimal hello world
#'
#' @param x Object to say hello to, defaults to "world"
#' @param return_val If true, return to new object, else print
#'
#' @return Optionally string, message output
#' @export
hello_world <- function(x = "world", return_val = TRUE) {
    msg = paste("hello", x)
    if (return_val) {
        return(msg)
    }
    else {
        print(msg)
    }
}
