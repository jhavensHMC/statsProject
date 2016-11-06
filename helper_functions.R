
createCollegePseudonyms <- function() {
  # these are the names we want
  rightNames <- c("cgu", "cmc", "cuc", "hmc", "kecksci", "kgi", "pitzer", "pomona", "scrippscollege")
  # creating a hash table of all possible college names
  pseudonyms <- new.env(hash=TRUE, parent=emptyenv(), size=30L)
  # known abbreviations
  assign("claremontmckenna", "cmc", pseudonyms)
  assign("cuc.claremont", "cuc", pseudonyms)
  assign("keck", "kecksci", pseudonyms)
  assign("ptz", "pitzer", pseudonyms)
  assign("pit", "pitzer", pseudonyms)
  assign("pom", "pomona", pseudonyms)
  assign("scr", "scrippscollege", pseudonyms)
  assign("-", "unknown", pseudonyms)
  # all the correct names should map to themselves
  lapply(1:length(rightNames), 
         function(i) assign(rightNames[i], rightNames[i], pseudonyms))
  return(pseudonyms)
}
pseudonyms <- createCollegePseudonyms()

getCollegePseudonym <- function(collegeID) {
  # all IDs should be lowercase
  collegeID <- tolower(collegeID)
  # remove .edu if present
  collegeID <- unlist(strsplit(collegeID, ".edu"))
  return(get(collegeID, pseudonyms))
}

getAllPseudonyms <- function(collegeNames) {
  # apply this to the whole column of a data frame
  unlist(lapply(collegeNames, getCollegePseudonym))
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