library(XML)
library(httr)


get.userinfo <- function(username){
  if(username == "") return(NULL)
  user.url <- paste0("http://www.boardgamegeek.com/collection/user/",username)
  url.get <- GET(user.url)
  doc <- htmlParse(url.get)
  valid.check <- getNodeSet(doc, '//div[@class="messagebox error"]')
  if(length(valid.check) > 0){
    if(xmlValue(valid.check[[1]]) == "\n\t\tNo username specified.\n\t") return(NULL)
  }
  games <- getNodeSet(doc, '//table[@class="collection_table"]/tr[position()>1]/td/div[2]/a')
  games.names <- sapply(games, xmlValue)
  games.links <- sapply(games, function(x) xmlGetAttr(x, "href"))
  ratings <- getNodeSet(doc, '//table[@class="collection_table"]/tr[position()>1]/td[3]/div[2]/div/div|//table[@class="collection_table"]/tr[position()>1]/td[3]/div[2]/div/span')
  games.ratings <- sapply(ratings, xmlValue)
  out <- data.frame(name = games.names, game_id = sapply(strsplit(games.links, "/"), function(x) x[3]), link = games.links, rating = games.ratings)
  return(out)
}