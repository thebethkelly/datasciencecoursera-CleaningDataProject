#Be more descriptive about the type of measurement for each variable.

ChangeMean2<-function(heading){
        if (grepl("mean\\(\\)",heading)==TRUE){
            b<-sub("mean\\(\\)","",heading)
            return(paste("Activity Means for Means of",b))
        }
        else if (grepl("meanFreq\\(\\)",heading)==TRUE){
            b<-sub("meanFreq\\(\\)","",heading)
            return(paste("Activity Means for Mean Freqs of",b))
        }
        else if (grepl("std\\(\\)",heading)==TRUE){     
            b<-sub("std\\(\\)","",heading)
            return(paste("Activity Means for Std Devs of",b))
        }
        else{return(heading)}
}

#Describe which direction the measurement is taken along, x-axis, y-axis, or z-axis.

Direction2<-function(heading){
        if(grepl("-X|-Y|-Z",heading)==TRUE){
            for (direction in c("X","Y","Z")){
                if(grepl(direction,heading)==TRUE){
                    c<-sub(direction,paste(" in the",direction,"direction"),heading)
                }
            }
        }
        else{
            c<-heading
        }
    c
}

#Remove dashes.

RemoveDashes2<-function(heading){
    gsub("-","",heading)
}

#Put them all together and loop through the list/variable names.

CleanNames<-function(list){
    a<-list()
    for (l in list){
        b<-ChangeMean2(l)%>%Direction2()%>%RemoveDashes2()
        a<-c(a,b)
    }
    a
}