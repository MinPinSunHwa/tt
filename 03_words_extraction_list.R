

#------------------------------------------------------------------
#                      ���̺귯�� �ҷ�����
#------------------------------------------------------------------
library(stringr)
library(dplyr)



#------------------------------------------------------------------
#                        ������ �ҷ�����
#------------------------------------------------------------------
load("science_IT_data/2017_4Q_words.RData")



#------------------------------------------------------------------
#               list ���·� NC, F ���¸� ����
#------------------------------------------------------------------
# NC, F ���¸� ���� 
words_pre <- sapply(Q4_words, function(x) str_match(x, "([0-9a-zA-Z��-�R]+)/(NC|F)"))


# ���� �м� ���� �� �ɷ�����
c <- c()
for (i in 1:length(words_pre)) {
  words <- words_pre[[i]]
  tryCatch(w <- words[,2],
           error=function(e) {
             c[length(c)+1] <<- i
             message(e)
           })
}
words_pre <- words_pre[-c]


# NC, F ���� ���� ����
words_NC <- sapply(words_pre, function(x) Filter(function(y) !is.na(y), x[,2]))



#------------------------------------------------------------------
#                     ���� �ǹ��� �ܾ� ����
#------------------------------------------------------------------
words_NC <- sapply(words_NC, toupper)
words_NC <- sapply(words_NC, function(x) gsub("��S","������S", x))
words_NC <- sapply(words_NC, function(x) gsub("(������S[0-9]).*","\\1", x))
words_NC <- sapply(words_NC, function(x) gsub("^(S[0-9]).*","������\\1", x))
words_NC <- sapply(words_NC, function(x) gsub("����Ʈ", "�����ó�Ʈ", x))
words_NC <- sapply(words_NC, function(x) gsub("(�����ó�Ʈ[0-9]).*","\\1", x))
words_NC <- sapply(words_NC, function(x) gsub("^(��Ʈ[0-9]).*","������\\1", x))
words_NC <- sapply(words_NC, function(x) gsub("(G[0-9]{1,2}).", "\\1", x))
words_NC <- sapply(words_NC, function(x) gsub("(V[0-9]{1,2}).", "\\1", x))
words_NC <- sapply(words_NC, function(x) gsub("(������[0-9]).", "\\1", x))
words_NC <- sapply(words_NC, function(x) gsub("����Ͽ�����׷���", "MWC", x))
words_NC <- sapply(words_NC, function(x) gsub("����", "NASA", x))
words_NC <- sapply(words_NC, function(x) gsub("������", "DNA", x))
words_NC <- sapply(words_NC, function(x) gsub("�޴���ȭ", "�޴���", x))
words_NC <- sapply(words_NC, function(x) gsub("������ű��", "ICT", x))
words_NC <- sapply(words_NC, function(x) gsub("DRONE", "���", x))
words_NC <- sapply(words_NC, function(x) gsub("���ҿ������", "LTE", x))
words_NC <- sapply(words_NC, function(x) gsub("��Ƽ��", "LTE", x))
words_NC <- sapply(words_NC, function(x) gsub("4���������.", "4���������", x))
words_NC <- sapply(words_NC, function(x) gsub("���İ�.", "���İ�", x))
words_NC <- sapply(words_NC, function(x) gsub("�߻簡", "�߻�", x))
words_NC <- sapply(words_NC, function(x) gsub("MP3�÷��̾�", "MP3", x))
words_NC <- sapply(words_NC, function(x) gsub("������DMB", "DMB", x))
words_NC <- sapply(words_NC, function(x) gsub("���ڽŹ����ͳ�", "���ڽŹ�", x))
words_NC <- sapply(words_NC, function(x) gsub("�繰���ͳ�", "IOT", x))
words_NC <- sapply(words_NC, function(x) gsub("��������", "VR", x))
words_NC <- sapply(words_NC, function(x) gsub("��������", "AR", x))
words_NC <- sapply(words_NC, function(x) gsub("����߱����̿���", "OLED", x))
words_NC <- sapply(words_NC, function(x) gsub("AI", "�ΰ�����", x))


#------------------------------------------------------------------
#                 �ҿ�� ����Ʈ�� �ִ� �ܾ� ����
#------------------------------------------------------------------
# �ҿ�� ����Ʈ �ҷ�����
remove_list <- read.table("science_IT_data/remove_list.txt", header=T)
remove_list <- unlist(remove_list)
remove_list <- as.character(remove_list)


# �ҿ�� ����
remove_list <- sort(remove_list, decreasing=T)
r <- length(remove_list)

for(i in 1:r){
  word <- remove_list[i]
  
  words_NC <- sapply(words_NC, function(x) gsub(word,"", x))
  words_NC <- sapply(words_NC, 
                     function(x) Filter(function(y) {nchar(y) >= 1}, x))
  
  cat(i,".",word,"remove.\n")
}



#------------------------------------------------------------------
#                        ������ ����
#------------------------------------------------------------------
Q4_words_NC <- words_NC
save(Q4_words_NC, file="science_IT_data/2017/2017_4Q_words_NC.RData")



#------------------------------------------------------------------
#                �ӽ������� ������ �ҷ�����
#------------------------------------------------------------------
load("science_IT_data/2017/2017_4Q_words_NC.RData")
words_NC <- Q4_words_NC



rm(Q1_words)
rm(Q1_words_NC)
rm(list=ls())