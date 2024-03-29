dc.fit <-
function(data, params, model, inits, n.clones, multiply=NULL, unchanged=NULL,
update=NULL, updatefun=NULL, initsfun=NULL,
flavour = c("jags", "bugs", "stan"),
n.chains=3, return.all=FALSE, check.nclones=TRUE, ...)
{
    dclone::.dcFit(data, params, model, inits, n.clones,
        multiply=multiply, unchanged=unchanged,
        update=update, updatefun=updatefun,
        initsfun=initsfun, flavour = flavour,
        cl=NULL, parchains=FALSE, n.chains=n.chains,
        return.all=return.all, check.nclones=check.nclones, ...)
}
