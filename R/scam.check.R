
scam.check <- function(b,rl.col=3,pch=".",...)
# takes a fitted scam object and produces some standard diagnostic plots
{   old.par<-par(mfrow=c(2,2))
    sc.name<-b$method
    qqnorm(residuals(b),pch=pch,...)
   ## qqnorm(residuals(b),...)
    qqline(residuals(b),col=rl.col,...)
    plot(b$linear.predictors,residuals(b),main="Resids vs. linear pred.",
         xlab="linear predictor",ylab="residuals",...);
    hist(residuals(b),xlab="Residuals",main="Histogram of residuals",...);
    plot(fitted(b),b$y,xlab="Fitted Values",ylab="Response",main="Response vs. Fitted Values",...)
    
    ## now summarize convergence information 
    cat("\nMethod:", b$method, "  Optimizer:", b$optimizer)
    if (b$optimizer[1] == "optim"){ 
        cat("\nOptim Method:", b$optim.method[1])
        if (is.na(b$optim.method[2]))
              cat("\n Finite-difference approximation of the GCV/UBRE gradient was used.")
    }
    if (!is.null(b$bfgs.info)) { ## summarize BFGS convergence information
        boi <- b$bfgs.info
        cat("\nNumber of iterations of smoothing parameter selection performed was",boi$iter,".")
        cat("\n",boi$conv,".",sep="")
        cat("\nGradient range: [",min(boi$grad),",",max(boi$grad),"]",sep="")
        cat("\n(score ",formatC(b$gcv.ubre, digits = 5)," & scale ",formatC(b$sig2, digits = 5),")",sep="")
     }
     else if (!is.null(b$optim.info)) { ## summarize optim() convergence information
        boi <- b$optim.info
        cat("\nNumber of iterations of smoothing parameter selection performed was",boi$iter[1],".")
        cat("\n",boi$conv,".",sep="")
        cat("\n(score ",formatC(b$gcv.ubre, digits = 5)," & scale ",formatC(b$sig2, digits = 5),")",sep="")
     }
     else if (!is.null(b$nlm.info)) { ## summarize nlm() convergence information
        boi <- b$nlm.info
        cat("\nNumber of iterations of smoothing parameter selection performed was",boi$iter,".")
        cat("\n",boi$conv,".",sep="")
        cat("\nGradient range: [",min(boi$grad),",",max(boi$grad),"]",sep="")
        cat("\n(score ",formatC(b$gcv.ubre, digits = 5)," & scale ",formatC(b$sig2, digits = 5),")",sep="")
     }
     else if (!is.null(b$efs.info)) { ## summarize 'efs' convergence information
        boi <- b$efs.info
        cat("\nNumber of iterations of smoothing parameter selection performed was",boi$iter[1],".")
        cat("\n",boi$conv,".",sep="")
        cat("\n(score ",formatC(b$gcv.ubre, digits = 5)," & scale ",formatC(b$sig2, digits = 5),")",sep="")
     }
     else {
       if (length(b$sp)==0) ## no sp's estimated  
        cat("\nModel required no smoothing parameter selection")
     }
    ## print the estimated smoothing parameters...
    if (length(b$sp)!=0)
        cat("\nThe optimal smoothing parameter(s):",round(b$sp,5),".")
    cat("\n")
    par(old.par)
}



