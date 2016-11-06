
getCollegePseudonyms <- function() {
  # using an environment bc performance like a hash table
  collegePseudonyms <- new.env()
  
  x <- c("cgu", "cmc", "cuc", "hmc", 
         "kecksci", "kgi", "pitzer", "pomona", "scrippscollege")
}

checkIfNoEndDate <- function(info) {
  # String for no end date is "No Session End Date"
  #  but this gets split by spaces
  if ((info == "No") || (info == "Session")) {
    return("NA")
  }
  else {
    return(info)
  }
}

importEzproxy <- function(filename) {
  # read in data, fix column names
  dataFrame <- read.csv(filename, header = FALSE)
  fileLength <- length(dataFrame[,1])
  colnames(dataFrame) <- c("hashedID", "campus", "allDateTime", "sessionID", "IP" )
  
  dateInfo <- lapply(1:fileLength, 
                      function(i) unlist(strsplit(toString(dataFrame$allDateTime[i]), " ")))
  dataFrame$startDate <- unlist(lapply(1:fileLength, 
                                       function(i) dateInfo[[i]][1]))
  dataFrame$startTime <- unlist(lapply(1:fileLength, 
                                       function(i) dateInfo[[i]][2]))

  # fixing date info (separated by spaces, not tabs)
  dataFrame$endDate <- unlist(lapply(1:fileLength, 
                                     function(i) checkIfNoEndDate(dateInfo[[i]][3])))
  dataFrame$endTime <- unlist(lapply(1:fileLength, 
                                     function(i) checkIfNoEndDate(dateInfo[[i]][4])))

  return(dataFrame)
}


dataFrame <- importEzproxy("ccl201601_report_hashed.txt")

identifyCollege <- function(collegeName) {
  
}