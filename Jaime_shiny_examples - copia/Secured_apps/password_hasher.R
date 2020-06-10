#### hash de passwords

# this library have allready some algorithms, more resistent to brute-force attacks
library(bcrypt)
#library(readxl)

# tenemos un archivo en el que estan los csv

users_passwords <- read.csv2("up.csv",header = FALSE)

hashed <- function(user,passwords)
{
  my_users = as.character(users_passwords[,1])
  my_password = as.character(users_passwords[,2])
  hashed_password <-  unlist(lapply(my_password,hashpw))
  
  hashedbase = cbind(my_users,hashed_password)
  
  write.csv2(hashedbase,"uph.csv",row.names = FALSE)
}



user = users_passwords[,1]
passwords = users_passwords[,2]

hashed(user,passwords)