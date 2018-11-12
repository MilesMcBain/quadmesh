

quad <- function(x, ...) {
  UseMethod("quad")
}
quad.default <- function(x, ...) {
  dm <- qdim(x)
  ex <- qextent(x)
        tibble::tibble(xmn = ex["xmin"], xmx = ex["xmax"],
                       ymn = ex["ymin"], ymx = ex["ymax"],
                       nrows = dm[1], ncols = dm[2], crs = qproj(x))
}
qproj <- function(x) {
  UseMethod("qproj")
}
qproj.topo <- function(x) {
  "+init=epsg:4326"
}
qproj.BasicRaster <- function(x) {
  x@crs@projargs
}
qdim <- function(x) {
  UseMethod("qdim")
}
qdim.topo <- function(x) {
  dim(x@data$z)
}
qdim.BasicRaster <- function(x) {
  c(x@nrows, x@ncols)
}
qextent <- function(x) {
  UseMethod("qextent")
}
qextent.topo <- function(x) {
  x <- x@data$longitude
  y <- x@data$latitude
  ext <- c(range(x), range(y))
  dx <- diff(x[1:2])
  dy <- diff(y[1:2])
  ext <- ext + c(c(-1, 1) * dx/2, c(-1, -1) * dy/2)
  names(ext) <- c("xmin", "xmax", "ymin", "ymax")
  ext
}
qextent.BasicRaster <- function(x) {
  c(xmin = raster::xmin(x),
    xmax = raster::xmax(x),
    ymin = raster::ymin(x),
    ymax = raster::ymax(x))
}
