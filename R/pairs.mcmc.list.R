pairs.mcmc.list <-
function(x, n = 25, col = 1:length(x),
col.hist = "gold", col.image = terrain.colors(50),
density = TRUE, contour = TRUE, mean = TRUE, ...)
{
    #requireNamespace("MASS")
    ind <- t(matrix(1:(niter(x)*length(x)), niter(x), length(x)))
    dim(ind) <- NULL
    y <- as.matrix(x)[ind,]
    COL <- rep(col, niter(x))
    fun.lower0 <- function(x1, x2, ...) {
        d <- MASS::kde2d(x1, x2, n=n)
        if (density)
            image(d, col=col.image, add=TRUE)
        if (mean)
            abline(v=mean(x1),h=mean(x2))
        if (contour)
            contour(d,add=TRUE)
    }
    fun.upper <- function(x1, x2, ...) {
        if (mean)
            abline(v=mean(x1),h=mean(x2))
        points(x1,x2,col=COL,pch=".",...)
    }
    panel.hist.density <- function(x,...) {
        usr <- par("usr")
        on.exit(par(usr = usr))
        par(usr = c(usr[1:2], 0, 1.5) )
        h <- hist(x, n, plot = FALSE)
        breaks <- h$breaks
        nB <- length(breaks)
        y <- h$counts; y <- y/max(y)
        rect(breaks[-nB], 0, breaks[-1], y, col=col.hist, border=NA)
        d <- try(density(x,na.rm=TRUE,bw="nrd",adjust=1.2))
        if (!inherits(d, "try-error")) {
            d$y <- d$y/max(d$y)
            lines(c(mean(x),mean(x)), c(0,1))
            lines(d)
        }
        rug(x, side=3)
    }
    fun.lower <- if (contour || density)
        fun.lower0 else fun.upper
    pairs.default(y, labels=varnames(x), lower.panel=fun.lower,
        upper.panel=fun.upper, diag.panel=panel.hist.density)
    invisible(NULL)
}
