## name: plot_fig3.r
## date: 02/07/2018

source("my_palette.r")
source("multiplot.R")

set.seed(449)

# avg
dat1=c(rnorm(10000,mean=-90,sd=20),rnorm(40000,mean=-40,sd=10),
    rnorm(50000,mean=30,sd=15),rnorm(10000,mean=90,sd=20))
x0=-100:100
y0=table(cut(dat1,
    breaks=seq(-101,100,1)))
tmp = smooth.spline(x0, y0, spar=0.35) # smooth spline
x1=tmp$x;y1=tmp$y
y1=y1/1000+1.5

# query
dat2=c(rnorm(10000,mean=-80,sd=20),rnorm(60000,mean=-50,sd=10),
    rnorm(50000,mean=30,sd=20),rnorm(10000,mean=95,sd=20))
x0=-100:100
y0=table(cut(dat2,
    breaks=seq(-101,100,1)))
tmp = smooth.spline(x0, y0, spar=0.35)
x2=tmp$x;y2=tmp$y
y2=y2/1000+1.2

ymin1=min(y1); xmin1=x1[y1==ymin1]
ymin2=min(y2); xmin2=x2[y2==ymin2]
ymax1=max(y1); xmax1=x1[y1==ymax1]
ymax2=max(y2); xmax2=x2[y2==ymax2]
ymean1=mean(y1)+0.2; ymean2=mean(y2)+0.1

# largespace
dat3=c(rnorm(30000,mean=-750,sd=20),rnorm(20000,mean=-690,sd=10),
    rnorm(20000,mean=-650,sd=10),rnorm(30000,mean=-550,sd=30),
    rnorm(40000,mean=-400,sd=10),rnorm(10000,mean=-380,sd=10),
    rnorm(20000,mean=-300,sd=40),rnorm(30000,mean=-340,sd=25),
    rnorm(30000,mean=-290,sd=20),rnorm(10000,mean=-240,sd=5),
    rnorm(10000,mean=-210,sd=20),rnorm(40000,mean=-160,sd=30),
    rnorm(10000,mean=-80,sd=20),rnorm(60000,mean=-50,sd=10),
    rnorm(50000,mean=30,sd=20),rnorm(10000,mean=95,sd=20),
    rnorm(40000,mean=200,sd=20),rnorm(20000,mean=130,sd=30),
    rnorm(20000,mean=270,sd=50),rnorm(30000,mean=220,sd=50),
    rnorm(40000,mean=310,sd=10),rnorm(10000,mean=360,sd=5),
    rnorm(40000,mean=420,sd=30),rnorm(20000,mean=380,sd=10),
    rnorm(30000,mean=650,sd=20),rnorm(30000,mean=540,sd=20),
    rnorm(40000,mean=750,sd=30),rnorm(20000,mean=720,sd=25))
x0=-750:750
y0=table(cut(dat3,
    breaks=seq(-751,750,1)))
tmp = smooth.spline(x0, y0, spar=0.35)
x3=tmp$x;y3=tmp$y
y3=y3/1000+1.2

# anchor
y3_order=sort(y3)
z3_order=y3_order - 0.8 + 
    c(seq(0,0.4,0.001),seq(0.4,-0.3,-0.0015),seq(-0.3,0.5,0.0004))[1:1501]
z3=z3_order
z3[order(y3)]=sort(z3_order)

############### plot #################3
pdf("figure/fig3_anchor.pdf",width=10,height=8)
layout(cbind(matrix(c(rep(1,9*5),rep(2,9*5),rep(3,9*4)),nrow=14,byrow=T),
    matrix(c(rep(4,3*2),rep(5,3*2),rep(6,3*2),rep(7,3*2),rep(8,3*2),rep(9,3*3),rep(0,3*1)),nrow=14,byrow=T)))

par(mar=c(5,4,4,2)+0.1)

plot(x1,y1,type="l",ylim=c(1,4),col=my_palette["orange"],lwd=3,
    main="DNase-seq Feature",
    xlab="Distance to Target Interval Center (bp)",ylab="DNase-seq Signal")
points(x2,y2,type="l",col=my_palette["blue"],lwd=3)
avg1=mean(y1)+0.2
avg2=mean(y2)+0.1
segments(x0=-100,y0=avg1,x1=100,y1=avg1,col=my_palette["orange"],lty=2,)
segments(x0=-100,y0=avg2,x1=100,y1=avg2,col=my_palette["blue"],lty=2)
legend("topright",legend=c("query","average"),col=my_palette[c("blue","orange")],
    lty=1,cex=1)
text(x=xmax2,y=ymax2,pos=3,offset=0.2,labels="Max",col=my_palette["blue"])
text(x=xmin2,y=ymin2,pos=1,offset=0.3,labels="Min",col=my_palette["blue"])
text(x=81,y=ymean2,pos=1,offset=0.3,labels="Mean",col=my_palette["blue"])
arrows(x0=xmax2,y0=ymax2,x1=xmax2,y1=ymax1,col=my_palette["black"],lty=1,length=0.1,angle=20)
segments(x0=xmax2,y0=ymax1,x1=xmax1,y1=ymax1,col=my_palette["black"],lty=2)
text(x=xmax2,y=(ymax1+ymax2)/2,pos=4,offset=2,labels="D Max",col=my_palette["blue"])
arrows(x0=xmin2,y0=ymin2,x1=xmin2,y1=ymin1,col=my_palette["black"],lty=1,length=0.1,angle=20)
segments(x0=xmin2,y0=ymin1,x1=xmin1,y1=ymin1,col=my_palette["black"],lty=2)
text(x=xmin2,y=(ymin1+ymin2)/2,pos=4,offset=0.1,labels="D Min",col=my_palette["blue"])
arrows(x0=75,y0=ymean2,x1=75,y1=ymean1,col=my_palette["black"],lty=1,length=0.1,angle=20)
text(x=81,y=(ymean1+ymean2)/2,pos=4,offset=0,labels="D Mean",col=my_palette["blue"])

plot(x3,y3,type="l",ylim=c(0,4),col=my_palette["blue"],lwd=3,
    main="Anchoring DNase-seq Profile",
    xlab="Distance to Target Interval Center (bp)",ylab="DNase-seq Signal",xaxt='n')
points(x3,z3,type="l",col=paste0(my_palette["blue"],"80"),lty=2,lwd=2)
axis(side=1,at=seq(-750,750,50),labels=seq(-750,750,50),cex.axis=0.9,las=4)
segments(x0=-100,y0=-5,x1=-100,y1=5,col="grey50",lty=2,lwd=2)
segments(x0=100,y0=-5,x1=100,y1=5,col="grey50",lty=2,lwd=2)
legend("topright",legend=c("anchored","original"),
    col=c(my_palette[c("blue")],paste0(my_palette["blue"],"80")),
    lty=1:2)
arrows(x0=650,y0=z3[1401],x1=650,y1=y3[1401],col="gray50",lty=1,length=0.1,angle=20)
text(x=650,y=(z3[1401]+y3[1401])/2-0.2,pos=4,offset=0.1,labels="Anchoring",col="black",cex=0.7)
text(x=0,y=4,pos=1,offset=0,labels="Target",col="black",cex=1)

plot(0,xlim=c(-750,750),ylim=c(0,1.5),col="white",xaxt='n',yaxt='n',
    main="Features From Neighbors",
    xlab="Distance to Target Interval Center (bp)",ylab="")
axis(side=1,at=seq(-750,750,50),labels=seq(-750,750,50),cex.axis=0.9,las=2)
segments(x0=-100,y0=-5,x1=-100,y1=5,col="grey50",lty=2,lwd=2)
segments(x0=100,y0=-5,x1=100,y1=5,col="grey50",lty=2,lwd=2)
segments(x0=-100,y0=1.2,x1=100,y1=1.2,col=my_palette["blue"],lwd=3)
#text(x=0,y=1.4,pos=1,offset=0,labels="Target",col="black",cex=0.8)
j=0
for(i in seq(-750,550,100)){
    start=i
    end=i+200
    segments(x0=start,y0=1.4-j,x1=end,y1=1.4-j,col=my_palette["green"],lty=1,lwd=3)
    j=j+0.1
}
legend("topright",legend=c("target","neighbors"), lty=1, lwd=3,
    col=c(my_palette[c("blue")],my_palette["green"]))

par(mar=c(1,4,1,4)+0.1)

plot(x2,y2,type="l",ylim=c(0,5),col=my_palette["blue"],lwd=2,xlab="",ylab="",xaxt='n',yaxt='n')

plot(x1,y3[101:301],type="l",ylim=c(0,5),col=my_palette["blue"],lwd=2,xlab="",ylab="",xaxt='n',yaxt='n')

plot(x1,y1,type="l",ylim=c(0,5),col=my_palette["orange"],lwd=1,xlab="",ylab="",xaxt='n',yaxt='n')
points(x2,y2,type="l",col=my_palette["blue"],lwd=2)

plot(x1,y1,type="l",ylim=c(0,5),col=my_palette["orange"],lwd=1,xlab="",ylab="",xaxt='n',yaxt='n')
points(x2,y2*1.9-2,type="l",col=my_palette["blue"],lwd=2)

plot(x1,y1,type="l",ylim=c(0,5),col=my_palette["orange"],lwd=1,xlab="",ylab="",xaxt='n',yaxt='n')
points(x2,y2/3+1.2,type="l",col=my_palette["blue"],lwd=2)


heat_palette=colorRampPalette(c("white", my_palette["green"]))(11)
tmp1=c(4,3,6,4,7,10,8,10,9,10,7,3,6,4,3)+1
tmp2=c(4,5,3,5,2,3,2,4,2,5,4,2,6,4,3)+2

par(mar=c(5,4,4,2)+0.1)
plot(0,xlim=c(1,17),ylim=c(0,3),col="white",xaxt='n',yaxt='n', xlab="Distance to Target Interval Center (bp)",ylab="",bty='n',cex=0.5)
rect(xleft=16.2,ybottom=seq(0,0.9,0.1),xright=16.4,ytop=seq(0.1,1,0.1),border=F,col=heat_palette[-1])
rect(xleft=seq(1,15,1),ybottom=2,xright=seq(2,16,1),ytop=3,border=F,col=heat_palette[tmp1])
rect(xleft=seq(1,15,1),ybottom=0,xright=seq(2,16,1),ytop=1,border=F,col=heat_palette[tmp2])
axis(side=1,at=seq(1,15,1)+0.5,labels=c(seq(-650,-50,100),0,seq(50,650,100)),cex.axis=0.9,las=2,tick=F,line=F)
text(x=16.2,y=c(0,1),pos=4,offset=0.7,labels=c("closed","open"),col="black",cex=0.7)

dev.off()

par(mar=c(5,4,4,2)+0.1)


