## ------------------------------------------------------------------------
decimate <- function(x, dec = 10) {
  library(raster)
  r0 <- raster(x)
  res(r0) <- res(x) * dec
  setValues(r0, extract(x, coordinates(r0), method = "bilinear"))
}
library(quadmesh)
library(rglwidget)
library(rgl)
scl <- function(x) (x - min(x))/diff(range(x))
data(etopo)
etopo <- decimate(etopo, 5)
qmtopo <- quadmesh(etopo, etopo)
open3d()
shade3d(qmtopo, col = grey(scl(qmtopo$vb[3,qmtopo$ib])), asp = c(1, 1, 0.0001))

aspect3d(1, 1, 0.1)

subid <- currentSubscene3d()
rglwidget(elementId="quadmesh003")

## ------------------------------------------------------------------------
library(proj4)
qmtopo$vb[1:2, ] <- t(proj4::project(t(qmtopo$vb[1:2, ]), "+proj=laea +ellps=WGS84 +lat_0=-90"))
open3d()
shade3d(qmtopo, col = grey(scl(qmtopo$vb[3,qmtopo$ib])))
aspect3d(1, 1, .1)
subid <- currentSubscene3d()
rglwidget(elementId="quadmesh004")

lltopo <- quadmesh(etopo, etopo)
lltopo$vb[1:3, ] <- t(llh2xyz(t(lltopo$vb[1:3, ]), exag = 50))
shade3d(lltopo, col = grey(scl(qmtopo$vb[3,lltopo$ib])))


## ------------------------------------------------------------------------
data(etopo)
lt <- crop(etopo, extent(100, 168, -58, -40))
ltt <- ltt0 <- quadmesh(lt, lt)
ltt$vb[1:3, ] <- t(llh2xyz(t(ltt$vb[1:3, ])))
shade3d(ltt, col = grey(scl(ltt0$vb[3,ltt$ib])))

