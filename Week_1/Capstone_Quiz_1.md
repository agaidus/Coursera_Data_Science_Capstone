# Cousera Capstone Quiz 1
Andrew Gaidus  
Wednesday, April 20, 2016  

1) The en_US.blogs.txt  file is how many megabytes?


```r
file.info("Coursera-Swiftkey/final/en_US/en_US.blogs.txt")$size/ 1024^2
```

```
## [1] 200.4242
```

2) The en_US.twitter.txt has how many lines of text?


```r
twit_file <- readLines("Coursera-Swiftkey/final/en_US/en_US.twitter.txt")
length(twit_file)
```

```
## [1] 2360148
```

3) What is the length of the longest line seen in any of the three en_US data sets?

```r
blog_file <- readLines("Coursera-Swiftkey/final/en_US/en_US.blogs.txt")
news_file <- readLines("Coursera-Swiftkey/final/en_US/en_US.news.txt")

max(c(max(nchar(twit_file)),max(nchar(blog_file)),max(nchar(news_file))))
```

```
## [1] 40835
```

4) In the en_US twitter data set, if you divide the number of lines where the word "love" (all lowercase) occurs by the number of lines the word "hate" (all lowercase) occurs, about what do you get?


```r
love <- sum(grepl("love", twit_file))
hate <- sum(grepl("hate", twit_file))
love / hate
```

```
## [1] 4.108592
```

5) The one tweet in the en_US twitter data set that matches the word "biostats" says what?

```r
grep("biostats", twit_file, value=TRUE)
```

```
## [1] "i know how you feel.. i have biostats on tuesday and i have yet to study =/"
```

6)How many tweets have the exact characters "A computer once beat me at chess, but it was no match for me at kickboxing". (I.e. the line matches those characters exactly.)


```r
sum(grepl("A computer once beat me at chess, but it was no match for me at kickboxing", twit_file))
```

```
## [1] 3
```
